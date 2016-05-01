require_relative "../lang/objects"

module ObjectsTest
  def self.test
    i = SchemeInteger.new(42)
    raise "Value should be 42" unless i.get_value == 42
    i.set_value(23)
    raise "Value should be 23" unless i.get_value == 23

    begin
      i.set_value("")
      i.set_value("test")
      i.set_value(nil)
    rescue SchemeArgumentError
    end
  end
end
