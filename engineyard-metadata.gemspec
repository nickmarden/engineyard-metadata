# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{engineyard-metadata}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Seamus Abshere"]
  s.date = %q{2010-10-11}
  s.description = %q{Pulls metadata from EC2 and EngineYard so that your EngineYard AppCloud (Amazon EC2) instances know about each other.}
  s.email = %q{seamus@abshere.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "engineyard-metadata.gemspec",
     "lib/engineyard-metadata.rb",
     "lib/engineyard-metadata/amazon_ec2_api.rb",
     "lib/engineyard-metadata/chef_dna.rb",
     "lib/engineyard-metadata/metadata.rb",
     "spec/metadata_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/dna.json"
  ]
  s.homepage = %q{http://github.com/seamusabshere/engineyard-metadata}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Make your EngineYard AppCloud (Amazon EC2) instances aware of each other.}
  s.test_files = [
    "spec/metadata_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<fakefs>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 1"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<fakefs>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 1"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.4"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<fakefs>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 1"])
  end
end

