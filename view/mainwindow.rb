require 'Qt4'

require_relative '../reader'
require_relative '../lang/userinput'

module SchemeGui

  def self.launch
    Qt::Application.new(ARGV) do
      Qt::Widget.new do

        self.window_title = 'RbScheme'
        resize(1000, 800)

        textedit = Qt::TextEdit.new('Hello Qt in the Ruby way!')

        button = Qt::PushButton.new('Eval') do
          connect(SIGNAL :clicked) { SchemeGui.read_eval(textedit.plainText) }
        end

        self.layout = Qt::GridLayout.new do
          add_widget(textedit, 0, 0)
          add_widget(button, 0, 1)
        end

        show
      end
      exec
    end
  end


  def self.read_eval(input)
    userinput = UserInput.new(input)
    read = Reader.read_input(userinput)
    evaled = Eval.eval(GlobalEnvironment.get, read)
    puts evaled
  end

end
