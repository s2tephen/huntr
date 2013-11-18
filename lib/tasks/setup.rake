require 'treat'

task :treat do
  Treat::Core::Installer.install 'english'
end