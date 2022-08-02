require_relative './application.rb'
require 'json'


def output_result(hash)
  path = File.join(File.dirname(__FILE__), 'data/output.json')
  File.open(path, 'w') { |f| f.write(JSON.generate(hash))}
end

def read_input
  path = File.join(File.dirname(__FILE__), 'data/input.json')
  file = File.open(path, 'r')
  JSON.parse(file.read, symbolize_names: true)
end


def run
  result = Operations::OrderRentals.call(params: read_input)
  output = Presenters::Collection.new(
    result.rentals,
    presenter: Presenters::Action,
    key: :rentals
  ).present
  output_result(output)
end

run