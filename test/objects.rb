require_relative "../lang/objects"

module ObjectsTest
  def self.test
    i = SchemeInteger.new(42)
    raise "Value should be 42, is #{i.get_value}" unless i.get_value == 42
    i.set_value(23)
    raise "Value should be 23, is #{i.get_value}" unless i.get_value == 23

    begin
      i.set_value("")
      i.set_value("test")
      i.set_value(nil)
    rescue SchemeArgumentError
    end

    s = SchemeString.new("Foobar")
    raise "Value should be Foobar, is \"#{s.get_value}\"" unless s.get_value == "Foobar"

    s = SchemeString.new(42)
    raise "Value should be \"42\", is \"#{s.get_value}\"" unless s.get_value == "42"

    s = SchemeString.new(nil)
    raise "Value should be \"\", is \"#{s.get_value}\"" unless s.get_value == ""

    s = SchemeString.new("")
    raise "Value should be \"\", is \"#{s.get_value}\"" unless s.get_value == ""
  end
end
