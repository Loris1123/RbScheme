require_relative "../util/userinput"

module UserInputTest
  def self.test
    u = UserInput.new("Test")
    c = u.next_char
    raise "Next char should be T. Is #{c}" unless c == "T"
    c = u.next_char
    raise "Next char should be e. Is #{c}" unless c == "e"
    c = u.next_char
    raise "Next char should be s. Is #{c}" unless c == "s"
    c = u.next_char
    raise "Next char should be t. Is #{c}" unless c == "t"
    c = u.next_char
    raise "Next char should be nil. Is #{c}" unless c == nil
    c = u.previous_char
    raise "Next char should be t. Is #{c}" unless c == "t"
    c = u.previous_char
    raise "Next char should be s. Is #{c}" unless c == "s"
    c = u.previous_char
    raise "Next char should be e. Is #{c}" unless c == "e"
    c = u.previous_char
    raise "Next char should be T. Is #{c}" unless c == "T"
    c = u.previous_char
    raise "Next char should be nil. Is #{c}" unless c == nil
    c = u.next_char
    raise "Next char should be T. Is #{c}" unless c == "T"
    c = u.next_char
    raise "Next char should be e. Is #{c}" unless c == "e"
    c = u.next_char
    raise "Next char should be s. Is #{c}" unless c == "s"
    c = u.next_char
    raise "Next char should be t. Is #{c}" unless c == "t"
    c = u.next_char
    raise "Next char should be nil. Is #{c}" unless c == nil
  end
end
