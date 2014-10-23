
(define (add-x x) (lambda (y) (+ x y)))
(define add-2 (add-x 2))

(define (f x y)
    (let ((z (/ x 2)))
        (/ (+ y z) (- y z))))
        
