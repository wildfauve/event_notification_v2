module Mappers

  class MapperFactory

    def call(event)
      Container.resolve(mapper_slug(event.kind))
    end

    def mapper_slug(kind)
      "mappers.#{kind.gsub(".","_")}_mapper"
    end

  end

end
