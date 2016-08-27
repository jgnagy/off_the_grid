module OffTheGrid
  module ErbHelpers
    def render(template_data)
      ERB.new(template_data.gsub(/^(\t|\s)+<%/, '<%'), 0, "<>").result(binding)
    end
  end
end
