#lang racket

(define (hasModulo x d)
    (if (< d 2)
        #f
        (if (= (remainder x d) 0)
            #t
            (hasModulo x (- d 1))
        )
    )
)

(define (isPrime x)
    (not (hasModulo x (- x 1)))
)

(define (counterAux x)
    (if (= x 0)
        0
        (+ 1 (counterAux (quotient x 10)))
    )
)

(define (countDigits x)
    (if (null? x)
        0
        (+ (counterAux (car x)) (countDigits (cdr x)))
    )
)

(define (merge x y)
    (cond 
        ((and (null? x) (null? y)) '())
        ((null? x) y)
        ((null? y) x)
        (else 
            (if (< (car x) (car y))
                (cons (car x) (merge (cdr x) y))
                (cons (car y) (merge x (cdr y)))
            )
        )
    )
)

(define (myOr x y)
    (map (lambda (m n)
            (if (or (= m 1) (= n 1))
                1
                0
            )
        ) 
    x y)
)

(define (listToNumAux x n)
    (if (null? x)
        0
        (+ (* (car x) n) (listToNumAux (cdr x) (* n 10)))
    )
)

(define (listToNum x)
    (listToNumAux (reverse x) 1)
)

(define (addRow x)
    (if (null? x)
        0
        (+ (car x) (addRow (cdr x)))
    )
)

(define (addMatrix x)
    (if (null? x)
        0
        (+ (addRow (car x)) (addMatrix (cdr x)))
    )
)