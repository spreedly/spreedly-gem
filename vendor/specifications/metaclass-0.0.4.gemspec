# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "metaclass"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Mead"]
  s.date = "2014-02-20"
  s.email = ["james@floehopper.org"]
  s.homepage = "http://github.com/floehopper/metaclass"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "metaclass"
  s.rubygems_version = "1.8.23"
  s.summary = "Adds a metaclass method to all Ruby objects"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
