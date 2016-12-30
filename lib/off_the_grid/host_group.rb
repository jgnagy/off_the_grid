module OffTheGrid
  class HostGroup < NamedResource
    # Get the list of SGE host groups
    def self.list
      `qconf -shgrpl`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -shgrp #{name}`.chomp
    end

    def as_tree
      `qconf -shgrp_tree #{name}`.chomp
    end

    def hosts
      extract_detail(:hostlist).map {|host| ExecuteHost.new(host) }
    end

    # TODO Adding a Host to a HostGroup...

    private

    # Add an SGE host group
    def add
      system("qconf -ahgrp #{name}")
    end

    # Remove an SGE host group
    def remove
      system("qconf -dhgrp #{name}")
    end
  end
end
