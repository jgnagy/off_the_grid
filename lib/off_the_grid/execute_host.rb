module OffTheGrid
  class ExecuteHost < Host
    # Get the list of SGE execute hosts
    def self.list
      `qconf -sel`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    private

    # TODO add #add()

    # Remove an SGE execution host
    def remove
      system("qconf -de #{hostname}")
    end
  end
end
