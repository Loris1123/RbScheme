require_relative "lang/objects"

module SchemePrinter
  def self.scheme_print(scheme_expression)
    case scheme_expression
    when SchemeString
      return "\"#{scheme_expression.get_value}\""
    when SchemeTrue
      return "\#t"
    when SchemeFalse
      return "\#f"
    when SchemeInteger
      return scheme_expression.get_value
    when SchemeNil
      return "nil"
    when SchemeCons
      return scheme_print_list scheme_expression
    when BuiltinFunction
      return "<Builtin-Function: \##{scheme_expression.name}>"
    else
      return "Unimplemented print: #{scheme_expression.class}"
    end
  end

  def self.scheme_print_list(cons)
    ret = "(#{scheme_print cons.get_car}"
    if cons.get_cdr.class == SchemeNil
      return ret+")"
    end
    ret += scheme_print_list cons.get_cdr
  end
end
