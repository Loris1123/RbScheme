require_relative '../lang/userinput'
require_relative '../lang/global_environment'
require_relative '../lang/objects'
module EvalTest
  def self.test
    @@env = GlobalEnvironment.get

    res = eval_input('(+ 1 2)')
    raise "Result should be 3. Is #{res}" unless res == 3

    res = eval_input('(- 1 2)')
    raise "Result should be -1. Is #{res}" unless res == -1

    res = eval_input('(* 2 2)')
    raise "Result should be 4. Is #{res}" unless res == 4

    res = eval_input('(* 2 2 5)')
    raise "Result should be 20. Is #{res}" unless res == 20

    res = eval_input('(/ 6 3)')
    raise "Result should be 2. Is #{res}" unless res == 2

    res = eval_input('(+ 1 2 3)')
    raise "Result should be 6. Is #{res}" unless res == 6

    res = eval_input('(- 5 2 7)')
    raise "Result should be -4. Is #{res}" unless res == -4

    res = eval_input('(+ (* 3 4) 2)')
    raise "Result should be 14. Is #{res}" unless res == 14

    res = eval_input('(+ 1 (* 3 2))')
    raise "Result should be 7. Is #{res}" unless res == 7

    res = eval_input('(/ (* 3 4) (/ 4 2))')
    raise "Result should be 6. Is #{res}" unless res == 6

    res = eval_input('(abs (- 5 2 7))')
    raise "Result should be 4. Is #{res}" unless res == 4

    res = eval_input('(modulo 12 7)')
    raise "Result should be 5. Is #{res}" unless res == 5

    res = eval_input('(eq? 1 1)')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(eq? 1 2)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(eq? "foo" "foo")')
    raise "Result should be True. Is #{res}" unless res.class == SchemeTrue

    res = eval_input('(eq? 1 +)')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(integer? "foo")')
    raise "Result should be False. Is #{res}" unless res.class == SchemeFalse

    res = eval_input('(integer? 2)')
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
    raise "Cons.car should be 3. Is #{res.car}" unless res.car == 3
    raise "Cons.cdr should be cons. Is #{res.cdr.class}" unless res.cdr.class == SchemeCons
    raise "Cons.cdr.car should be \"bar\". Is #{res.cdr.car}" unless res.cdr.car == "bar"
    raise "Cons.cdr.cdr should be SchemeNil. Is #{res.cdr.cdr.class}" unless res.cdr.cdr.class == SchemeNil

    eval_input('(define bar 12)')
    res = eval_input('bar')
    raise "Result should be 12. Is #{res}" unless res == 12

  end

  private
  def self.eval_input input
    read = Reader.read_input(UserInput.new(input))
    Eval.eval(@@env, read)
  end


end