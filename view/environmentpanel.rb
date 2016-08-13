require 'gtk3'
require_relative 'backend'

# Panel for displaying the environment
class EnvironmentPanel < Gtk::TreeView
  def initialize(*args)
    super

    @treestore = Gtk::TreeStore.new(String, String)
    set_model(@treestore)
    selection.mode = Gtk::SelectionMode::NONE

    renderer = Gtk::CellRendererText.new
    col = Gtk::TreeViewColumn.new("Key", renderer, :text => 0)
    append_column(col)

    renderer = Gtk::CellRendererText.new
    col = Gtk::TreeViewColumn.new("Value", renderer, :text => 1)
    append_column(col)

    update_environment
  end

  def update_environment
    Backend.environment.environment.table.each do |entry|
      if entry != nil
        parent = @treestore.append(nil)
        parent[0] = entry.value.to_s
        parent[1] = entry.key.to_s
      end
    end
  end
end
