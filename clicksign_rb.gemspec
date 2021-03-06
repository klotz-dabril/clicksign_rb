# frozen_string_literal: true

require_relative "lib/clicksign_rb/version"

Gem::Specification.new do |spec|
  spec.name          = "clicksign_rb"
  spec.version       = ClicksignRb::VERSION
  spec.authors       = ["Otto Raphael Klotz D'Abril"]
  # spec.email         = ["klotz.dabril@gmail.com"]

  spec.summary       = "Clicksign rest api interface."
  # spec.description   = "TODO: Write a longer description or delete this line."
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  # spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0.18'
  spec.add_dependency 'thor',     '~> 1.0'

  spec.add_development_dependency "pry",     "~> 0.14"
  spec.add_development_dependency "rspec",   "~> 3.10"
  spec.add_development_dependency 'vcr',     '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.10'
end
