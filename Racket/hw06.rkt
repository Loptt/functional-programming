#lang racket

(define (quickSort li)
    (if (null? li)
        '()
        (append 
            (quickSort (filter (lambda (x) (<= x (car li))) (cdr li)))
            (list (car li))
            (quickSort (filter (lambda (x) (> x (car li))) (cdr li)))
        )
    )
)

(define (rowByColumnsAux x y)
    (if (null? x)
        0
        (+ (* (car x) (caar y)) (rowByColumnsAux (cdr x) (cdr y)))

    )
)

(define (rowByColumns x y)
    (if (null? (car y))
        '()
        (cons (rowByColumnsAux x y) (rowByColumns x (map cdr y)))
    )
)

(define (matrixMultiply x y)
    (if (null? x)
        '()
        (cons (rowByColumns (car x) y) (matrixMultiply (cdr x) y))

    )
)

(define (averageRecords tbl sum n)
    (if (null? tbl)
        (/ sum n)
        (averageRecords (cdr tbl) (+ (cdar tbl) sum) (+ n 1))
    )
)

(define (summarize tbl)
    (append
        (list Male (averageRecords (filter (lambda (x) (= (car x) Male)) tbl)) 0 0)
        (list Female (averageRecords (filter (lambda (x) (= (car x) Female)) tbl)) 0 0)
    )
)

(summarize '((Male 178) (Female 165) (Female 158) (Female 182) (Male 161)))