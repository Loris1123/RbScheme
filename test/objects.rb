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

    six = SchemeInteger.new(6)
    three = SchemeInteger.new(3)
    raise "Result should be 9, is #{six+three}" unless (six+three).get_value == 9
    raise "Result should be 3, is #{six-three}" unless (six-three).get_value == 3
    raise "Result should be 18, is #{six*three}" unless (six*three).get_value == 18
    raise "Result should be 2, is #{six/three}" unless (six/three).get_value == 2


    s = SchemeString.new("Foobar")
    raise "Value should be Foobar, is \"#{s.get_value}\"" unless s.get_value == "Foobar"

    s = SchemeString.new(42)
    raise "Value should be \"42\", is \"#{s.get_value}\"" unless s.get_value == "42"

    s = SchemeString.new(nil)
    raise "Value should be \"\", is \"#{s.get_value}\"" unless s.get_value == ""

    s = SchemeString.new("")
    raise "Value should be \"\", is \"#{s.get_value}\"" unless s.get_value == ""
  end

    cons = SchemeCons.new(SchemeInteger.new(42), SchemeString.new("Foobar"))
    raise "CAR should be 42, is \"#{cons.get_cdr.get_value}\"" unless cons.get_car.get_value == 42
    raise "CDR should be \"Foobar\", is \"#{cons.get_cdr.get_value}\"" unless cons.get_cdr.get_value == "Foobar"
end
