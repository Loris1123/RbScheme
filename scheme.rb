#!/usr/bin/env ruby

require_relative 'reader'
require_relative 'lang/userinput'
require_relative 'print'
require_relative 'lang/errors'
require_relative 'eval'
require_relative 'lang/environment'
require_relative 'lang/builtinfunctions'
require_relative 'lang/objects'
require_relative 'lang/symboltable'
require_relative 'lang/global_environment'

if ARGV[1] != "skiptest"
  # Start tests
  require_relative 'test/test'
  Test.test
end

def repl
  puts 'Welcome to RbScheme'
  while TRUE

    begin
      print '> '
      input = UserInput.new(gets)
      read = Reader.read_input(input)
      evaled = Eval.eval(GlobalEnvironment.get, read)
      puts SchemePrinter.scheme_print(evaled)
    rescue SchemeUserError => err
      puts err.message
    end
  end
end

## Entrypoint

input = ARGV[0]
if input != nil and input != "--gui"
  # Parse commandline argument
  puts SchemePrinter.scheme_print(Eval.eval(GlobalEnvironment.get, Reader.read_input(UserInput.new(input))))
else
  # Interactive mode
  if input == "--gui"
    require_relative 'view/mainwindow'
    SchemeGui.launch()
  else
    repl
  end
end