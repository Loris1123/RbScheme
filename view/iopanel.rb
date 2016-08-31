require 'gtk3'
require_relative 'backend'

# This panel contains the widgets for userinput and displaying the evaluated output
class IOPanel < Gtk::Grid
  def initialize(*args)
    super
    set_property "row-spacing", 5
    set_property "column-spacing", 5

    @inputfield = Gtk::Entry.new
    @inputfield.set_property "hexpand", true
    attach(@inputfield,0,0,1,1)

    scroll = Gtk::ScrolledWindow.new
    @eval_result = Gtk::TextView.new()
    @eval_result.editable = false
    @eval_result.set_property "hexpand", true
    @eval_result.set_property "vexpand", true
    scroll.add_with_viewport(@eval_result)
    attach(scroll, 0, 1, 2, 1)


    @button_eval = Gtk::Button.new(label: "Eval")
    @button_eval.signal_connect "clicked" do
      @eval_result.buffer.insert(@eval_result.buffer.start_iter, "#{Backend.read_eval(@inputfield.text)}\n")
    end
    attach(@button_eval, 1, 0, 1, 1)

  end
end
