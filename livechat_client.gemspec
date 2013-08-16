# -*- encoding: utf-8 -*-
require File.expand_path("../lib/livechat/version", __FILE__)

Gem::Specification.new do |g|
  g.add_development_dependency "yajl-ruby", "~> 0.8.2"
  g.add_development_dependency "nokogiri", "~> 1.4"
  g.add_development_dependency "rake", "~> 0.8"
  g.add_development_dependency "webmock", "~> 1.6"
  g.add_development_dependency "yard", "~> 0.7"
  g.add_development_dependency "minitest"
  g.add_development_dependency "pry"

  g.add_runtime_dependency "hashie", "~> 1.0.0"
  g.add_runtime_dependency "faraday", "~> 0.7.3"
  g.add_runtime_dependency "faraday_middleware", "0.7.0"
  g.add_runtime_dependency "multi_xml", "~> 0.2.0"
  g.add_runtime_dependency "multi_json", "~> 1.0.0"
  g.add_runtime_dependency "patron"

  g.authors = ["Alexandre Maia"]
  g.description = %q|A Ruby client for the Livechat REST API|
  g.email = ["alexandre.maia@gmail.com"]
  g.files = `git ls-files`.split("\n")
  g.homepage = "https://github.com/cxz/livechat_client"
  g.name = "livechat_client"
  g.require_paths = ["lib"]
  g.required_rubygems_version = Gem::Requirement.new(">= 1.3.6")
  g.summary = %q|A Ruby client for the Livechat REST API|
  g.test_files = `git ls-files -- test/*`.split("\n")
  g.version = Livechat::VERSION.dup
end
