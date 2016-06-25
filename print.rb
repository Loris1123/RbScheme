require_relative "lang/objects"

module SchemePrinter
  def self.scheme_print(scheme_expression)
    case scheme_expression
      when SchemeString
        puts "\"#{scheme_expression.value}\""
      when SchemeTrue
        puts  '#t'
      when SchemeFalse
        puts '#f'
      when SchemeInteger
        puts  scheme_expression.value
      when SchemeNil
        puts 'nil'
      when SchemeCons
        puts scheme_print_list scheme_expression
      when BuiltinFunction
        puts "<Builtin-Function: \##{scheme_expression.name}>"
      when NilClass
        # When an input returns nothing. Like define
        return
      else
        puts "Unimplemented print: #{scheme_expression.class}"
    end
  end

  def self.scheme_print_list(cons)
    if cons.cdr.class == SchemeNil
      return "#{scheme_print cons.car})"
    end
    return "(#{scheme_print cons.car} . #{scheme_print(cons.cdr)}"

  end
end
