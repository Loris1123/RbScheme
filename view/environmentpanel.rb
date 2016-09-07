require 'gtk3'
require_relative 'backend'

# Panel for displaying the environment
class EnvironmentPanel < Gtk::Grid
  def initialize(*args)
    super
    set_property "hexpand", true
    label = Gtk::Label.new("Environment")
    attach(label, 0, 0, 1, 1)

    button_refresh = Gtk::Button.new(label: "Refresh")
    button_refresh.signal_connect "clicked" do
      update_environment
    end
    attach(button_refresh, 1, 0, 1, 1)

    @treestore = Gtk::TreeStore.new(String, String)
    @treeview = Gtk::TreeView.new(@treestore)
    @treeview.set_property "hexpand", true
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
        case entry.value
        when SchemeCons
          # Add the content of the Cons or function as a child
          parent[1] = entry.value.class.to_s
          add_child_cons(parent, entry.value)
        else
          parent[1] = entry.value.to_s
        end
      end
    end
  end

  def add_child_cons(parent, entry)
    # Create car
    child = @treestore.append(parent)
    child[0] = "Car"
    if entry.car.class == SchemeCons and entry.cdr.class != SchemeNil
      # Recursion if car is a cons again
      child[1] = "SchemeCons"
      add_child_cons(child, entry.car)
    elsif entry.car.class == SchemeCons && entry.cdr.class == SchemeNil && entry.car.cdr.class == SchemeCons && entry.car.cdr.cdr.class == SchemeNil
      # Handling Special case: (1 . (2 . 3))
      # Draw the tree and you'll see the problem. There are two nil-children
      child[1] = entry.car.car.to_s

      child = @treestore.append(parent)
      child[0] = "Cdr"
      child[1] = entry.car.cdr.car.to_s
      return
    else
      child[1] = entry.car.to_s
    end

    # Create cdr
    child = @treestore.append(parent)
    child[0] = "Cdr"
    if entry.cdr.class == SchemeCons
      # Recursion if car is a cons again
      if entry.cdr.cdr.class == SchemeNil and entry.cdr.car.class != SchemeCons
        # Last element in row. Don't create a new cons. Just dislay it here.
        # Case: ((1 .2) . 3)
        child[1] = entry.cdr.car.to_s
      else
        child[1] = "SchemeCons"
        add_child_cons(child, entry.cdr)
      end

    else
      child[1] = entry.cdr.to_s
    end

  end
end
