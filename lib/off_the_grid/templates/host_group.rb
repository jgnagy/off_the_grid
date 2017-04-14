# frozen_string_literal: true

module OffTheGrid
  module Templates
    module HostGroup
      ERB = <<~EOF
        group_name @<%= @name %>
        hostlist <%= @hostlist.join(' ') %>
EOF
    end
  end
end
