module OffTheGrid
  # A class to represent SGE Users
  class User < NamedResource
    # Get the list of all SGE users
    def self.list
      `qconf -suserl`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    # Get the list of admin users
    def self.admins
      `qconf -sm`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    # An alias for admins
    def self.managers
      admins
    end

    # Get the list of operator users
    def self.operators
      `qconf -so`.chomp.split("\n").sort.collect { |name| new(name) }
    end

    def details
      `qconf -suser #{name}`.chomp
    end

    attr_writer :default_project

    attr_reader :default_project

    def admin?
      admins.include?(self)
    end

    alias manager? admin?

    def operator?
      # TODO: learn more about the difference between "operator" and "manager"
      #  Maybe admins are always operators?
      operators.include?(self)
    end

    private

    # Add an SGE user
    def add
      Tempfile.open do |tmpfile|
        tmpfile.puts render(Templates::User::ERB)
        tmpfile.flush
        system("qconf -Auser #{tmpfile.path}")
        sleep 5
      end
    end

    # Remove an SGE user
    def remove
      system("qconf -duser #{name}")
    end

    # Validations go here
    def validate_before_save
      if super
        (@default_project && @default_project.is_a?(Project))
      else
        false
      end
    end
  end
end
