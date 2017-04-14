# frozen_string_literal: true

module OffTheGrid
  # A class to represent SGE Host Groups
  class HostGroup < NamedResource
    # Get the list of SGE host groups
    def self.list
      `qconf -shgrpl`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    def details
      `qconf -shgrp #{name}`.chomp
    end

    def as_tree
      `qconf -shgrp_tree #{name}`.chomp
    end

    # Direct entries in this HostGroup's hostlist attribute
    def entries
      extract_detail(:hostlist).map do |host|
        host =~ /^@/ ? HostGroup.new(host) : ExecuteHost.new(host)
      end
    end

    # A recursive listing of all hosts associated with this HostGroup
    def hosts
      entries.map do |entry|
        entry.is_a?(HostGroup) ? entry.hosts : entry
      end.flatten.uniq
    end

    def add_host(host)
      @hostlist = entries
      return true if @hostlist.include?(host)

      @hostlist << host
      # TODO: construct a template
      Tempfile.open do |tmpfile|
        tmpfile.puts render(Templates::HostGroup::ERB)
        tmpfile.flush
        system("qconf -Mhgrp #{tmpfile.path}")
        sleep 5
      end
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
