#lang racket

(define (removeRep x)
    (if (null? x)
        '()
        (if (not (member (car x) (cdr x)))
            (cons (car x) (removeRep (cdr x)))
            (removeRep (cdr x))
        )
    )
)

(define (move x n)
    (if (= n 0)
        x
        (move (cdr x) (- n 1))
    )
)

(define (createColumns x c)
    (if (= 0 c)
        '()
        (cons (car x) (createColumns (cdr x) (- c 1)))
    )
)

(define (createRows x r c)
    (if (= r 0)
        '()
        (cons (createColumns x c) (createRows (move x c) (- r 1) c))
    )
)

(define (list2matrix x r c)
    (if (not (= (remainder (length x) (* r c)) 0))
        x
        (createRows x r c)
    )
)

(define (product x y)
    (if (null? x)
        '()
        (append (map (lambda (n) (list (car x) n)) y) (product (cdr x) y))
    )
)

(define (get-zeroes n)
    (if (= n 0)
        '()
        (cons 0 (get-zeroes (- n 1)))
    )
)

(define (shift x n)
    (if (< n 0)
        (append x (get-zeroes (* n -1)))
        (append (get-zeroes n) x)
    )
)

(define (multiples x n)
    (filter (lambda (m) (= (remainder m n) 0)) x)
)

(define (combine x y)
    (map (lambda (n m) (map (lambda (a b) (list a b)) n m)) x y)
)

(define (products-sold tbl id)
    (apply + (map (lambda (w) (cadr w)) (map (lambda (y) (car (filter (lambda (z) (= (car z) id)) y))) (map (lambda (x) (cdr x)) tbl))))
)

(define (get-rest-list x n)
    (if (= n 0)
        x
        (get-rest-list (cdr x) (- n 1))
    )
)

(define (upperTriangularAux x n l)
    (if (= n 0)
        '()
        (cons (append (get-zeroes (- l n)) (get-rest-list (car x) (- l n))) (upperTriangularAux (cdr x) (- n 1) l))
    )
)

(define (upperTriangular x)
    (upperTriangularAux x (length x) (length x))
)

(define (valid-path? p)
    (if (null? p)
        #t
        (if (null? (cdr p))
            #t
            (and (equal? (cadar p) (caadr p)) (valid-path? (cdr p)))
        )
    )
)

(define (path? g p)
    (if (not (valid-path? p))
        #f
        (if (null? p)
            #t
            (and (member (car p) g) (path? g (cdr p)))
        )
    )
)

;; (path? '((a c) (b a) (b d) (c b) (c e) (e d) (e f) (e g)) '((c b) (b c) (a c) (c e) (e g)))

(define (select tbl key)
    (append (list key) (map (lambda (w) (cadar w)) (map (lambda (x) (filter (lambda (y) (equal? (car y) key)) x)) tbl)))
)

( define table '(
(( name " Charles ") ( age 24) )
(( age 23) ( name " Mary ") ( lastName " Danvers ") ( gender " female ") )
(( name " Caroline ") ( lastName " Ortiz ") ( age 19) )
)
)


( define ( enigmaB x y )
( x ( x y ) )
)


 (enigmaB (lambda (x) (list x)) '(-1 2 -3))