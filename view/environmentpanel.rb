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
        when UserdefinedFunction
          parent[1] = entry.value.class.to_s
          add_child_udf(parent, entry.value)
        else
          parent[1] = entry.value.to_s
        end
      end
    end
  end

  def add_child_udf(parent, function)
    # Display a user-define-function in the table.
    require 'pry'
    binding.pry

    # Display parameters
    child = @treestore.append(parent)
    child[0] = "Parameter"
    parameterlist = "("
    function.parameter.each do |param|
      parameterlist << param.value.to_s
      parameterlist << ", "
    end
    parameterlist = parameterlist[0..-3]  # Cut the last ,
    parameterlist << ")"
    child[1] = parameterlist

    # Display function-body
    child = @treestore.append(parent)
    child[0] = "Body"
    child[1] = ""

    function.function.each do |func|
      # Iterate over each statement of the function
      statement = @treestore.append(child)
      case func
      when SchemeCons
        statement[0] = func.class.to_s
        add_child_cons(statement, func)
      else
        statement[0] = func.class.to_s
        statement[1] = func.to_s
      end

    end




  end


  def add_child_cons(parent, entry)
    # Display Cons as children in the treeview.
    # Will be called recursively, when car/cdr is a cons again.

    # Create car
    if entry.car.class != SchemeCons
      child = @treestore.append(parent)
      child[0] = "Car"
      child[1] = entry.car.to_s
    else
      child = @treestore.append(parent)
      child[0] = "car"
      child[1] = entry.car.class.to_s
      add_child_cons(child, entry.car)
    end

    # Create cdr
    if entry.cdr.class != SchemeCons
      child = @treestore.append(parent)
      child[0] = "Cdr"
      child[1] = entry.cdr.to_s
    elsif entry.cdr.cdr.class == SchemeNil
      # Special case, for the end of the tree
      if entry.cdr.car.class == SchemeCons
        child = @treestore.append(parent)
        child[0] = "Cdr"
        child[1] = "SchemeCons"
        add_child_cons(child, entry.cdr.car)
      else
        child = @treestore.append(parent)
        child[0] = "Cdr"
        child[1] = entry.cdr.car.to_s
      end
    else
      child = @treestore.append(parent)
      child[0] = "Cdr"
      child[1] = entry.cdr.class.to_s
      add_child_cons(child, entry.cdr)
    end
  end
end
