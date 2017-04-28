module Mappers

  class Base

    class << self

      def map(args)
        mappings << args
      end

      def mappings
        @mappings ||= []
      end

    end  # class self

    def call(event, subscriber)
      binding.pry
      map(event, subscriber)
    end

    def map(event, subscriber)
      value = {}
      self.class.mappings.each do |mapping|
        from = mapping.keys.first
        property, property_value = self.send(from, mapping[from], event, subscriber)
        value[property] = property_value
      end
      OpenStruct.new value
    end

    def from_event(mapping, event, subscriber)
      [mapping[:prop].to_sym, event.send(mapping[:prop].to_sym)]
    end

    def from_subscriber(mapping, event, subscriber)
      [mapping[:prop].to_sym, subscriber.send(mapping[:prop].to_sym)]
    end


  end


end
