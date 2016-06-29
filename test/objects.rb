require_relative "../lang/objects"

module ObjectsTest
  def self.test
    i = SchemeInteger.new(42)
    raise "Value should be 42, is #{i.value}" unless i.value == 42
    i.value = 23
    raise "Value should be 23, is #{i.value}" unless i.value == 23

    begin
      i.value = ""
      i.value = "test"
      i.value = nil
    rescue SchemeArgumentError
    end

    six = SchemeInteger.new(6)
    three = SchemeInteger.new(3)
    raise "Result should be 9, is #{six+three}" unless (six+three).value == 9
    raise "Result should be 3, is #{six-three}" unless (six-three).value == 3
    raise "Result should be 18, is #{six*three}" unless (six*three).value == 18
    raise "Result should be 2, is #{six/three}" unless (six/three).value == 2


    s = SchemeString.new("Foobar")
    raise "Value should be Foobar, is \"#{s.value}\"" unless s.value == "Foobar"

    s = SchemeString.new(42)
    raise "Value should be \"42\", is \"#{s.value}\"" unless s.value == "42"

    s = SchemeString.new(nil)
    raise "Value should be \"\", is \"#{s.value}\"" unless s.value == ""

    s = SchemeString.new("")
    raise "Value should be \"\", is \"#{s.value}\"" unless s.value == ""
  end

    cons = SchemeCons.new(SchemeInteger.new(42), SchemeString.new("Foobar"))
    raise "CAR should be 42, is \"#{cons.cdr.value}\"" unless cons.car.value == 42
    raise "CDR should be \"Foobar\", is \"#{cons.cdr.value}\"" unless cons.cdr.value == "Foobar"
end
