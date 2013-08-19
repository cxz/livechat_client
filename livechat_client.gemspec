# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'livechat/version'

Gem::Specification.new do |g|
  g.name = "livechat_client"
  g.version = LiveChat::VERSION.dup
  g.platform = Gem::Platform::RUBY
  g.authors = ["Alexandre Maia"]
  g.email = ["alexandre.maia@gmail.com"]
  g.homepage = "https://github.com/cxz/livechat_client"
  g.summary = %q|LiveChat REST API Client|
  g.description = %q|Ruby wrapper for the REST API at http://developers.livechatinc.com/rest-api/|
  g.license = %q|MIT|

  g.required_ruby_version = ">= 1.8.7"
  g.required_rubygems_version = ">= 1.3.6"

  g.add_development_dependency "yajl-ruby"
  #g.add_development_dependency "nokogiri"
  g.add_development_dependency "rake"
  g.add_development_dependency "rspec"
  g.add_development_dependency "yard"
  g.add_development_dependency "minitest"
  g.add_development_dependency "pry"
  g.add_development_dependency "webmock", "~> 1.9.0"

  g.add_runtime_dependency "hashie", ">= 1.2"
  #g.add_runtime_dependency "faraday", ">= 0.8.0"
  #g.add_runtime_dependency "faraday_middleware", "0.8.7"
  g.add_runtime_dependency "multi_json"
  #g.add_runtime_dependency "patron"

  #g.files = `git ls-files -x Gemfile.lock`.split("\n") rescue ''
  #g.require_paths = ["lib"]
  #g.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

end
