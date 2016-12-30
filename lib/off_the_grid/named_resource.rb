module OffTheGrid
  class NamedResource
    include GridResource

    attr_reader :name

    def initalize(name)
      @name = name
    end
  end
end
