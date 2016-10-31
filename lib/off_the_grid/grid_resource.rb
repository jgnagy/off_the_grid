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
        add # don't bother checking if the resource exists
      end
    end

    def delete(safe = true)
      if safe
        raise "Validation Failed" unless validate_before_delete
        remove
      else
        remove # don't bother checking if the resource exists
      end
    end

    def extract_detail(detail, options = {})
      options[:split_on] ||= /,|\s/
      return [] unless respond_to?(:details)

      values = []
      details.split("\n").each do |line|
        if values.size > 0
          # Add follow-up lines from the weird word-wrapped output
          line.match(/^( ){8}/) ? values << line : break
        end
        values << line if line.match /^#{detail.to_s} /
      end
      values.join
            .gsub(/(#{detail.to_s} |\\|\s{2,})/, '')
            .split(options[:split_on])
            .uniq - ['']
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
