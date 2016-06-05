require_relative "../lang/symboltable"
require_relative "../lang/objects"

module SymboltableTest
	def self.test
		raise "Symboltable should be empty" unless Symboltable.symboltable.size == 0
		Symboltable.get_or_add("foo")
		raise "Symboltable size should be 1, is #{Symboltable.symboltable.size}" unless Symboltable.symboltable.size == 1
		Symboltable.get_or_add("foo")
		raise "Symboltable size should be 1, is #{Symboltable.symboltable.size}" unless Symboltable.symboltable.size == 1
		Symboltable.get_or_add("bar")
		raise "Symboltable size should be 2, is #{Symboltable.symboltable.size}" unless Symboltable.symboltable.size == 2
		Symboltable.reset
		raise "Symboltable should be empty" unless Symboltable.symboltable.size == 0


		a = Symboltable.get_or_add("foo")
		b = Symboltable.get_or_add("foo")
		raise "Symbols should be SchemeSymbol, is #{a.class}" unless a.class == SchemeSymbol
		raise "Symbols should be the same objects" unless a.object_id == b.object_id

		Symboltable.reset
	end
end