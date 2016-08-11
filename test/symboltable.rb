require_relative "../lang/symboltable"
require_relative "../lang/objects"

module SymboltableTest
	def self.test
		raise "Symboltable should be empty" unless Symboltable.fill_level == 0
		Symboltable.get_or_add("foo")
		raise "Symboltable fill_level should be 1, is #{Symboltable.fill_level}" unless Symboltable.fill_level == 1
		Symboltable.get_or_add("foo")
		raise "Symboltable fill_level should be 1, is #{Symboltable.fill_level}" unless Symboltable.fill_level == 1
		Symboltable.get_or_add("bar")
		raise "Symboltable fill_level should be 2, is #{Symboltable.fill_level}" unless Symboltable.fill_level == 2
		Symboltable.reset
		raise "Symboltable should be empty" unless Symboltable.fill_level == 0


		a = Symboltable.get_or_add("foo")
		b = Symboltable.get_or_add("foo")
		raise "Symbols should be SchemeSymbol, is #{a.class}" unless a.class == SchemeSymbol
		raise "Symbols should be the same objects" unless a.object_id == b.object_id

		# Reshash
		(1..500).each do |n|
			Symboltable.get_or_add("Foobar#{n}")
		end
		# 501 because I putted one Item before. Attention: there is a reset in between
		raise "Filllevel should be 501. Is #{Symboltable.fill_level}" unless Symboltable.fill_level == 501

		# Use a reference before reshash
		# get a new b reference after reshash.
		# Should stillbe the same object_id
		b = Symboltable.get_or_add("foo")
		raise "Symbols should be SchemeSymbol, is #{a.class}" unless a.class == SchemeSymbol
		raise "Symbols should be the same objects" unless a.object_id == b.object_id


		# Reset to start with a new symboltable after the tests
		Symboltable.reset
	end
end
