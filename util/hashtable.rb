require_relative "../lang/errors"
require_relative "linkedlist"

class Hashtable

  # TODO if there is time in the end.
  # Use normal hashes until now.

  def initialize(tablesize=521)
    @table = Array.new(tablesize)
    @tablesize = tablesize
    @fill_level = 0
  end

  def put(key, value)
    """
    Put the value in the hashtable
    """
    index = Hashtable.hash(key) % @tablesize
    if @table[index] == nil
      puts "Is Empty!"
      #@table[index] = LinkedList.new({value})
    else
      # Collision. Ovewrite value or add new one?
      item = @table[index].first
      while item != nil
        if item.value == value
          # TODO!
          puts "FOUND!"
          break
        end
        item = item.next
      end

    end
  end

  def get(key)
    index = Hashtable.hash(key) % @tablesize
    return @table[index].first.value
  end

  def self.hash(x)
    """
    Returns the generated hash of the given string
    """
    if x.class != String
      raise SchemeIntenalError.new("Only strings are allowed to hash")
    end
    hash = 0
    x.each_char do |char|
      hash = (hash * 31) ^ char.ord
    end
    return hash
  end
end
