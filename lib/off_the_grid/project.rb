module OffTheGrid
  # A class to represent SGE Projects
  class Project < NamedResource
    # Get the list of SGE projects
    def self.list
      `qconf -sprjl`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    def details
      `qconf -sprj #{name}`.chomp
    end

    def acls
      extract_detail(:acl).collect do |acl|
        AccessList.new(acl)
      end
    end

    def xacls
      extract_detail(:xacl).collect do |acl|
        AccessList.new(acl)
      end
    end

    # A Read-only list of users that can use this project
    # Uses ACL association
    def users
      acls.map(&:users).flatten.uniq
    end

    private

    # Add an SGE project
    def add
      # TODO: construct a template
      Tempfile.open do |tmpfile|
        tmpfile.puts render(Templates::Project::ERB)
        tmpfile.flush
        system("qconf -Aprj #{tmpfile.path}")
        sleep 5
      end
    end

    # Remove an SGE project
    def remove
      system("qconf -dprj #{name}")
    end
  end
end
