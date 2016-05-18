require_relative '../util/hashtable'

module HashtableTest
  def self.test
    table = Hashtable.new

    begin
      # Allow only strings
      Hashtable.hash(1234)
      raise "Should raise an internal Error"
    rescue SchemeIntenalError
    end

    first = Hashtable.hash("HelloWorld")
    second = Hashtable.hash("HelloWorld")
    raise "Hashes should be identical. First: #{first}, Second: #{second}" unless first==second

    table.put("Foo", "Bar")
    raise "Value should be 'Bar', is #{table.get("Foo")}" unless table.get("Foo") == "Bar"
    table.put("Foo", "Bar")

  end
end
