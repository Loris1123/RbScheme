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

### Symbols
You can define some symbols in the code. Symbol-definition will follow!  
For now there are two symbols predefined. `a => 10` and `b => 20`  
You can use them in your calculations aswell. 

### Builtin-functions
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
