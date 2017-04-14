# frozen_string_literal: true

module OffTheGrid
  # A base class for all resources keyed off of a #name attribute
  class NamedResource
    include GridResource

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
