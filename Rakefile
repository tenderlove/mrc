# -*- ruby -*-

require 'rubygems'
require 'hoe'

GENERATED_PARSER    = "lib/mrc/parser.rb"
GENERATED_TOKENIZER = "lib/mrc/tokenizer.rb"

Hoe.spec 'mrc' do
  developer('Aaron Patterson', 'aaron@tenderlovemaking.com')
  self.readme_file   = 'README.rdoc'
  self.history_file  = 'CHANGELOG.rdoc'
  self.extra_rdoc_files  = FileList['*.rdoc']
end

file GENERATED_PARSER => "lib/mrc/parser.y" do |t|
  begin
    racc = Config::CONFIG['target_os'] =~ /mswin32/ ? '' : `which racc`.strip
    racc = "#{::Config::CONFIG['bindir']}/racc" if racc.empty?
    sh "#{racc} -l -o #{t.name} #{t.prerequisites.first}"
  rescue
    abort "need racc, sudo gem install racc"
  end
end

file GENERATED_TOKENIZER => "lib/mrc/tokenizer.rex" do |t|
  begin
    sh "rex --independent -o #{t.name} #{t.prerequisites.first}"
  rescue
    abort "need rexical, sudo gem install rexical"
  end
end

[:test, :check_manifest].each do |task_name|
  if Rake::Task[task_name]
    Rake::Task[task_name].prerequisites << GENERATED_PARSER
    Rake::Task[task_name].prerequisites << GENERATED_TOKENIZER
  end
end

# vim: syntax=ruby
