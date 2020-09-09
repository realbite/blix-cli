
require 'rake'
require_relative 'lib/blix/cli/version'

Gem::Specification.new do |s|
  s.name = 'blix-cli'
  s.description = %Q[Command line utilities for blix framework]
  s.summary = %Q[Command line utilities for managing  blix framework environments]
  s.version = Blix::Cli::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Clive Andrews']
  s.license = 'MIT'
  s.email = ['gems@realitybites.eu']
  s.homepage = 'https://github.com/realbite/blix-cli'
  s.add_dependency('thor')
  s.add_dependency('liquid')

  s.add_development_dependency('rspec')

  s.files = FileList['lib/**/*.rb' ].to_a
  s.files.concat FileList['templates/*' ].to_a
  s.files << 'bin/blix'
  s.files << 'LICENSE'
  s.files << 'README.md'

  s.extra_rdoc_files = ['README.md','LICENSE']
  s.require_paths = ['lib']
  s.executables << 'blix'
end
