# RbScheme

A Scheme implementation in Ruby.  
This is a project for my university.  

Start RbScheme with `ruby scheme.rb`

## What it can do (so far)
### Calculation
For now only simple calculations  in the known scheme-syntax are possible.  
    
    (+ 13 37)
    (- 13 37)
    (/ 13 37)
    (* 13 37)  

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
      => 5
      
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

#### car
Get the first element of a cons(list)

    (car (cons 1 2))
      => 1

#### cons
Create a cons(list)

    (cons (1 2))
      => (1 . 2)

#### eq?
Compare objects.   
Returns #t if they are the same. #f if not

    (eq? 1 1)  
      => #t  
    (eq? 1 2)  
      => #f  
    (eq? "foo" "foo")  
      => #t  
