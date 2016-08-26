module OffTheGrid
  class HostGroup
    attr_reader :name
    include GridResource

    def initalize(name)
      @name = name
    end

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

    def new?
      !self.class.list.map(&:name).include?(hostname)
    end

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
