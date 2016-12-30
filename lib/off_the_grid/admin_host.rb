module OffTheGrid
  # A class to represent SGE Admin Hosts
  class AdminHost < Host
    # Get the list of SGE adminstrative hosts
    def self.list
      `qconf -sh`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    private

    # Add an SGE administrative host
    def add
      system("qconf -ah #{hostname}")
    end

    # Remove an SGE administrative host
    def remove
      system("qconf -dh #{hostname}")
    end
  end
end
