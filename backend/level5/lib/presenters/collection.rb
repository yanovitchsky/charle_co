module Presenters
  class Collection < Base
    def present
      {
        @key.to_sym => @object.map { |o| @presenter.new(o).present }
      }
    end
  end
end