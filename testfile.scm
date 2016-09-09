(define (not aBool)
    (if aBool #f #t))

(define (zero? n)
    (eq? n 0))

(define (negative? n)
    (< n 0))

(define (positive? n)
    (> n 0))

(define (fac-recursive n)
    (if (eq? n 1)
    	1
	  (* n (fac-recursive (- n 1))
    )))

(define (length-recursive l)
   (if (eq? l '())
	0
	(+ 1 (length-recursive (cdr l)))))


(define (fac n)
    (define (fac-helper accu n)
	(if (eq? n 1)
	    accu
	    (fac-helper (* accu n) (- n 1))))
    (fac-helper 1 n))

(define a (cons (cons "foo" (cons "1" 1)) (cons "a" "b")))
