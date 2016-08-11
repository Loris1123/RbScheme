# RbScheme

A Scheme implementation written in Ruby.  
This is a project for my university in a lecture called "Implementation of advanced programming languages."  
Obviously it's not usable for production (yet?), but when implementing it, I learned a lot about how
programming languages work.  
Feel free to submit bugs or recommendations for improvements.

## Dependencies

This is written in plain ruby. So it does not have any dependencies, beside the ruby language.  
I've tested it with Ruby 2.3.1 and 2.2.5. If you use another version, please tell me whether it works or not.

### Optional Dependency

You can start RbRuby with a GUI with the commandline argument `-g`.
The GUI is written with [Shoes](http://shoesrb.com).

I used the Gtk Framework of schoes. So green_shoes is required.

    gem install green_shoes

## How to use
Start RbScheme with `ruby scheme.rb`  
This will bring you to the interactive mode.

You can also pass schemecode as a commandline argument

    ruby scheme.rb "(define a 10)"

To skip tests (faster):

    ruby scheme.rb -s

To open the gui:

    ruby scheme.rb -g

## What it can do (so far)

### Types
These are the currently available types for RbScheme.
Given examples show how to get an instance of the type.

#### True

    #t

#### False

    #f

#### Nil
No Type. Won't print anything

    nil

#### Integer
Integer numbers

    1

#### Float
Floating numbers

    1.2
    1.

#### Rationals
Fractions

    2/3
    (/ 3 4)

#### String
Character Strings

    "Foobar"

#### Cons
Scheme-typical Lists.

    (cons 1 2)

### Arithmetics
You can to simple calculations in the known scheme-syntax.  

    (+ 2 4)
      => 6
    (- 2 4)
      => -2
    (/ 4 2)
      => 2
    (* 2 4)
      => 8
    (modulo 6 4)
      => 2
    (abs -6)     # Warning. See #5
      => 6

You can also do multiple calculations at once with nested lists:  

    (+ (* 13 37) (- 4 2))

#### Conversion Rules
When doing arithmetics with different datatypes, the following rules will be applied

 - Integer + Integer = Integer
 - Float + Float = Float
 - Rational + Rational = Rational
 - Integer + Float = Float
 - Float + Rational = Float
 - Integer + Rational = Rational

The same rules are used vice versa and for the other arithmetics.

### Builtin-functions

#### define
Define a symbol and assign a value to it

    (define x 123)
    x
      => 123

Define a function and call it with parameters

    (define (myfunc a b c) (+ a (+ b c)))
    (myfunc 1 2 3)
      => 6

Each function has its own enviroment. So you can use a parameter in a function with a name you already define outside.

    (define a 10)
    (define (myfunc a) (+ a a))
    (myfunc 2)
      => 4
    a
      => 10

You can also access outside variables inside  a function.

    (define a 10)
    (define (myfunc b) (+ a b)
    (myfunc 10)
      => 20

#### if
    (if expression true false)

If expression returns something other then #f, then the true-expression is
evaluated. Else the false expression

    (if #t "true" "false")
      => true
    (if 1 "true" "false")
      => true
    (if #f "true" "false")
      => false
    (if (eq? 1 2) (cons 1 2) (+ 1 2))
      => 3

#### cons
Create a cons(list)

    (cons (1 2))
      => (1 . 2)

#### car
Get the first element of a cons(list)

    (car (cons 1 2))
      => 1

#### cdr
Get the last element of a cons  

    (cdr (cons 1 2))
      => 2

#### eq?
Compare objects.   
Returns #t if they are the same. #f if not

    (eq? 1 1)  
      => #t  
    (eq? 1 2)  
      => #f  
    (eq? "foo" "foo")  
      => #t  

#### Is type of x?
Returns #t if the given argument is instance of the asked type.

 - integer?
 - float?
 - rational?
 - symbol?
 - string?
 - cons?
 - builtin-function?
 - builtin-syntax?

Example:

    (integer? 1)
      => #t
    (integer? "foo)
      => #f
    (cons? (cons 1 2))
      => #t


## GUI

The GUI is pretty simple at the moment. All it does is displaying the current global environment.
When you define new stuff, the window updates its content.

More to come soon!
