# frozen_string_literal: true

require_relative "suiren/version"
require "socket"
require "json"
require "stringio"
require "io/console/size"
require "i18n"

module Suiren
  class Error < StandardError; end

  class Suiren # rubocop:disable Style/Documentation
    def self.init_i18n
      I18n.load_path = ["#{__dir__}/translation.yml"]
      I18n.locale = :en
      I18n.locale = :ja if ENV["LANG"].downcase =~ /^ja/
      I18n.locale = :zh_TW if ENV["LANG"].downcase =~ /^zh_tw/
    end

    def initialize(host, port, content: "") # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      self.class.init_i18n

      begin
        server = TCPServer.new(host, port)
      rescue Errno::EADDRINUSE
        warn("\e[31;1m#{I18n.t("address_already")}\e[0m")
        exit(false)
      end

      puts(format("#{I18n.t("server_running")}\n\n", host, port))
      uplen = 0

      loop do # rubocop:disable Metrics/BlockLength
        begin
          client = server.accept
        rescue Interrupt
          exit true
        end

        http_text = client.readpartial(4096)
        io = StringIO.new(http_text)
        time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        request_line = io.gets

        max_key_len = 0
        max_value_len = 0
        headers = {}
        keys = []

        puts("\e[36m#{I18n.t("teception_time")}: \e[36;1m#{time}\e[0m")

        while (line = io.gets)
          break if line.strip.empty?

          match = line.match(/^(.+):\s(.+)$/)
          break unless match

          key = match[1].chomp
          keys.append(key)
          value = match[2].chomp
          max_key_len = key.size if max_key_len < key.size
          max_value_len = value.size if max_value_len < value.size
          headers[key.strip] = value.strip
        end

        _height, width = IO.console_size
        max_value_len_window = width - max_key_len - 7 # 2 列目の長さ (ウィンドウ制限)
        max_value_len = max_value_len_window if max_value_len > max_value_len_window

        request_line_format = "%-#{max_key_len + max_value_len + 3}s"
        puts "+#{"-" * (max_key_len + max_value_len + 5)}+"
        puts "| #{request_line_format % request_line.chop} |"
        key_format = "%-#{max_key_len}s"
        value_format = "%-#{max_value_len}s"
        border = "+#{"-" * (max_key_len + 2)}+#{"-" * (max_value_len + 2)}+"
        puts border
        keys.each do |key| # rubocop:disable Lint/ShadowingOuterLocalVariable
          keys_line = headers[key].scan(/.{1,#{max_value_len}}/)
          keys_line.each.with_index do |value_line, i|
            puts "| #{key_format % (i.eql?(0) ? key : "")} | #{value_format % value_line} |"
          end
          # puts "| #{key_format % key} | #{value_format % headers[key]} |"
        end
        puts "#{border}\n"
        body = "#{io.read}\n\n"
        puts body
        uplen = headers.size + 5 + body.lines.size

        client.print "HTTP/1.1 200 OK\r\n"
        client.print "Content-Type: text/plain; charset=\"UTF-8\"\r\n\r\n"
        client.print("#{content}\r\n") unless content.empty?
        client.close
      end
    end
  end
end
