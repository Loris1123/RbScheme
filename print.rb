require_relative "lang/objects"

module SchemePrinter
  def self.scheme_print(scheme_expression)
    case scheme_expression
    when SchemeString
      print "\"#{scheme_expression.get_value}\""
    when SchemeTrue
      print "\#t"
    when SchemeFalse
      print "\#f"
    when SchemeInteger
      print scheme_expression.get_value
    else
      print "Unimplemented print: #{scheme_expression.class}"
    end
    print("\n")
  end
end
