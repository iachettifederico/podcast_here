# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'podcast_here/version'

Gem::Specification.new do |spec|
  spec.name          = "podcast_here"
  spec.version       = PodcastHere::VERSION
  spec.authors       = ["Federico Iachetti"]
  spec.email         = ["iachetti.federico@gmail.com"]

  spec.summary       = %q{Create an RSS feed with the contents of the current folder.}
  spec.description   = %q{Create an RSS feed with the contents of the current folder.}
  spec.homepage      = "https://github.com/iachettifederico/podcast_here"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "builder", "~> 3.2.3"
end