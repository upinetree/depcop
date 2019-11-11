lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "depcop/version"

Gem::Specification.new do |spec|
  spec.name = "depcop"
  spec.version = Depcop::VERSION
  spec.authors = ["upinetree"]
  spec.email = ["upinetree@gmail.com"]

  spec.summary = %q{A ruby code dependency checking tool.}
  spec.description = %q{A ruby code dependency checking tool that measures quality metrics for each classes.}
  spec.homepage = "https://github.com/upinetree/depcop"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/upinetree/depcop"
  spec.metadata["changelog_uri"] = "https://github.com/upinetree/depcop/commits/master"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17.0", ">= 2.0.0"
  spec.add_development_dependency "rake"
end
