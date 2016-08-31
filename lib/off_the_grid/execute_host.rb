module OffTheGrid
  class ExecuteHost < Host
    # Get the list of SGE execute hosts
    def self.list
      `qconf -sel`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -se #{name}`.chomp
    end

    private

    # Add an SGE execution host
    def add
      # TODO construct a template
      Tempfile.open do |tmpfile|
        tmpfile.puts render(Templates::ExecuteHost::ERB)
        tmpfile.flush
        system("qconf -Ae #{tmpfile.path}")
        sleep 5
      end
    end

    # Remove an SGE execution host
    def remove
      system("qconf -de #{hostname}")
    end
  end
end
