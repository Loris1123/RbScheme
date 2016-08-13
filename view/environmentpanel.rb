require 'gtk3'
require_relative 'backend'

# Panel for displaying the environment
class EnvironmentPanel < Gtk::Grid
  def initialize(*args)
    super

    label = Gtk::Label.new("Environment")
    attach(label, 0, 0, 1, 1)

    button_refresh = Gtk::Button.new(label: "Refresh")
    button_refresh.signal_connect "clicked" do
      update_environment
    end
    attach(button_refresh, 1, 0, 1, 1)

    @treestore = Gtk::TreeStore.new(String, String)
    @treeview = Gtk::TreeView.new(@treestore)
    @treeview.selection.mode = Gtk::SelectionMode::NONE
    attach(@treeview, 0, 1, 2, 1)

    # Key Column
    renderer = Gtk::CellRendererText.new
    col = Gtk::TreeViewColumn.new("Key", renderer, :text => 0)
    @treeview.append_column(col)

    # Value Column
    renderer = Gtk::CellRendererText.new
    col = Gtk::TreeViewColumn.new("Value", renderer, :text => 1)
    @treeview.append_column(col)

    update_environment
  end

  def update_environment
    @treestore.clear
    Backend.environment.environment.table.each do |entry|
      if entry != nil
        parent = @treestore.append(nil)
        parent[0] = entry.key.to_s
        parent[1] = entry.value.to_s
      end
    end
  end
end
