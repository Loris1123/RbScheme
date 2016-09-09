require "gtk3"
require_relative 'iopanel'
require_relative 'environmentpanel'
require_relative '../lang/global_environment'

class Mainwindow

  def initialize
    init_ui
  end

  def init_ui
    @window = Gtk::Window.new("RbScheme")
    @window.set_size_request(800, 800)
    @window.set_border_width(10)
    @window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
    @iopanel = IOPanel.new
    @iopanel.set_size_request(400,800)

    @environment = EnvironmentPanel.new
    @environment.set_size_request(400,800)

    @paned = Gtk::Paned.new(Gtk::Orientation::HORIZONTAL)
    @paned.add1(@environment)
    @paned.add2(@iopanel)

    @window.add(@paned)



  end

  def show
    @window.show_all
    Gtk.main
  end

end
