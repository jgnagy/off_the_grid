module OffTheGrid
  module GridResource
    include Comparable

    def initalize(name)
      @name = name
    end

    def self.list
      []
    end

    def new?
      !self.class.list.map(&:name).include?(name)
    end

    def save(safe = true)
      if safe
        raise "Validation Failed" unless validate_before_save
        add
      else
        add # don't bother checking if the host exists
      end
    end

    def delete(safe = true)
      if safe
        raise "Validation Failed" unless validate_before_delete
        remove
      else
        remove # don't bother checking if the host exists
      end
    end

    def validate_before_save
      new?
    end

    def validate_before_delete
      !new?
    end

    def <=>(other)
      name <=> other.name
    end
  end
end
