module OffTheGrid
  # Handy helper methods for all Grid-related Resources
  # Serves as a mixable base
  module GridResource
    include Comparable

    def self.list
      []
    end

    def new?
      !self.class.list.map(&:name).include?(name)
    end

    def save(safe = true)
      raise 'Validation Failed' if safe && !validate_before_save
      add
    end

    def delete(safe = true)
      raise 'Validation Failed' if safe && !validate_before_delete
      remove
    end

    def extract_detail(detail, options = {})
      options[:split_on] ||= /,|\s/
      return [] unless respond_to?(:details)

      values = []
      details.split("\n").each do |line|
        unless values.empty?
          # Add follow-up lines from the weird word-wrapped output
          line =~ /^( ){8}/ ? values << line : break
        end
        values << line if line =~ /^#{detail.to_s} /
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
