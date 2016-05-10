require_relative "../lang/errors"
require_relative "linkedlist"

class Hashtable

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
    puts "Index Put for #{key}: #{index}"
    if @table[index] == nil
      puts "Is Empty!"
      @table[index] = LinkedList.new(value)
    else
      puts "Collision!!"
    end
  end

  def get(key)
    index = Hashtable.hash(key) % @tablesize
    puts "index Get for #{key}: #{index}"
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
