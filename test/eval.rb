require_relative '../lang/userinput'
require_relative '../lang/global_environment'
require_relative '../lang/objects'
module EvalTest
  def self.test
    @@env = GlobalEnvironment.get

    # Calculate with integers
    res = eval_input('(+ 1 2)')
    raise "Result should be 3. Is #{res}" unless res == SchemeInteger.new(3)

    res = eval_input('(- 1 2)')
    raise "Result should be -1. Is #{res}" unless res == SchemeInteger.new(-1)

    res = eval_input('(* 2 2)')
    raise "Result should be 4. Is #{res}" unless res == SchemeInteger.new(4)

    res = eval_input('(* 2 2 5)')
    raise "Result should be 20. Is #{res}" unless res == SchemeInteger.new(20)

    res = eval_input('(/ 6 3)')
    raise "Result should be 2. Is #{res}" unless res == SchemeInteger.new(2)

    res = eval_input('(+ 1 2 3)')
    raise "Result should be 6. Is #{res}" unless res == SchemeInteger.new(6)

    res = eval_input('(- 5 2 7)')
    raise "Result should be -4. Is #{res}" unless res == SchemeInteger.new(-4)

    res = eval_input('(+ (* 3 4) 2)')
    raise "Result should be 14. Is #{res}" unless res == SchemeInteger.new(14)

    res = eval_input('(+ 1 (* 3 2))')
    raise "Result should be 7. Is #{res}" unless res == SchemeInteger.new(7)

    res = eval_input('(/ (* 3 4) (/ 4 2))')
    raise "Result should be 6. Is #{res}" unless res == SchemeInteger.new(6)

    res = eval_input('(abs (- 5 2 7))')
    raise "Result should be 4. Is #{res}" unless res == SchemeInteger.new(4)

    res = eval_input('(modulo 12 7)')
    raise "Result should be 5. Is #{res}" unless res == SchemeInteger.new(5)

    # Calculate with floats
    res = eval_input('(+ 1.1 2.5)')
    raise "Result should be 3.6. Is #{res}" unless res == SchemeFloat.new(3.6)

    res = eval_input('(- 1.0 2.0)')
    raise "Result should be -1.0. Is #{res}" unless res == SchemeFloat.new(-1.0)

    res = eval_input('(* 2.1 2.0)')
    raise "Result should be 4.2. Is #{res}" unless res == SchemeFloat.new(4.2)

    res = eval_input('(* 2.0 2.0 5.5)')
    raise "Result should be 22.0. Is #{res}" unless res == SchemeFloat.new(22.0)

    res = eval_input('(/ 6.2 3.1)')
    raise "Result should be 2.0. Is #{res}" unless res == SchemeFloat.new(2.0)

    res = eval_input('(+ 1.1 2.2 3.3)')
    raise "Result should be 6.6. Is #{res}" unless res == SchemeFloat.new(6.6)

    res = eval_input('(- 5.0 2.2 7.0)')
    raise "Result should be -4.2. Is #{res}" unless res == SchemeFloat.new(-4.2)

    res = eval_input('(+ (* 3.2 4.5) 2.0)')
    raise "Result should be 16.4. Is #{res}" unless res == SchemeFloat.new(16.4)

    res = eval_input('(+ 1.0 (* 3.1 2.5))')
    raise "Result should be 8.75. Is #{res}" unless res == SchemeFloat.new(8.75)

    res = eval_input('(/ (* 3.2 4.2) (/ 4.0 2.5))')
    raise "Result should be 8.4. Is #{res}" unless res == SchemeFloat.new(8.4)

    res = eval_input('(abs (- 5.3 2.1 7.1))')
    raise "Result should be 3.9. Is #{res}" unless res == SchemeFloat.new(3.9)

    # Calculate with Rationals
    res = eval_input('(+ 1/2  1/2)')
    raise "Result should be 1. Is #{res}" unless res == SchemeRational.new(1,1)

    res = eval_input('(+ 1/2  1/4)')
    raise "Result should be 3/4. Is #{res}" unless res == SchemeRational.new(3,4)

    res = eval_input('(- 1/2 1/4)')
    raise "Result should be 1/4. Is #{res}" unless res == SchemeRational.new(1,4)

    res = eval_input('(- 1/2 1/1)')
    raise "Result should be -1/2. Is #{res}" unless res == SchemeRational.new(-1,2)

    res = eval_input('(* 1/2 1/2)')
    raise "Result should be 1/4. Is #{res}" unless res == SchemeRational.new(1,4)

    res = eval_input('(* 1/2 1/2 1/5)')
    raise "Result should be 1/20. Is #{res}" unless res == SchemeRational.new(1,20)

    res = eval_input('(/ 1/2 1/4)')
    raise "Result should be 2/1. Is #{res}" unless res == SchemeRational.new(2,1)

    res = eval_input('(+ 1/2 1/2 1/3)')
    raise "Result should be 4/3. Is #{res}" unless res == SchemeRational.new(4,3)

    res = eval_input('(- 1/2 1/2 1/7)')
    raise "Result should be -1/7. Is #{res}" unless res == SchemeRational.new(-1,7)

    res = eval_input('(+ (* 1/3 1/4) 1/2)')
    raise "Result should be 7/12. Is #{res}" unless res == SchemeRational.new(7,12)

    res = eval_input('(+ 1/5 (* 1/3 2/5))')
    raise "Result should be 1/3. Is #{res}" unless res == SchemeRational.new(1,3)

    res = eval_input('(/ (* 1/3 1/4) (/ 1/4 2/8))')
    raise "Result should be 1/12. Is #{res}" unless res == SchemeRational.new(1,12)

    res = eval_input('(abs (- 1/3 2/3 1/2))')
    raise "Result should be 5/6. Is #{res}" unless res == SchemeRational.new(5,6)

    # Builtin functions
    res = eval_input('(eq? 1 1)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(eq? 1 2)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(eq? "foo" "foo")')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(eq? 1 +)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(number? 2)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(number? 2.234)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(number? 2/5)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(number? "foobar")')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(number? (cons 1 2))')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(integer? "foo")')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(integer? 2)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(rational? 2)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(rational? 2/5)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(float? 5/1)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(float? 2.3345)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(string? 4)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(string? "Foobar")')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(function? "foo")')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(function? +)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(syntax? 4)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(cons? (cons 2 3))')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(cons? 4)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(syntax? +)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(syntax? define)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(builtin-syntax? define)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(builtin-function? +)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(cons 3 "bar")')
    raise "Result should be cons. Is #{res.class}" unless res.class == SchemeCons
    raise "Cons.car should be 3. Is #{res.car}" unless res.car == SchemeInteger.new(3)
    raise "Cons.cdr should be cons. Is #{res.cdr.class}" unless res.cdr.class == SchemeCons
    raise "Cons.cdr.car should be \"bar\". Is #{res.cdr.car}" unless res.cdr.car == "bar"
    raise "Cons.cdr.cdr should be SchemeNil. Is #{res.cdr.cdr.class}" unless res.cdr.cdr.class == SchemeNil

    eval_input('(define bar 12)')
    res = eval_input('bar')
    raise "Result should be 12. Is #{res}" unless res == SchemeInteger.new(12)

    eval_input('(define (a b c) (+ b c))')
    res = eval_input('(a 3 4)')
    raise "Result should be 7 Is #{res}" unless res == SchemeInteger.new(7)

    res = eval_input('(if 1 "foo" "bar")')
    raise "Result should be \"foo\" Is #{res.value}" unless res == "foo"

    res = eval_input('(if (eq? 1 2) "foo" "bar")')
    raise "Result should be \"bar\" Is #{res.value}" unless res == "bar"

    res = eval_input('(if (eq? 1 1) "foo" "bar")')
    raise "Result should be \"foo\" Is #{res.value}" unless res == "foo"

    res = eval_input('(if (eq? 1 2) (+ 3 2) (- 5 2))')
    raise "Result should be 3 Is #{res.value}" unless res == SchemeInteger.new(3)

    res = eval_input('(if #t "true" "false")')
    raise "Result should be true Is #{res.value}" unless res == "true"

    res = eval_input('(if #f "true" "false")')
    raise "Result should be false Is #{res.value}" unless res == "false"

    eval_input('(define test "test")')
    eval_input('(set! test "success")')
    res = eval_input('test')
    raise "Test should be \"success\" Is #{res.value}" unless res == "success"

    eval_input('(set! test 1337)')
    res = eval_input('test')
    raise "Test should be 1337 Is #{res.value}" unless res == SchemeInteger.new(1337)

    begin
      eval_input('(set! notdefined 12)')
      raise 'set! should raise an UndefinedVariableError'
    rescue UndefinedVariableError

    end

    eval_input('(define a (cons 1 2))')
    res = eval_input('a')
    raise "result should be cons. is #{res.class}" unless res.class == SchemeCons
    raise "Car should be 1. is #{res.car.value}" unless res.car == SchemeInteger.new(1)
    raise "Cdr should be cons. is #{res.cdr.class}" unless res.class == SchemeCons
    raise "Cdr.Car should be 2. is #{res.cdr.car.value}" unless res.cdr.car == SchemeInteger.new(2)
    raise "Cdr.cdr should be SchemeNil. is #{res.cdr.cdr}" unless res.cdr.cdr.class == SchemeNil

    #eval_input('(set-car! a (cons 6 2))')    # -> ( (6 . 2) . 2)  -> ( ( 6 . ( 2 . Nil)) . (2 . Nil))
    #res = eval_input('a')
    #raise "result should be cons. is #{res.class}" unless res.class == SchemeCons
    #raise "Car should be cons. is #{res.car.class}" unless res.car.class == SchemeCons
    #raise "Car should be 1. is #{res.car.value}" unless res.car == 1
    #raise "Cdr should be cons. is #{res.cdr.class}" unless res.class == SchemeCons
    #raise "Cdr.Car should be 2. is #{res.cdr.car.value}" unless res.cdr.car == 2
    #raise "Cdr.cdr should be SchemeNil. is #{res.cdr.cdr}" unless res.cdr.cdr.class == SchemeNil

    # Test Recursion
    eval_input('(define (counter x) (if (eq? x 1) 1 (counter (- x 1))))')
    res = eval_input('(counter 5)')
    raise "Result should be 1, is  #{res}" unless res == SchemeInteger.new(1)


    # Test calculations with mixed datatypes
    # Integer + Float = Float
    res = eval_input('(+ 2.1 2)')
    raise "Result should be 4.1. Is #{res}" unless res == SchemeFloat.new(4.1)

    res = eval_input('(+ 2 2.1)')
    raise "Result should be 4.1. Is #{res}" unless res == SchemeFloat.new(4.1)

    res = eval_input('(* 2.1 2)')
    raise "Result should be 4.2. Is #{res}" unless res == SchemeFloat.new(4.2)

    res = eval_input('(* 2 2.1)')
    raise "Result should be 4.2. Is #{res}" unless res == SchemeFloat.new(4.2)

    res = eval_input('(- 2.5 2)')
    raise "Result should be 0.5. Is #{res}" unless res == SchemeFloat.new(0.5)

    res = eval_input('(- 2 2.5)')
    raise "Result should be -0.5. Is #{res}" unless res == SchemeFloat.new(-0.5)

    res = eval_input('(- 2 2.0)')
    raise "Result should be 0.0. Is #{res}" unless res == SchemeFloat.new(0.0)

    res = eval_input('(/ 3 1.5)')
    raise "Result should be 2.0. Is #{res}" unless res == SchemeFloat.new(2.0)

    res = eval_input('(/ 1.5 3)')
    raise "Result should be 0.5. Is #{res}" unless res == SchemeFloat.new(0.5)

    # Integer + Rational = Rational
    res = eval_input('(+ 2/3 2)')
    raise "Result should be 8/3. Is #{res}" unless res == SchemeRational.new(8,3)

    res = eval_input('(+ 2 2/3)')
    raise "Result should be 8/3. Is #{res}" unless res == SchemeRational.new(8,3)

    res = eval_input('(* 2/3 2)')
    raise "Result should be 4/3. Is #{res}" unless res == SchemeRational.new(4,3)

    res = eval_input('(* 2 2/3)')
    raise "Result should be 4/3. Is #{res}" unless res == SchemeRational.new(4,3)

    res = eval_input('(- 2/3 2)')
    raise "Result should be -4/3. Is #{res}" unless res == SchemeRational.new(-4,3)

    res = eval_input('(- 2 2/3)')
    raise "Result should be 4/3. Is #{res}" unless res == SchemeRational.new(4,3)

    res = eval_input('(- 2 8/3)')
    raise "Result should be -2/3. Is #{res}" unless res == SchemeRational.new(-2,3)

    res = eval_input('(/ 3 1/5)')
    raise "Result should be 15. Is #{res}" unless res == SchemeRational.new(15,1)

    res = eval_input('(/ 1/5 3)')
    raise "Result should be 1/15. Is #{res}" unless res == SchemeRational.new(1,15)

    # FLoat + Rational = Float
    res = eval_input('(+ 2/4 2.0)')
    raise "Result should be 2.5. Is #{res}" unless res == SchemeFloat.new(2.5)

    res = eval_input('(+ 2.0 2/4)')
    raise "Result should be 2.5. Is #{res}" unless res == SchemeFloat.new(2.5)

    res = eval_input('(* 1/4 2.0)')
    raise "Result should be 0.5. Is #{res}" unless res == SchemeFloat.new(0.5)

    res = eval_input('(* 2.0 1/4)')
    raise "Result should be 0.5. Is #{res}" unless res == SchemeFloat.new(0.5)

    res = eval_input('(- 1/8 2.0)')
    raise "Result should be -1.875. Is #{res}" unless res == SchemeFloat.new(-1.875)

    res = eval_input('(- 2.0 1/8)')
    raise "Result should be 1.875. Is #{res}" unless res == SchemeFloat.new(1.875)

    res = eval_input('(- 2.0 8/4)')
    raise "Result should be 0.0. Is #{res}" unless res == SchemeFloat.new(0.0)

    res = eval_input('(/ 3.0 1/5)')
    raise "Result should be 15. Is #{res}" unless res == SchemeFloat.new(15.0)

    res = eval_input('(/ 1/5 2.0)')
    raise "Result should be 0.1. Is #{res}" unless res == SchemeFloat.new(0.1)

  end

  private
  def self.eval_input input
    read = Reader.read_input(UserInput.new(input))
    Eval.eval(@@env, read)
  end


end
