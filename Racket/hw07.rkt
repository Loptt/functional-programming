#lang racket

;; Complete the following functions and submit your file to Canvas.

;; ========= IMPORTANT ==========
;; Change the name of the file so that it contains your student ID or name.
;; Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
;; Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
;; Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
;; If your file cannot be loaded by the Racket interpreted, your grade will be zero. Then, submit only code that works.

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

(index 8 '(2 3 4 6))

(define (allDifferent? lst)
    
)

(define (set x)
	(display "Not yet implemented.")
)

(define (union x y)
	(display "Not yet implemented.")
)

(define (intersect x y)
  	(display "Not yet implemented.")
)

(define (det3x3 m)
	(display "Not yet implemented.") 
)