#lang racket

(define (transpose matrix)
    (cond
        ((null? (car matrix)) null)
        (else (cons (map car matrix) (transpose (map cdr matrix))))
    )
)

(transpose '((10 4 8) (4 7 10)))