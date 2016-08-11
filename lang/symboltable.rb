require_relative "objects"
require_relative "errors"
require_relative '../util/hashtable'

# Module for storing all known symbols in a table
module Symboltable
  @@log = Logger.new(STDOUT)
  @@log.level = Logger::DEBUG

  @@tablesize = 521
  @@symboltable = Array.new(521)
  @@fill_level = 0

  # Gets a string and creates a symbol from it.
  # If the symbol is already in the table, the instance will be returned.
  # If not, the new symbol is put into the table and then returned.
  def self.ddddddget_or_add(sym)
    symbol = SchemeSymbol.new(sym)
    found_symbol = @@symboltable.get(symbol)

    if found_symbol == nil
      symboltable.put(symbol)
      return symbol
    end

    return found_symbol
  end

  def self.get_or_add(sym)
    if sym.class == SchemeSymbol
      # Do not use symbol.value in reshash.
      # If we do not pass the symbol directly,
      # a new instance will be created each reshash
      symbol = sym
    else
      symbol = SchemeSymbol.new(sym)
    end
    hash = SchemeHash.hash(symbol.value)

    index = hash % @@tablesize

    @@log.progname = "Symboltable get_or_add"
    @@log.debug("Add or Get: #{symbol}")
    @@log.debug("Hash: #{hash}")
    @@log.debug("Index: #{index}")

    if @@symboltable[index] == nil
      # Slot is empty. Put and return symbol
      # Since nothing will be deletes from the list
      # we can be sure, the symbol is not already in the table if we
      # find an empty slot.
      @@log.debug("Emtpy slot: #{index}")
      @@symboltable[index] = symbol
      @@fill_level += 1

      # Do we have to rehash?
      if @@fill_level > @@tablesize * 3/4
        rehash
      end
      return symbol
    else
      @@log.debug("Collision at #{index}")
      # Is it the symbol we are looking for?
      if @@symboltable[index] == symbol
        @@log.debug("It is the symbol we are looking for")
        return @@symboltable[index]
      end
      @@log.debug("It is not the symbol we are looking for")

      # Collision is not the table we are looking for.
      # Now search in the complete table for the symbol with the calculated index as start.
      # Worst case O(n)

      start_index = index
      index += 1
      while index != start_index
        if index == @@tablesize
          index = 0
        end

        if @@symboltable[index] == symbol
          @@log.debug("Found symbol it #{index}")
          return @@symboltable[index]
        end
        index += 1
      end
      @@log.debug("Symbol is not in the table. Find an empty slot and insert it")

      # Index should be startindex now. If not, the upper loop is Wrong
      raise "Error: Index is not startindex!" unless index == start_index

      start_index = index
      index += 1
      while index != start_index
        if index == @@tablesize
          index = 0
        end

        if @@symboltable[index] == nil
          @@log.debug("Found an emtpy slot at #{index}")
          @@symboltable[index] = symbol
          @@fill_level += 1

          # Do we have to rehash?
          if @@fill_level > @@tablesize * 3/4
            rehash
          end

          return symbol
        end
        index += 1
      end

      # If we come here there is no free space in symboltable.
      raise SchemeError.new("Critical Error: Symboltable is full!")
    end
  end

  # Needed for testing. I don't want the test to modify my symboltable
  # Empties the symboltable.
  def self.reset
    @@tablesize = 521
    @@symboltable = Array.new(521)
    @@fill_level = 0
  end

  def self.symboltable
    @@symboltable
  end

  def self.fill_level
    @@fill_level
  end

  private
  def self.rehash
    @@log.progname = "Symboltable rehash"
    @@log.debug("Rehashing started")

    old_table = @@symboltable

    @@tablesize = (@@tablesize * 2) - 1   # Odd number
    @@symboltable = Array.new(@@tablesize)
    @@fill_level = 0  # Will be settet again by put
    old_table.each do |symbol|
      next if symbol == nil
      get_or_add(symbol)
    end
  end
end
