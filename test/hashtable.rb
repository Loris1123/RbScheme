require_relative '../util/hashtable'
require_relative '../util/hash'

module HashtableTest
    def self.test

      table = Hashtable.new(15) # Only a small table for testing. Rehash will come earlier
      raise "Hashtable should be empty" unless table.fill_level == 0


      table.put("1", 2)
      raise "Filllevel should be 1" unless table.fill_level == 1
      raise "Value of foo should be bar. Is #{table.get(1)}" unless table.get(1) == 2

      table.put("foo", "bar")
      raise "Filllevel should be 2" unless table.fill_level == 2
      raise "Value of foo should be bar. Is #{table.get("foo")}" unless table.get("foo") == "bar"

      (1..35).each do |n|
        table.put("Foobar#{n}", n)
      end

    end
end
