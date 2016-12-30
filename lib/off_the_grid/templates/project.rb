module OffTheGrid
  module Templates
    module Project
      ERB = <<EOF.freeze
name <%= @name %>
oticket 0
fshare 0
acl NONE
xacl NONE
EOF
    end
  end
end
