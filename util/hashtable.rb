require_relative '../util/hash'
require 'logger'
require_relative '../lang/errors'

# Custom implementation of a hashtable.
# Uses the hashfunction specified in util/hash.rb.
# Closed hashtable. When a slot is not empty, use the next emtpy slot.
# Entries will be stored with a Struct Entry(:key, :value)
class Hashtable

  Entry = Struct.new(:key, :value)

  def initialize(tablesize=521)
    @log = Logger.new(STDOUT)
    @log.level = Logger::DEBUG

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
      puts(@tablesize * 3/4)
      puts(@fill_level)
      puts @tablesize
    if @fill_level > @tablesize * 3/4
      rehash
    end
  end

  def get(key)
    key = key.to_s
    hash = SchemeHash.hash(key)
    index = hash % @tablesize
    @log.progname = "Hashtable get"
    @log.debug("Hash: #{hash}")
    @log.debug("Index: #{index}")

    start_index = index
    while @table[index] == nil or @table[index].key != key
      index += 1
      if index == @tablesize
        # Reached the end of table. Start from beginning
        index = 0
      end
      if start_index == index
        # Searched in whole table. Value is not stored.
        return nil
      end
    end
    return @table[index].value
  end

  def fill_level
    @fill_level
  end

  def rehash
    @log.progname = "Hashtable rehash"
    @log.debug("Rehashing started")

    old_table = @table
    old_table_size = @tablesize


    @tablesize = (@tablesize * 2) - 1   # Odd number
    @table = Array.new(@tablesize)

    old_table.each do |entry|
      break if entry == nil

      put(entry.key, entry.value)
    end

  end
end
