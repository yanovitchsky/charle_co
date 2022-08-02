require 'bundler'
require 'zeitwerk'
Bundler.setup
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib")
loader.setup