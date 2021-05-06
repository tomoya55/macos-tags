require_relative 'lib/macos-tags/version'

Gem::Specification.new do |spec|
  spec.name          = "macos-tags"
  spec.version       = MacosTags::VERSION
  spec.authors       = ["Tomoya Hirano"]
  spec.email         = ["hiranotomoya@gmail.com"]

  spec.summary       = %q{Ruby interface to get macos Finder tags}
  spec.description   = %q{Ruby interface to get macos Finder tags}
  spec.homepage      = "https://github.com/tomoya55/macos-tags"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/tomoya55/macos-tags/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "ffi-xattr"
  spec.add_dependency "CFPropertyList"
  spec.add_dependency "rexml"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
