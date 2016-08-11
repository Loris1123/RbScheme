require_relative '../util/hashtable'
require_relative '../util/hash'

module HashtableTest
    def self.test

      table = Hashtable.new()
      raise "Hashtable should be empty" unless table.fill_level == 0


      table.put(1, 2)
      raise "Filllevel should be 1. Is #{table.fill_level}" unless table.fill_level == 1
      raise "Value of foo should be bar. Is #{table.get(1)}" unless table.get(1) == 2

      table.put("foo", "bar")
      raise "Filllevel should be 2. Is #{table.fill_level}" unless table.fill_level == 2
      raise "Value of foo should be bar. Is #{table.get("foo")}" unless table.get("foo") == "bar"

      # Reshash
      (1..150).each do |n|
        table.put("Foobar#{n}", n)
      end
      # 152 because I putted 2 items before.
      raise "Filllevel should be 152. Is #{table.fill_level}" unless table.fill_level == 152

      (1..150).each do |n|
        res = table.get("Foobar#{n}")
        raise "Value of Foobar#{n} should be #{n}. Is #{res}" unless res == n
      end


      (1..50).each do |n|
        res = table.get_and_remove("Foobar#{n}")
        raise "Value of Foobar#{n} should be #{n}. Is #{res}" unless res == n
        raise "Filllevel should be #{152-n}. Is #{table.fill_level}" unless table.fill_level == 152-n
      end

    end
end
