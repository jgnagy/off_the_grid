module OffTheGrid
  class Host
    attr_reader :hostname
    include GridResource

    def initialize(hostname)
      @hostname = hostname
    end

    def name
      hostname
    end

    def name=(hname)
      hostname = hname
    end
  end
end
