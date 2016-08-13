require 'gtk3'
require_relative 'backend'

# This panel contains the widgets for userinput and displaying the evaluated output
class IOPanel < Gtk::Grid
  def initialize(*args)
    super

    #sig = GLib::Object.signal_new("foo", GLib::Signal::RUN_FIRST, nil, nil, Integer, Integer)

    set_property "row-spacing", 5
    set_property "column-spacing", 5

    @inputfield = Gtk::Entry.new
    attach(@inputfield,0,0,1,1)

    @eval_result = Gtk::TextView.new()
    @eval_result.editable = false
    attach(@eval_result, 0, 1, 2, 1)

    @button_eval = Gtk::Button.new(label: "Eval")
    @button_eval.signal_connect "clicked" do
      @eval_result.buffer.text = Backend.read_eval(@inputfield.text)
    end
    attach(@button_eval, 1, 0, 1, 1)

  def signal_do_foo
    puts "Do Foo"
  end

  end
end
