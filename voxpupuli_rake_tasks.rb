desc 'Run acceptance tests'
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

desc 'Run tests release_checks'
task test: [
  :release_checks,
]

namespace :check do
  desc 'Check for trailing whitespace'
  task :trailing_whitespace do
    Dir.glob('**/*.md', File::FNM_DOTMATCH).sort.each do |filename|
      next if filename =~ %r{^((modules|acceptance|\.?vendor|spec/fixtures|pkg)/|REFERENCE.md)}
      File.foreach(filename).each_with_index do |line, index|
        if line =~ %r{\s\n$}
          puts "#{filename} has trailing whitespace on line #{index + 1}"
          exit 1
        end
      end
    end
  end
end
Rake::Task[:release_checks].enhance ['check:trailing_whitespace']

desc "Run main 'test' task and report merged results to coveralls"
task test_with_coveralls: [:test] do
  if Dir.exist?(File.expand_path('../lib', __FILE__))
    require 'coveralls/rake/task'
    Coveralls::RakeTask.new
    Rake::Task['coveralls:push'].invoke
  else
    puts 'Skipping reporting to coveralls.  Module has no lib dir'
  end
end

desc 'Print supported beaker sets'
task 'beaker_sets', [:directory] do |_t, args|
  directory = args[:directory]

  metadata = JSON.parse(File.read('metadata.json'))

  (metadata['operatingsystem_support'] || []).each do |os|
    (os['operatingsystemrelease'] || []).each do |release|
      beaker_set = if directory
                     "#{directory}/#{os['operatingsystem'].downcase}-#{release}"
                   else
                     "#{os['operatingsystem'].downcase}-#{release}-x64"
                   end

      filename = "spec/acceptance/nodesets/#{beaker_set}.yml"

      puts beaker_set if File.exist? filename
    end
  end
end
