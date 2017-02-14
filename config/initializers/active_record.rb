module ActiveRecord
  module Timestamp      
    private
    def timestamp_attributes_for_update #:nodoc:
      [:updated_at, :updated_on, :modified_at]
    end
    def timestamp_attributes_for_create #:nodoc:
      [:inserted_at, :inserted_on]
    end      
  end
end
