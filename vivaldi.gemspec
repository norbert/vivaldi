Gem::Specification.new do |s|
  s.name        = "vivaldi"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Norbert Crombach"]
  s.email       = ["norbert.crombach@primetheory.org"]
  s.homepage    = "http://github.com/norbert/vivaldi"
  s.summary     = %q{Consolidated metrics for Ruby/Rails applications.}

  s.rubyforge_project = "vivaldi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^test\//)
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rails', '~> 3.2'
  s.add_development_dependency 'statsd-ruby'
  s.add_development_dependency 'logging'
  s.add_development_dependency 'rack-statsd'
end
