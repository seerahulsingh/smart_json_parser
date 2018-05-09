
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smart_json_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "smart_json_parser"
  spec.version       = SmartJsonParser::VERSION
  spec.authors       = ["Rahul Singh"]
  spec.email         = ["singhrahulnow@gmail.com"]

  spec.summary       = %q{Parse json file and show value of selected attributes}
  spec.description   = %q{Parse json file and show value of selected attributes}
  
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
