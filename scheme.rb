#!/usr/bin/env ruby

require_relative 'reader'
require_relative 'util/userinput'
require_relative 'print'
require_relative 'lang/errors'
require_relative 'eval'
require_relative 'lang/environment'
require_relative 'lang/builtinfunctions'
require_relative 'lang/objects'
require_relative 'lang/symboltable'
require_relative 'lang/global_environment'
require 'optparse'
require 'io/console'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: scheme.rb [options]"

  opts.on("-t", "--test", "Run Tests") do |v|
    options[:test] = v
  end
  opts.on("-g", "--gui", "Use RbScheme GUI instead of commandline") do |v|
    options[:gui] = v
  end

  opts.on("-fFILE", "--file=FILE", "Speficy an inputfile to run") do |f|
    options[:inputfile] = f
  end

  opts.on("-i", "--interactive", "Start interactive mode") do |i|
    options[:interactive] = i
  end
end.parse!

def repl(global_env)
  puts 'Welcome to RbScheme'

  while TRUE
    begin
      print '> '
      raw_input = gets
      puts raw_input
      input = UserInput.new(raw_input)
      # Muliple expressions
      while input.index < input.input.size
        read = Reader.read_input(input)
        evaled = Eval.eval(global_env, read)
        if evaled != nil
          print "=> "
          puts SchemePrinter.scheme_print(evaled)
        end
      end

    rescue SchemeUserError => err
      puts err.message
    end
  end
end

# Running tests is always allowed
if options[:test] != nil
  require_relative 'test/test'
  Test.test
end

env = GlobalEnvironment.get

# Specify an inputfile is always allowed
if options[:inputfile] != nil
  # Open the file for readning
  inputfile = File.open(options[:inputfile], 'r')
  input = UserInput.new(inputfile.read)
  while input.index < input.input.size
    read = Reader.read_input(input)
    Eval.eval(env, read)
  end
end

# Only GUI or Interactive are allowed. Not both
if options[:gui] != nil
  require_relative 'view/mainwindow'
  require_relative 'view/backend'
  Backend.environment = env
  window = Mainwindow.new
  window.show
elsif options[:interactive] != nil
  repl(env)
else
  # Interactive as default
  repl(env)
end
