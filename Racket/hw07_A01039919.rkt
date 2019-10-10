#lang racket

;; Complete the following functions and submit your file to Canvas.

;; ========= IMPORTANT ==========
;; Change the name of the file so that it contains your student ID or name.
;; Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
;; Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
;; Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
;; If your file cannot be loaded by the Racket interpreted, your grade will be zero. Then, submit only code that works.

;; Carlos Estrada A01039919

(define (exist? x lst)
    (cond
        ((null? lst) #f)
        ((= (car lst) x) #t)
        (else (exist? x (cdr lst)))
    )
)

(define (indexAux x n lst)
    (cond
        ((null? lst) -1)
        ((= (car lst) x) n)
        (else (indexAux x (+ n 1) (cdr lst)))
    )
)

(define (index x lst)
	(indexAux x 0 lst)
)

(define (allDifferent? lst)
    (if (null? lst)
        #t
        (and (not (exist? (car lst) (cdr lst))) (allDifferent? (cdr lst)))
    )
)

(define (set x)
    (if (null? x)
        '()
        (if (and (number? (car x)) (not (exist? (car x) (cdr x))))
            (cons (car x) (set (cdr x)))
            (set (cdr x))
        )
    )
)

(define (union x y)
    (set (append x y))
)

(define (getRepeated x)
    (if (null? x)
        '()
        (if (exist? (car x) (cdr x))
            (cons (car x) (getRepeated (cdr x)))
            (getRepeated (cdr x))
        )
    )
)

(define (intersect x y)
    (getRepeated (append (set x) (set y)))
)

(define (getFromRow y r)
    (if (= y 1)
        (car r)
        (getFromRow (- y 1) (cdr r))
    )
)

(define (getElement x y m)
    (if (= x 1)
        (getFromRow y (car m))
        (getElement (- x 1) y (cdr m))
    )
)

(define (det3x3 m)
    (-
        (+ 
            (* (getElement 1 1 m) (getElement 2 2 m) (getElement 3 3 m))
            (* (getElement 1 2 m) (getElement 2 3 m) (getElement 3 1 m))
            (* (getElement 1 3 m) (getElement 2 1 m) (getElement 3 2 m))
        )
        (+
            (* (getElement 3 1 m) (getElement 2 2 m) (getElement 1 3 m))
            (* (getElement 3 2 m) (getElement 2 3 m) (getElement 1 1 m))
            (* (getElement 3 3 m) (getElement 2 1 m) (getElement 1 2 m))
        )
    )
)
