require 'gtk3'

module SchemeGui
    class MainWindow < Gtk::Window
        def initialize
            super
    
            set_title "RbScheme"
            signal_connect "destroy" do
                Gtk.main_quit
            end
    
            set_default_size 1000, 800
    
            set_window_position Gtk::WindowPosition::CENTER
    
            show
        end
    end


    def self.launch
        MainWindow.new
        Gtk.main
    end 

end