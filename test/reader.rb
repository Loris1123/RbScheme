require_relative '../reader'
require_relative '../lang/userinput'
require_relative '../lang/builtinfunctions'

module ReaderTest
  def self.test
    raise "Should be digit" unless Reader.is_digit 3
    raise "Shoud not be a digit" if Reader.is_digit "No Digit"
    raise "Shoud not be a digit" if Reader.is_digit ""
    raise "Shoud not be a digit" if Reader.is_digit nil

    u = UserInput.new("1234")
    r = Reader.read_input u
    raise "Read input should be SchemeInteger, is #{r.class}" unless r.class == SchemeInteger
    raise "Read number should be 1234, is #{r.value}" unless r.value == 1234

    u = UserInput.new("12234534535657867845652347289453795792745937693749273953653452434")
    r = Reader.read_input u
    raise "Read input should be SchemeInteger, is #{r.class}" unless r.class == SchemeInteger
    raise "Read number should be 12234534535657867845652347289453795792745937693749273953653452434, is #{r.value}" unless r.value == 12234534535657867845652347289453795792745937693749273953653452434

    u = UserInput.new("12.34")
    r = Reader.read_input u
    raise "Read input should be SchemeFloat, is #{r.class}" unless r.class == SchemeFloat
    raise "Read number should be 12.34, is #{r.value}" unless r.value == 12.34

    u = UserInput.new("12.")
    r = Reader.read_input u
    raise "Read input should be SchemeFloat, is #{r.class}" unless r.class == SchemeFloat
    raise "Read number should be 12.0, is #{r.value}" unless r.value == 12.0

    u = UserInput.new("12..")
    begin
      r = Reader.read_input u
      raise "Should raise an SchemeSyntaxError"
    rescue SchemeSyntaxError
    end

    u = UserInput.new("12.23.")
    begin
      r = Reader.read_input u
      raise "Should raise an SchemeSyntaxError"
    rescue SchemeSyntaxError
    end

    u = UserInput.new("14545634534234356576467564675675675682.34564564564534689086786782342335657867857356")
    r = Reader.read_input u
    raise "Read input should be SchemeFloat, is #{r.class}" unless r.class == SchemeFloat
    raise "Read number should be 14545634534234356576467564675675675682.34564564564534689086786782342335657867857356, is #{r.value}" unless r.value == 14545634534234356576467564675675675682.34564564564534689086786782342335657867857356

    u = UserInput.new("\"abcd\"")
    r = Reader.read_input u
    raise "Read input should be SchemeString, is #{r.class}" unless r.class == SchemeString
    raise "Read string should be \"abcd\", is #{r.get_value}" unless r.value == "abcd"

    u = UserInput.new("\"abcd")
    begin
      r = Reader.read_input u
      raise "Should raise an UnterminatedStringError"
    rescue UnterminatedStringError
    end

    u = UserInput.new("(cons 1 4)")
    r = Reader.read_input u
    raise "Reader should read a cons, is #{r.class}" unless r.class == SchemeCons
    raise "Car should be SchemeSymbol, is #{r.car.class}" unless r.car.class == SchemeSymbol
    raise "Cdr should be cons, is #{r.cdr.class}" unless r.cdr.class == SchemeCons
    raise "Cdr.car should be Integer, is #{r.cdr.car.class}" unless r.cdr.car.class == SchemeInteger
    raise "Cdr.cdr should be cons, is #{r.cdr.cdr.class}" unless r.cdr.cdr.class == SchemeCons
    raise "Cdr.cdr.car should be Integer, is #{r.cdr.cdr.car.class}" unless r.cdr.cdr.car.class == SchemeInteger
    raise "Cdr.cdr.cdr should be SchemeNil, is #{r.cdr.cdr.cdr.class}" unless r.cdr.cdr.cdr.class == SchemeNil

    u = UserInput.new("(cons 1 4")
    begin
      r = Reader.read_input u
      raise "Should raise an UnterminatedConsError"
    rescue UnterminatedConsError
    end

  end
end
