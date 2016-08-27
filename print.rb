require_relative "lang/objects"

module SchemePrinter
  def self.scheme_print(evaluated_result)
    if evaluated_result.class == Array
      evaluated_result.each do |expression|
        puts(print_expression(expression))
      end
    else
      puts print_expression(evaluated_result)
    end
  end

  def self.print_expression(scheme_expression)
    case scheme_expression
      when SchemeString
        return "\"#{scheme_expression.value}\""
      when SchemeTrue
        return  '#t'
      when SchemeFalse
        return '#f'
      when SchemeInteger
        return  scheme_expression.value
      when SchemeFloat
        return  scheme_expression.value
      when SchemeInteger
        return  scheme_expression.value
      when SchemeRational
        return  scheme_expression.value
      when SchemeNil
        return 'nil'
      when SchemeCons
        return scheme_print_list scheme_expression
      when BuiltinFunction
        return "<Builtin-Function: \##{scheme_expression.name}>"
      when BuiltinSyntax
        return "<Builtin-Syntax: \##{scheme_expression.name}>"
      when NilClass
        # When an input returns nothing. Like define
        return
      else
        return "Unimplemented print: #{scheme_expression.class}"
    end
  end

  def self.scheme_print_list(cons)
    if cons.cdr.class == SchemeNil
      return "#{scheme_print cons.car})"
    end
    return "(#{scheme_print cons.car} . #{scheme_print(cons.cdr)}"

  end
end
