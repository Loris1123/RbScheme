require_relative '../util/hash'
require 'logger'
require_relative '../lang/errors'

# Custom implementation of a hashtable.
# Uses the hashfunction specified in util/hash.rb.
# Closed hashtable. When a slot is not empty, use the next emtpy slot.
# Entries will be stored with a Struct Entry(:key, :value)
class Hashtable
  attr_reader :fill_level

  Entry = Struct.new(:key, :value)

  def initialize(tablesize=521)
    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO

    @tablesize = tablesize
    @table = Array.new(@tablesize)
    @fill_level = 0
  end

  # Puts the Value with the given Key into a hashtable.
  # Key must be a String. Value can be any object
  # We need key to be a String, to do double hash. When there is a collision
  # put will be called recursively with the hash as the key. The hash will then be hashed again
  def put(key, value)
    key = key.to_s
    hash = SchemeHash.hash(key)
    index = hash % @tablesize
    @log.progname = "Hashtable Put"
    @log.debug("Hash: #{hash}")
    @log.debug("Index: #{index}")

    if @table[index] == nil
      # Slot is empty. Put value
      @log.debug("Emtpy slot: #{index}")
      @table[index] = Entry.new(key, value)
      @fill_level += 1
    else
      @log.debug("Collision at #{index}")
      # Collision. Slot is not empty.
      # Has the found entry the same key? Overwrite!
      if @table[index].key == key
        @log.debug("Collision with same key. Overwrite")
        @table[index].value = value
      else
        # No it's not the same key. -> Try to find an empty slot
        @log.debug("Collision with different key. Find next emtpy slot")
        #put(hash, key)  # Try with double hashing? Problem: How to do get? How do I know if the key is not in the table?

        start_index = index
            index += 1
        loop do
          if index == @tablesize
            index = 0
          end

          if index == start_index
            # Should never happen
            raise SchemeError.new("Hashtable is full!")
          end
          break if @table[index] == nil
          @log.debug("#{index} is not emtpy aswell")
          index += 1
        end
        @log.debug("Found empty slot at #{index}")
        @table[index] = Entry.new(key, value)
        @fill_level += 1
      end
    end

    # Do we have to rehash?
    if @fill_level > @tablesize * 3/4
      rehash
    end
  end

  # Returns the value of the given key form the table. Nil of the value is not in the table
  def get(key)
    key = key.to_s
    hash = SchemeHash.hash(key)
    index = hash % @tablesize
    @log.progname = "Hashtable get"
    @log.debug("Hash: #{hash}")
    @log.debug("Index: #{index}")

    start_index = index
    while @table[index] == nil or @table[index].key != key
      @log.debug("Not found at #{index}. Try next")
      index += 1
      if index == @tablesize
        # Reached the end of table. Start from beginning
        index = 0
      end
      if start_index == index
        # Searched in whole table. Value is not stored.
        @log.debug("#{key} is not in the table")
        return nil
      end
    end
    return @table[index].value
  end

  # Removes and returns the value from the table of the given key. Nil if the value is not in the table
  def get_and_remove(key)
    @log.progname = "Hashtable get"
    key = key.to_s
    hash = SchemeHash.hash(key)
    index = hash % @tablesize
    ret_val = nil
    @log.debug("Hash: #{hash}")
    @log.debug("Index: #{index}")

    start_index = index
    while @table[index] == nil or @table[index].key != key
      @log.debug("Not found at #{index}. Try next")
      index += 1
      if index == @tablesize
        # Reached the end of table. Start from beginning
        index = 0
      end
      if start_index == index
        # Searched in whole table. Value is not stored.
        @log.debug("#{key} is not in the table")
        return ret_val
      end
    end
    ret_val = @table[index].value
    @table[index] = nil
    @fill_level -= 1
    return ret_val
  end

  def rehash
    @log.progname = "Hashtable rehash"
    @log.debug("Rehashing started")

    old_table = @table

    @tablesize = (@tablesize * 2) - 1   # Odd number
    @table = Array.new(@tablesize)
    @fill_level = 0  # Will be settet again by put
    old_table.each do |entry|
      next if entry == nil
      put(entry.key, entry.value)
    end

  end
end
