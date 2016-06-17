# RbScheme

A Scheme implementation written in Ruby.  
This is a project for my university in a lecture called "Implementation of advanced programming languages."  
Obviously it's not usable for production (yet?), but when implementing it, I learned a lot about how 
programming languages work.  
Feel free to submit bugs or recommendations for improvements.

## Dependencies

This is written in plain ruby. So it does not have any dependencies, beside the ruby language.  
I tested it with Ruby 2.3.1. If you use another version, please tell me wether it works or not.

## How to use
Start RbScheme with `ruby scheme.rb`  
This will bring you to the interactive mode.

You can also pass schemecode as a commandline argument

    ruby scheme.rb "(define a 10)"
    
If you want to skip the tests you can use "skiptest" as the second argument. This is only available for non-interactive-mode. It is usefull for debugging the code.

    ruby scheme.rb "(define a 10)" skiptest
    
## What it can do (so far)
### Arithmetics
You can to simple calculatins in the known scheme-syntax.  
    
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

#### cons
Create a cons(list)

    (cons (1 2))
      => (1 . 2)

#### cons?
Returns true if the argument is a cons. False otherwise.

    (cons? (cons 1 2))
      => #t
    (cons? 1)
      => #f

#### car
Get the first element of a cons(list)

    (car (cons 1 2))
      => 1

#### cdr
Get the last element of a cons  
(Warning: Still has a bug. See #1)

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
