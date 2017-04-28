module Schemas

  class SchemaCatalogue

    class << self

      def add(schema)
        catalogue[schema[:name]] = schema[:schema]
      end

      def catalogue
        @catalogue ||= {}
      end

      def call(event_name)
        catalogue[event_name]
      end

    end

  end

end
