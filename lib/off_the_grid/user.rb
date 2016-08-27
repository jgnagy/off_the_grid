module OffTheGrid
  class User
    attr_reader :name
    include GridResource

    # Get the list of SGE users
    def self.list
      `qconf -suserl`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -suser #{name}`.chomp
    end

    private

    # Add an SGE user
    def add
      # TODO add fake editor!!
      system("qconf -auser")
    end

    # Remove an SGE user
    def remove
      system("qconf -duser #{name}")
    end
  end
end
