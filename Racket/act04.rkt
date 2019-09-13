#lang racket

;; Carlos Estrada A01039919

;; 1
((lambda (x y) (+ x y)) 5 6)

;; 2
(define (filterSeven lst)
    (filter (lambda (x) (= (remainder x 7) 0)) lst)
)

;; 3
(define (sumNumbersRec lst)
    (if (null? lst)
        0
        (+ (car lst) (sumNumbersRec (cdr lst)))
    )
)

;; 4
(define (sumNumbersHigh lst)
    (apply + lst)
)

;; 5
(define (pathExists? g e)
    (not (null? (filter (lambda (x) (equal? x e)) g)))
)

;; The data structure chosen is a list of edges
(pathExists? '((a b) (b c)) '(c b))

;; 6
(define (matrixAdd x y)
    (if (null? x)
        '()
        (cons (map + (car x) (car y)) (matrixAdd (cdr x) (cdr y)))
    )
)

(matrixAdd '((1 2) (3 4)) '((1 2) (3 4)))

;; 7
(define (calculateBalance tbl)
    (- 
        (apply + (map caddr (filter (lambda (x) (string=? (car x) "in")) tbl)))
        (apply + (map caddr (filter (lambda (x) (string=? (car x) "out")) tbl)))
    )
)

(calculateBalance '(("in" "Salary" 4000) ("in" "Parents" 2000) ("out" "Rent" 3500) ("out" "food" 750) ("out" "hobbies" 400) ("in" "Scholarship" 2500)))
