require 'rubygems'
require 'bundler/setup'
require 'zeitwerk'
require 'interactor'
# Bundler.setup
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib")
loader.setup