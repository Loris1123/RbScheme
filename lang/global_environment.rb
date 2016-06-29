# Simple module that creates the global environment needed for Scheme with all necessary functions
require_relative '../lang/builtinfunctions'
require_relative '../lang/builtinsyntax'

module GlobalEnvironment
  def self.get
    global_env = Environment.new()
    global_env.put(Symboltable.get_or_add('+'), BuiltinFunction.new('SchemePlus', Functions.scheme_plus , 2, -1))
    global_env.put(Symboltable.get_or_add('-'), BuiltinFunction.new('SchemeSubstract', Functions.scheme_substract ,2, -1))
    global_env.put(Symboltable.get_or_add('*'), BuiltinFunction.new('SchemeTimes', Functions.scheme_times , 2, -1))
    global_env.put(Symboltable.get_or_add('/'), BuiltinFunction.new('SchemeDivide', Functions.scheme_divide ,2, 2))
    global_env.put(Symboltable.get_or_add('<'), BuiltinFunction.new('SchemeLowerThan', Functions.lower_than,2, 2))
    global_env.put(Symboltable.get_or_add('>'), BuiltinFunction.new('SchemeGreaterThan', Functions.greater_than ,2, 2))
    global_env.put(Symboltable.get_or_add('modulo'), BuiltinFunction.new('SchemeModulo', Functions.scheme_modulo , 2, 2))
    global_env.put(Symboltable.get_or_add('abs'), BuiltinFunction.new('SchemeAbs', Functions.scheme_abs , 1, 1))
    global_env.put(Symboltable.get_or_add('eq?'), BuiltinFunction.new('SchemeEquals', Functions.scheme_equals ,2, 2))

    global_env.put(Symboltable.get_or_add('integer?'), BuiltinFunction.new('SchemeInteger?', Functions.integer? ,1, 1))
    global_env.put(Symboltable.get_or_add('symbol?'), BuiltinFunction.new('SchemeSymbol?', Functions.symbol? ,1, 1))
    global_env.put(Symboltable.get_or_add('string?'), BuiltinFunction.new('SchemeString?', Functions.string? ,1, 1))
    global_env.put(Symboltable.get_or_add('function?'), BuiltinFunction.new('SchemeFunction?', Functions.function? ,1, 1))
    global_env.put(Symboltable.get_or_add('builtin-function?'), BuiltinFunction.new('SchemeBuiltinFunction?', Functions.builtin_function? ,1, 1))
    global_env.put(Symboltable.get_or_add('syntax?'), BuiltinFunction.new('SchemeSyntax?', Functions.syntax? ,1, 1))
    global_env.put(Symboltable.get_or_add('builtin-syntax?'), BuiltinFunction.new('SchemeBuiltinSyntax?', Functions.builtin_syntax? ,1, 1))
    global_env.put(Symboltable.get_or_add('cons'), BuiltinFunction.new('SchemeCons', Functions.scheme_cons, 2, 2))
    global_env.put(Symboltable.get_or_add('cons?'), BuiltinFunction.new('SchemeCons?', Functions.scheme_cons?, 1, 1))
    global_env.put(Symboltable.get_or_add('car'), BuiltinFunction.new('SchemeCar', Functions.scheme_car, 1, 1))
    global_env.put(Symboltable.get_or_add('cdr'), BuiltinFunction.new('SchemeCdr', Functions.scheme_cdr, 1, 1))

    global_env.put(Symboltable.get_or_add('define'), BuiltinSyntax.new('SchemeDefine', Syntaxes.scheme_define, 2, 2))
    global_env.put(Symboltable.get_or_add('if'), BuiltinSyntax.new('SchemeIf', Syntaxes.scheme_if, 3, 3))
    return global_env
  end
end