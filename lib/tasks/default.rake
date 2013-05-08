if default = Rake.application.instance_variable_get('@tasks')['default']
  default.prerequisites.delete('test')

  # Do not touch it, It requred to run RSpec BEFORE Cucumber
  default.prerequisites.unshift('cucumber')
  default.prerequisites.unshift('spec')
end



