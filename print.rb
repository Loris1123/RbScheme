require_relative "lang/objects"

module SchemePrinter
  def self.scheme_print(scheme_expression)
    #require 'pry'
    #binding.pry
    case scheme_expression
      when SchemeString
        print "\"#{scheme_expression.value}\""
      when SchemeTrue
        print  '#t'
      when SchemeFalse
        print '#f'
      when SchemeInteger
        print  scheme_expression.value
      when SchemeFloat
        print  scheme_expression.value
      when SchemeInteger
        print  scheme_expression.value
      when SchemeRational
        print  scheme_expression.value
      when SchemeNil
        print 'nil'
      when SchemeCons
        scheme_print_list scheme_expression
      when BuiltinFunction
        print "<Builtin-Function: \##{scheme_expression.name}>"
      when BuiltinSyntax
        print "<Builtin-Syntax: \##{scheme_expression.name}>"
      when NilClass
        # When an input returns nothing. Like define
        return
      else
        print "Unimplemented print: #{scheme_expression.class}"
    end
    #puts
  end

  def self.scheme_print_list(cons)
    if cons.cdr.class == SchemeNil
      scheme_print cons.car
      print ")"
      #print "#{scheme_print cons.car})"
      return
    end
    print "("
    scheme_print cons.car
    print " . "
    scheme_print cons.cdr

  end
end
