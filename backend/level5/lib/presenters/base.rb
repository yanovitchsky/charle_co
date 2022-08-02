module Presenters
  class Base
    def initialize(object, presenter: nil, key: nil)
      @object = object
      @presenter = presenter
      @key = key || 'collection'
    end

    def present
      raise 'present called on parent.'
    end
  end
end