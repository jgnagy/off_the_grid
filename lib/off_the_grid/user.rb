module OffTheGrid
  class User
    attr_reader :name
    include GridResource
  end
end
