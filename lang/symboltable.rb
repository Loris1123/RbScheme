require_relative "objects"
require_relative "errors"
# Normal List for now...will implement my own later
module Symboltable
  @@symboltable = []


  def self.get_or_add(symbol)
  	# SchemeSymbol.== returns only true, if the other one is a SchemeSymbol too.
  	# Other way would be to allow comparison of SchemeSymbols and Strings. 
  	# Then the new object would not be needed
  	found_symbol = @@symboltable.select{ |sym| sym == SchemeSymbol.new(symbol) }

  	case 
  	when found_symbol.size == 0
  		new_symbol = SchemeSymbol.new(symbol)
  		@@symboltable << new_symbol
  		return new_symbol
  	when found_symbol.size == 1
  		return found_symbol[0]
  	when found_symbol.size > 1
  		# Should never happen
  		raise SchemeInternalError.new("Symboltable problem. More than 1 entry of #{symbol} in symboltable")
  	end
  end

  def self.symboltable
  	@@symboltable
  end

  def self.reset
  	""" Needed for testing. I don't want the test to modify my symboltable """
  	@@symboltable = []
  end
 
end
