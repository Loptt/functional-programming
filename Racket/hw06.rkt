#lang racket

;; 1-- Quicksort
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

;; Auxiliary function for multiply matrices
(define (rowByColumnsAux x y)
    (if (null? x)
        0
        (+ (* (car x) (caar y)) (rowByColumnsAux (cdr x) (cdr y)))
    )
)

;; Auxiliary function for multiply matrices
(define (rowByColumns x y)
    (if (null? (car y))
        '()
        (cons (rowByColumnsAux x y) (rowByColumns x (map cdr y)))
    )
)

;; 2-- Multiply matrices
(define (matrixMultiply x y)
    (if (null? x)
        '()
        (cons (rowByColumns (car x) y) (matrixMultiply (cdr x) y))

    )
)

;; 3-- Table summarization
(define (summarize tbl)
    (let ((filteredMale (filter (lambda (x) (string=? (car x) "Male")) tbl))
        (filteredFemale (filter (lambda (x) (string=? (car x) "Female")) tbl)))
        (list
            (list "Male" (/ (apply + (map cadr filteredMale)) (length filteredMale)))
            (list "Female" (/ (apply + (map cadr filteredFemale)) (length filteredFemale)))
        )
    )
)

;; (summarize '(("Male" 178) ("Female" 165) ("Female" 158) ("Female" 182) ("Male" 161)))

;; 4-- Binary search trees
(define (insertElement x t)
    (if (null? t)
        (list x '() '())
        (if (< x (car t))
            (list (car t) (insertElement x (cadr t)) (caddr t))
            (list (car t) (cadr t) (insertElement x (caddr t)))
        )
    )
)

;; (insertElement 10 '(8 (5 (2 () ()) (7 () ())) (9 () (15 (11 () ()) ()))))

;; path? helper
(define (processSources sources-lst d g)
    (cond
        ((null? sources-lst) #f)
        ((equal? (car sources-lst) d) #t)
        (else (or (dfs (car sources-lst) d g) (processSources (cdr sources-lst) d g)))
    )
)

;; path? helper 
(define (dfs s d g)
    (if (null? (filter (lambda (x) (equal? (car x) s)) g))
        #f
        (processSources (cdar (filter (lambda (x) (equal? (car x) s)) g)) d (filter (lambda (x) (not (equal? (car x) s))) g))
    )
)

;; 5-- Is there a path between two speciﬁc nodes in a graph?
;; Assuming a representation of adjacency lists
;; such as '((a b c) (b a c d) (c a b) (d b))
(define (path? g m n)
    (if (null? g)
        #f
        (or 
            (pathAux m n g)
            (pathAux n m g)
        )
    )
)

;; (path? '((a b) (b c d) (d c) (e f) (f e)) 'e 'f)