include Rake::DSL

require "bundler"
Bundler::GemHelper.install_tasks

desc "Run tests"
task :test do
  system "ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/livechat/*_test.rb test/livechat/**/*_test.rb"
end

task :default => :test

desc "Run irb with livechat client lib loaded"
task :console do
  sh "irb -I lib -r ./lib/livechat.rb"
end

namespace :doc do
  require "yard"
  YARD::Rake::YardocTask.new do |t|
    t.files = ["lib/**/*.rb"]
    t.options = [
      "--protected",
      "--output-dir", "doc/yard",
      "--markup", "markdown"
    ]
  end
end
