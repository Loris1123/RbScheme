require "io/console"
require_relative "history"

module SchemeConsole

  HISTORY = History.new

  def self.get_input
    print "> \033[s"  # Promt and store position

    input = ""
    loop do
      char = SchemeConsole::read_char
      # Handle keys and special keys now
      case char
      when "\177"
        # Backspace
        input = input[0, input.length-1]
        print "\b"
        print "\033[K"  # Erase the rest of the line
      when "\e[A"
        print "\033[u" # Restore position
        print "\033[K"  # Erase the rest of the line
        up = SchemeConsole::HISTORY.up
        print up
        input = up
      when "\e[B"
        print "\033[u" # Restore position
        print "\033[K"  # Erase the rest of the line
        down = SchemeConsole::HISTORY.down
        print down
        input = down
      when "\u0003"
        # Ctrl-C
        puts "Okay, bye"
        exit 0
      when "\r"
        # Return
        print "\r\n"
        break
      else
        print char
        input << char
      end
    end
    SchemeConsole::HISTORY.append(input)
    return input
  end

  # Reads keypresses from the user including 2 and 3 escape character sequences.
  # Taken from https://gist.github.com/acook/4190379
  def self.read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end
end

# Test Console standalone:
while true
  puts "Input: #{SchemeConsole::get_input}"
end
