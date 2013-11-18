require 'treat'

desc 'This task installs the Treat NLP framework'
task :treat do
  Treat::Core::Installer.install 'english'
end