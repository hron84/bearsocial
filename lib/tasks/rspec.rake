require 'rspec/core/rake_task'

# Configuring default task moved to lib/tasks/default.rake

spec_prereq = Rails.configuration.generators.options[:rails][:orm] == :active_record ?  "test:prepare" : :noop

task :noop do
  # definitelly no-op.
end

task :stats => 'spec:statsetup'

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec => spec_prereq)

namespace :spec do
  def types
    dirs = Dir['./spec/**/*_spec.rb'].map { |f| f.sub(/^\.\/(spec\/\w+)\/.*/, '\\1') }.uniq
    Hash[dirs.map { |d| [d.split('/').last, d] }]
  end

  types.each do |type, dir|
    desc "Run the code examples in #{dir}"
    RSpec::Core::RakeTask.new(type => spec_prereq) do |t|
      t.pattern = "./#{dir}/**/*_spec.rb"
    end
  end

  task :statsetup do
    require 'rails/code_statistics'
    types.each do |type, dir|
      name = type.singularize.capitalize

      ::STATS_DIRECTORIES << ["#{name} specs", dir]
      ::CodeStatistics::TEST_TYPES << "#{name} specs"
    end
  end
end

