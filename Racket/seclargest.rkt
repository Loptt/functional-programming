#lang racket

(define (seclargest x l s)
    (if (null? x)
        s
        (if (> (car x) l)
            (seclargest (cdr x) (car x) l)
            (if (> (car x) s)
                (seclargest (cdr x) l (car x))
                (seclargest (cdr x) l s)
            )
        )
    )
)

(seclargest '(2 1 3 4 2) 0 0)