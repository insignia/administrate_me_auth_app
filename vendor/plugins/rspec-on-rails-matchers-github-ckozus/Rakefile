require 'rake'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

task :default => [:spec, :verify_rcov]

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec_helper.rb,_spec.rb']
end

desc "Make sure coverage is 100%"
RCov::VerifyTask.new(:verify_rcov) do |t|
  t.threshold = 100.0
  t.index_html = 'coverage/index.html'
end