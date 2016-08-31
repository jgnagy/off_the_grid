module OffTheGrid
  class AccessList
    attr_reader :name
    include GridResource

    # Get the list of SGE access lists
    def self.list
      `qconf -sul`.chomp.split("\n").sort.collect {|name| self.new(name)}
    end

    def details
      `qconf -su #{name}`.chomp
    end

    def users
      if new?
        @unsaved_users ||= []
      else
        # Only returns users
        extracted_entries.select {|entry| !entry.match /^@/ }.collect {|user| User.new(user) }
      end
    end

    def add_user(user)
      if new?
        @unsaved_users ||= []
        @unsaved_users << user
      else
        users.include?(user) ? true : system("qconf -au #{user.name}")
      end
    end

    alias_method :<<, :add_user

    def remove_user(user)
      users.include?(user) ? system("qconf -du #{user.name}") : true
    end

    private

    # Add an SGE access list
    def add
      fail "Creating ACL Requires One or More Users" if users.empty?
      system("qconf -aul #{users.map(&:name).join(' ')}")
    end

    def extracted_entries
      entries = []
      details.split("\n").each do |line|
        if entries.size > 0
          # Add follow-up lines from the weird word-wrapped output
          line.match(/^( ){8}/) ? entries << line : break
        end
        entries << line if line.match /^entries/
      end
      entries.join.gsub(/(entries|\s|\\)/, '').split(',')
    end

    # Remove an SGE access list
    def remove
      system("qconf -dul #{name}")
    end
  end
end
