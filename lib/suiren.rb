# frozen_string_literal: true

require_relative "suiren/version"
require "socket"
require "json"
require "stringio"

module Suiren
  class Error < StandardError; end

  class Suiren # rubocop:disable Style/Documentation
    def initialize(host, port, content: "") # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      server = TCPServer.new(host, port)
      puts("サーバーが http://#{host}:#{port} で実行中です\n\n")
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

        puts("[#{time}]")
        while (line = io.gets)
          break if line.strip.empty?

          match = line.match(/^(.+):\s(.+)$/)
          break unless match

          key = match[1]
          keys.append(key)
          value = match[2]
          max_key_len = key.size if max_key_len < key.size
          max_value_len = value.size if max_value_len < value.size
          headers[key.strip] = value.strip
        end

        request_line_format = "%-#{max_key_len + max_value_len + 3}s"
        puts "+#{"-" * (max_key_len + max_value_len + 5)}+"
        puts "| #{request_line_format % request_line.chop} |"
        key_format = "%-#{max_key_len}s"
        value_format = "%-#{max_value_len}s"
        border = "+#{"-" * (max_key_len + 2)}+#{"-" * (max_value_len + 2)}+"
        puts border
        keys.each do |key| # rubocop:disable Lint/ShadowingOuterLocalVariable
          puts "| #{key_format % key} | #{value_format % headers[key]} |"
        end
        puts "#{border}\n"
        body = "#{io.read}\n"
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
