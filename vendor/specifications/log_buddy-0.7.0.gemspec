# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "log_buddy"
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Sanheim"]
  s.date = "2012-04-20"
  s.description = "Log statements along with their name easily.  Mixin a logger everywhere when you need it."
  s.email = ["rsanheim@gmail.com"]
  s.homepage = "http://github.com/relevance/log_buddy"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Log Buddy is your little development buddy."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<mocha>, ["~> 0.9"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<bundler>, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<mocha>, ["~> 0.9"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<bundler>, ["~> 1.1"])
  end
end
