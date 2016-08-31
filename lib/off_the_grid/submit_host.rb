module OffTheGrid
  class SubmitHost < Host
    # Get the list of SGE submit hosts
    def self.list
      `qconf -ss`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -ss #{name}`.chomp
    end

    private

    # Add an SGE submit host
    def add
      system("qconf -as #{hostname}")
    end

    # Remove an SGE submit host
    def remove
      system("qconf -ds #{hostname}")
    end
  end
end
