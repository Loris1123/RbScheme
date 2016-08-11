require 'green_shoes'
require 'cgi'
require 'pry'

module Mainwindow

  def self.launch(global_env)
    Shoes.app(title: "RbScheme", width: 800, height: 800, resizable: false) do
      @list = nil

      def refresh(global_env)
        @list.clear
        @list.append do
          global_env.environment.table.each do |entry|
            if entry != nil
              para CGI.escapeHTML(entry.key), "\t\t\t", CGI.escapeHTML(entry.value.to_s)
            end
          end
        end
      end

      button "Refresh" do
        refresh(global_env)
      end

      para "Key", "\t\t\t", "Value"

      @list = stack do
      end
      refresh(global_env)

      every 1 do
        refresh(global_env)
      end

    end
  end
end
