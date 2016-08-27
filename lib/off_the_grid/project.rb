module OffTheGrid
  class Project
    attr_reader :name
    include GridResource

    # Get the list of SGE projects
    def self.list
      `qconf -sprjl`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -sprj #{name}`.chomp
    end

    private

    # Add an SGE project
    def add
      # TODO add fake editor!!
      system("qconf -aprj")
    end

    # Remove an SGE project
    def remove
      system("qconf -dprj #{name}")
    end
  end
end
