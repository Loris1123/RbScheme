require_relative '../lang/builtinfunctions'  # for SchemeBuiltin-baseclass

class BuiltinSyntax < SchemeBuiltin

end

module Syntaxes

    def self.scheme_if
      Proc.new{|environment, args|
        if args[0].class == SchemeCons
          condition = Eval.eval(environment, args[0])
        else
          condition = args[0]
        end

        if condition.class == SchemeFalse
          if args[2].class == SchemeCons
            result = Eval.eval(environment, args[2])
          else
            result = args[2]
          end
        else
          if args[1].class == SchemeCons
            result = Eval.eval(environment, args[1])
          else
            result = args[1]
          end
        end
        result
      }
    end

    def self.scheme_define
    Proc.new{|environment, args|

      case args[0]
        when SchemeSymbol
          # Define a new symbol and assign a value
          if args[1].class == SchemeCons
            # Eval the argument if it is a cons.
            # If there are undefined symbols in the cons,
            # an error will be raised. This is okay and the expected behaviour (compare to racket)
            environment.put(args[0], Eval.eval(environment,args[1]))
          else
            # If it is something other (integer, string, t, f), just assing it to the symbol
            environment.put(args[0], args[1])
          end
        when SchemeCons
          # Userdefined Function

          lambda_header = args[0]
          lambda_body = args[1]
          raise SchemeSyntaxError.new("Wrong define-Syntax. Need a cons as functionbody. Got #{lambda_body.class}") unless lambda_body.class == SchemeCons

          lambda_name = lambda_header.car
          raise SchemeSyntaxError.new("Wrong define-Syntax. Need a Symbol as function identifier. Got #{lambda_name.class}") unless lambda_name.class == SchemeSymbol

          # Create the parameter-list
          parameter_list = lambda_header.cdr
          parameter = []
          loop do
            raise SchemeSyntaxError.new("Wrong define-Syntax. Need a Symbol as parameter. Got #{parameter_list.car.class}") unless parameter_list.car.class == SchemeSymbol
            parameter << parameter_list.car
            break if parameter_list.cdr.class == SchemeNil
            parameter_list = parameter_list.cdr
          end

          environment.put(lambda_name, UserdefinedFunction.new(lambda_name, lambda_body, parameter ))
        else
          raise SchemeSyntaxError.new("Wrong define-Syntax. Only Symbols or Cons are allowed as identifier. Got #{args[0].class}")
      end
    }
    end

end