(define make-double (lambda (f)
    (lambda (x) (f x x))))
    

(define square (make-double *))
(define double (make-double +))


(define (try x y) (if x 1 (y)))

(define (downto n)
    (if (= 0 n) '()
      (cons n (downto (- n 1)))))
        
(define (upto n)
  (define (aux n r)
    (if (< n 1) r
      (aux (- n 1) (cons n r))))
  (aux n '()))

(define sum 
    (lambda (x y) (+ x y))
)

(define tri
    (lambda (x y) 
        (if (> x y) 0
            (+ x (tri (+ x 1) y)))))
