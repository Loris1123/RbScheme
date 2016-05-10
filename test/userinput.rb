require_relative "../util/userinput"

module UserInputTest
  def self.test
    u = UserInput.new("Test")
    raise "Current char should be T. Is #{u.current}" unless u.current == "T"
    u.next
    raise "Current char should be e. Is #{u.current}" unless u.current == "e"
    u.next
    raise "Current char should be s. Is #{u.current}" unless u.current == "s"
    u.next
    raise "Current char should be t. Is #{u.current}" unless u.current == "t"
    u.next
    raise "Current char should be nil. Is #{u.current}" unless u.current == nil
    #c = u.read_char
    #raise "Next char should be e. Is #{c}" unless c == "e"
    #c = u.read_char
    #raise "Next char should be s. Is #{c}" unless c == "s"
    #c = u.read_char
    #raise "Next char should be t. Is #{c}" unless c == "t"
    #c = u.read_char
    #raise "Next char should be nil. Is #{c}" unless c == nil
    #c = u.unread_char
    #raise "Previous char should be t. Is #{c}" unless c == "t"
    #c = u.unread_char
    #raise "Previous char should be s. Is #{c}" unless c == "s"
    #c = u.unread_char
    #raise "Previous char should be e. Is #{c}" unless c == "e"
    #c = u.unread_char
    #raise "Previous char should be T. Is #{c}" unless c == "T"
    #c = u.unread_char
    #raise "Previous char should be nil. Is #{c}" unless c == nil
    #c = u.read_char
    #raise "Previous char should be T. Is #{c}" unless c == "T"
    #c = u.read_char
    #raise "Previous char should be e. Is #{c}" unless c == "e"
    #c = u.read_char
    #raise "Previous char should be s. Is #{c}" unless c == "s"
    #c = u.read_char
    #raise "Previous char should be t. Is #{c}" unless c == "t"
    #c = u.read_char
    #raise "Previous char should be nil. Is #{c}" unless c == nil
  end
end
