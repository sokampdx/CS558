; KAM PUI SO (ANTHONY)
; CS558 Fall 2014
; Homework 2 Part 1

(define (tri x) (/ (* x (+ x 1)) 2))

(define (diag x y)
    (if (>= (tri y) x) y
        (diag x (+ y 1))))
        
(define (level x) (diag x 1))

(define (value_a x)
    (+ 1 (- (tri (level x)) x)))

(define (value_b x)
    (- (+ (level x) 1) (value_a x)))
    
(define (even_level x)
    (mod (level x) 2))
    
(define (cantor x)
    (if (<= x 0 ) 
		'()
    	(if (= (even_level x) 0) 
        	(cons (value_b x) (cons (value_a x) '()))
        	(cons (value_a x) (cons (value_b x) '()))
    	)
    )
)    
