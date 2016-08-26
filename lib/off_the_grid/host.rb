module OffTheGrid
  class Host
    attr_reader :hostname
    include GridResource

    def initialize(hostname)
      @hostname = hostname
    end

    def new?
      !self.class.list.map(&:hostname).include?(hostname)
    end
  end
end
