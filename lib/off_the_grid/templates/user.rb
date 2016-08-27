module OffTheGrid
  module Templates
    module User
      ERB = <<EOF
name <%= @name %>
oticket 0
fshare 0
delete_time 0
default_project <%= @project %>
EOF
    end
  end
end
