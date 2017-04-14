# frozen_string_literal: true

module OffTheGrid
  # A class to represent SGE Access Lists
  class AccessList < NamedResource
    # Get the list of SGE access lists
    def self.list
      `qconf -sul`.chomp.split("\n").sort.map { |name| new(name) }
    end

    def details
      `qconf -su #{name}`.chomp
    end

    def users
      if new?
        @unsaved_users ||= []
      else
        # Only returns users
        extract_detail(:entries).reject { |e| e.match(/^@/) }.map { |user| User.new(user) }
      end
    end

    def add_user(user)
      if new?
        @unsaved_users ||= []
        @unsaved_users << user
      else
        users.include?(user) ? true : system("qconf -au #{user.name} #{name}")
      end
    end

    def remove_user(user)
      users.include?(user) ? system("qconf -du #{user.name} #{name}") : true
    end

    private

    # Add an SGE access list
    def add
      raise 'Creating ACL Requires One or More Users' if users.empty?
      system("qconf -au #{users.map(&:name).join(',')} #{name}")
    end

    # Remove an SGE access list
    def remove
      system("qconf -dul #{name}")
    end
  end
end
