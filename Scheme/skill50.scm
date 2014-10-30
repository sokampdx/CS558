; Numbers Properties
;   Find all the factors of a positive integer
(define (factor x)
    (if (eqv? x 0)
        '()
        (factorOf (consList x) x)))
            
(define (factorOf lst x)
    (if (null? lst)
        '()
        (if (eqv? (mod x (car lst)) 0)
            (cons (car lst) (factorOf (cdr lst) x))
            (factorOf (cdr lst) x)))) 

;   Find a prime factorization of a positive integer
(define (primeFact x)
    (if (eqv? x 1)
            '()
            (checkPrime (factor x))))

(define (checkPrime lst)
    (if (null? lst)
        '()
        (if (eqv? (car lst) 1)
            (checkPrime (cdr lst))
            (cons (car lst) (checkPrime (removeDivisible (cdr lst) (car lst)))))))
                    
(define (removeDivisible lst p)
    (if (null? lst)
        '()
        (if (eqv? (mod (car lst) p) 0)
            (removeDivisible (cdr lst) p)
            (cons (car lst) (removeDivisible (cdr lst) p)))))

;   Tell whether a number is prime
(define (isPrime x)
    (if (< x 2)
        #f
        (eqv? x (car (checkPrime (factor x))))))

; Construct lists:
;   [1,2,3,...]
(define (consListS start end step)
    (if (> start end)
        '()
        (cons start (consListS (+ start step) end step))))

(define (consList x) (consListS 1 x 1))

;   [...,3,2,1]
(define (revConList x) (reverse (consList x)))

;   [0,2,4,6,...]
(define (evenList x) (consListS 0 x 2))

;   [1,3,5,7,...]
(define (oddList x) (consListS 1 x 2))

;   squares
(define (squareList x) (map square (consList x)))
(define (square x) (* x x))

;   triangulars
(define (triangleList x) (map triangle (consList x)))
(define (triangle x) (/ (* x (+ x 1)) 2))

;   primes
(define (primeList x) (checkPrime (consList x)))

;   fibonacci sequence
(define (fib x)
    (cond
        ((eqv? x 0) 0)
        ((eqv? x 1) 1)
        ((> x 1) (+ (fib (- x 1)) (fib (- x 2))))))
        
(define (fibList x)
    (cond
        ((eqv? x 0) '(0))
        ((eqv? x 1) '(0 1))
        ((> x 1) (append (fibList (- x 1)) (cons (fib x) '())))))

; Manipulate a list:
;   length of a list
(define (mylength lst)
    (if (null? lst)
        0
        (+ 1 (mylength (cdr lst)))))

;   append two list
(define (myappend a b)
    (if (null? a)
        b
        (cons (car a) (myappend (cdr a) b))))

;   reverse a list
(define (myreverse lst)
    (if (null? lst)
        '()
        (append (myreverse (cdr lst)) (cons (car lst) '()))))

;   find first element
(define (myhead lst) 
    (if (null? lst)
        '()
        (car lst)))

;   find last element
(define (mylast lst)
    (cond
        ((null? lst) '())
        ((null? (cdr lst)) (car lst))
        (else (mylast (cdr lst)))))

;   find n-th element
(define (findN n lst)
    (cond
        ((null? lst) '())
        ((< n 1) '())
        ((> n (length lst)) '())
        (else (findNC n 1 lst))))
        
(define (findNC n c lst)
    (if (eqv? n c)
        (car lst)
        (findNC n (+ c 1) (cdr lst))))

;   remove first element
(define (removeFirst lst)
    (if (null? lst)
        '()
        (cdr lst)))

;   remove given element
(define (removeElem x lst)
    (cond
        ((null? lst) '())
        ((eqv? x (car lst)) (cdr lst))
        (else (cons (car lst) (removeElem x (cdr lst))))))

;   remove last element
(define (removeLast lst)
    (cond
        ((null? lst) '())
        ((null? (cdr lst)) '())
        (else (cons (car lst) (removeLast (cdr lst))))))

;   remove n-th element
(define (removeNth n lst)
    (cond
        ((null? lst) '())
        ((< n 1) lst)
        ((> n (length lst)) lst)
        (else (removeNC n 1 lst))))

(define (removeNC n c lst)
    (if (eqv? n c)
        (cdr lst)
        (cons (car lst) (removeNC n (+ c 1) (cdr lst)))))

;   insert element at end
(define (insertLast x lst)
    (if (null? lst)
        (cons x '())
        (cons (car lst) (insertLast x (cdr lst)))))

;   insert element at n-th position
(define (insertNth x n lst)
    (cond
        ((null? lst) (cons x '()))
        ((< n 1) (cons x lst))
        ((> n (length lst)) (insertLast x lst))
        (else (insertNC x n 1 lst))))
        
(define (insertNC x n c lst)
    (if (eqv? n c)
        (cons x lst)
        (cons (car lst) (insertNC x n (+ c 1) (cdr lst)))))

;   take first n element
(define (takeN n lst)
    (cond
        ((null? lst) '())
        ((< n 1) '())
        ((> n (length lst)) lst)
        (else (takeNC n 1 lst))))
        
(define (takeNC n c lst)
    (if (< n c)
        '()
        (cons (car lst) (takeNC n (+ c 1) (cdr lst)))))

;   drop first n element
(define (dropN n lst)
    (cond
        ((null? lst) '())
        ((< n 1) lst)
        ((> n (length lst)) '())
        (else (dropNC n 1 lst))))
        
(define (dropNC n c lst)
    (if (< n c)
        lst
        (dropNC n (+ c 1) (cdr lst))))

;   take last n element
(define (takeLastN n lst)
    (cond 
        ((null? lst) '())
        ((< n 1) '())
        ((> n (length lst)) lst)
        (else (dropN (- (length lst) n) lst))))

;   drop last n element
(define (dropLastN n lst)
    (cond
        ((null? lst) '())
        ((< n 1) lst)
        ((> n (length lst)) '())
        (else (takeN (- (length lst) n) lst))))

;   remove all even numbers
(define (removeEven lst)
    (cond
        ((null? lst) '())
        ((eqv? (mod (car lst) 2) 0) (removeEven (cdr lst)))
        (else (cons (car lst) (removeEven (cdr lst))))))

;   remove all except even numbers
(define (removeOdd lst)
    (cond
        ((null? lst) '())
        ((eqv? (mod (car lst) 2) 1) (removeOdd (cdr lst)))
        (else (cons (car lst) (removeOdd (cdr lst))))))

;   remove every other element
(define (removeAlt lst)
    (cond 
        ((null? lst) '())
        ((null? (cdr lst)) lst)
        (else (cons (car lst) (removeAlt (cddr lst))))))

;   rotate left
(define (rotateL lst)
    (if (null? lst)
        '()
        (append (cdr lst) (cons (car lst) '()))))

;   rotate right
(define (rotateR lst)
    (if (null? lst)
        '()
        (cons (mylast lst) (takeN (- (length lst) 1) lst))))

;   add together all the numbers
(define (sumList lst)
    (if (null? lst)
        0
        (+ (car lst) (sumList (cdr lst)))))

;   average all the numbers
(define (aveList lst) (/ (sumList lst) (length lst)))

; Manipulate a binary search tree
;   build a tree
;   count the elements
;   count the elements with some property
;   test the membership of an element
;   insert an element
;   remove an element (harder)
;   traverse in pre/in/post-order
;   sum all the number
;   average the numbers

; Manipulate (general) trees
;   build a tree
;   count the elements
;   test the membership of an element
;   traverse in pre/post-order

