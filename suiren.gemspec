# frozen_string_literal: true

require_relative "lib/suiren/version"

Gem::Specification.new do |spec|
  spec.name = "suiren"
  spec.version = Suiren::VERSION
  spec.authors = ["MURATA Mitsuharu"]
  spec.email = ["hikari.photon+dev@gmail.com"]

  spec.summary = "suiren is a command that displays the contents of http requests."
  spec.description = spec.summary
  spec.homepage = "https://github.com/Himeyama/suiren"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "rubocop", "~> 1.21"
end
