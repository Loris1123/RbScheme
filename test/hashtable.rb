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

    Hashtable.hash("HelloWorld")

    table.put("Foo", "Bar")
    raise "Value should be 'Bar', is #{table.get("Foo")}" unless table.get("Foo") == "Bar"

  end
end
