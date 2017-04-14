# frozen_string_literal: true

module OffTheGrid
  # ERB related helper methods
  module ErbHelpers
    def render(template_data)
      ERB.new(template_data.gsub(/^(\t|\s)+<%/, '<%'), 0, '<>').result(binding)
    end
  end
end
