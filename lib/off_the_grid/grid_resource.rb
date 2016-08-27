module OffTheGrid
  module GridResource
    def initalize(name)
      @name = name
    end

    def self.list
      []
    end

    def new?
      !self.class.list.map(&:name).include?(hostname)
    end

    def save(safe = true)
      if safe
        new? ? add : false
      else
        add # don't bother checking if the host exists
      end
    end

    def delete(safe = true)
      if safe
        new? ? false : remove
      else
        remove # don't bother checking if the host exists
      end
    end
  end
end
