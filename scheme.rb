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
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: scheme.rb [options]"

  opts.on("-s", "--skip-test", "Skip Tests") do |v|
    options[:skiptest] = v
  end
  opts.on("-g", "--gui", "Use RbScheme GUI instead of commandline") do |v|
    options[:gui] = v
  end
end.parse!

def repl(global_env)
  puts 'Welcome to RbScheme'
  while TRUE

    begin
      print '> '
      input = UserInput.new(gets)
      while input.index < input.input.size
        read = Reader.read_input(input)
        evaled = Eval.eval(global_env, read)
        puts SchemePrinter.scheme_print(evaled)
      end

    rescue SchemeUserError => err
      puts err.message
    end
  end
end

if options[:skiptest] == nil
  require_relative 'test/test'
  Test.test
end

env = GlobalEnvironment.get
if options[:gui] == nil
  repl(env)
else
  require_relative 'view/mainwindow'
  window = Mainwindow.new
  window.show
end
