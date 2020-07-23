;; Backtracking genrec search for 4 queens problem
;; ----------------------------------------------------------------------

;; ==== Usage =====
;; (queens BD4) for test on empty board
;; (print (queens BD4)) for 1string, not number output

;; ==== Notes =====
;; "BOT:" means "based on template for"

;; ==== Constants =====
(define L 8) ; blank, not attacked empty square (no queen on it)
(define Q 1) ; Queen
(define X 0) ; attacked empty square (no queen on it)

(define SIZE 4) ; size of problem, number of queens
(define BSIZE (* SIZE SIZE)) ; size of board

; positions of the all squares in rows, colums, diagonals
(define POSITIONS (build-list BSIZE identity))

(define ROWS (list
              (list 0 1 2 3)
              (list 4 5 6 7)
              (list 8 9 10 11)
              (list 12 13 14 15)))
(define COLS (list
              (list 0 4 8 12)
              (list 1 5 9 13)
              (list 2 6 10 14)
              (list 3 7 11 15)))
(define DIAG (list
              (list 3)
              (list 2 7)
              (list 1 6 11)
              (list 0 5 10 15)
              (list 4 9 14)
              (list 8 13)
              (list 12)))
(define CDIAG (list
               (list 0)
               (list 1 4)
               (list 2 5 8)
               (list 3 6 9 12)
               (list 7 10 13)
               (list 11 14)
               (list 15)))

(define UNITS (append ROWS COLS DIAG CDIAG))

;; ==== Data definitions =====
;; Val is one of:
;; - 8
;; - 1
;; - 0
;; interp. same as constants L, Q, X respectively
#;
(define (fn-for-val v)
  (cond [(= v 8) (...)]
        [(= v 1) (...)]
        [(= v 0) (...)]))

;; Board is (listof Val) that is BSIZE elements long
;; interp. 
;; board is SIZE x SIZE array of squares (= BSIZE)
;; FACT/ASSUME: each board IS VALID
;;   achieved by proper construction:
;;     each Q determines EXACT position of all T squares
;; in board each square has (r, c) position (row, column)
;; we represent it as single list, rows are layed out one after another
;; see interp. of Pos for conversion Pos to (r, c)
#; 
(define (fn-for-bd bd) ;also, analogue template is for any list lox
  (cond [(empty? bd) (...)]
        [else
         (... (first bd) (rest bd))]))

;; Pos is Natural[0, BSIZE-1]
;; interp. the position of a square on the board
;; for a given p, then
;;   - the row    is (quotient p SIZE)
;;   - the column is (remainder p SIZE)
#;
(define (fn-for-pos p)
  (... p))

;; Natural[0, SIZE-1] Natural[0, SIZE-1] -> Natural[0, BSIZE-1]
;; convert 0-based (r, c) to Pos
(check-expect (r-c->pos 2 1) 9)

(define (r-c->pos r c)                  ;BOT: atomic non-distinct x2
  (+ (* r SIZE) c))
;-)

;; ===== Data examples ====
(define BD4          ; empty board4
  (list L L L L
        L L L L
        L L L L
        L L L L))

(define BD4-0        ; board4 with queen on Pos 0
  (list Q X X X
        X X L L
        X L X L
        X L L X))

(define BD4-9        ; board4 with queen on Pos 9
  (list L X L X
        X X X L
        X Q X X
        X X X L))

(define BD4-15       ; board4 with queen on Pos 15
  (list X L L X
        L X L X
        L L X X
        X X X Q))

(define BD4-2-9      ; board4 with queens on Pos 2 and 9
  (list X X Q X
        X X X X
        X Q X X
        X X X L))

(define BD4-2-9-15   ; board4 with queens on Pos 2, 9 and 15
  (list X X Q X
        X X X X
        X Q X X
        X X X Q))

(define BD4-Q1       ; solution for board4
  (list X Q X X
        X X X Q
        Q X X X
        X X Q X))

(define BD4-Q2      ; solution for board4
  (list X X Q X
        Q X X X
        X X X Q
        X Q X X))

;; ==== Functions =====
;; Board -> Board
;; produce a solution for given board; or false if it cannot find it
;; ASSUME: given board is empty, has no queens
;; ASSUME: each board is valid
(check-expect (queens BD4) BD4-Q1)

(define (queens bd)                     ;BOT: AAtree (MR), genrec search
  (local [(define (solve--bd bd)
            (if (solved? bd)
                bd
                (solve--lobd (next-boards bd))))
          (define (solve--lobd lobd)
            (cond [(empty? lobd) false]
                  [else
                   (local [(define try (solve--bd (first lobd)))]
                     (if (not (false? try))
                         try
                         (solve--lobd (rest lobd))))]))]
    (solve--bd bd)))
;-)

;; Board -> Boolean
;; produce true if board is solved
;; ASSUME: board is valid, so it's solved if it has SIZE queens
(check-expect (solved? BD4)        false)
(check-expect (solved? BD4-0)      false)
(check-expect (solved? BD4-2-9-15) false)
(check-expect (solved? BD4-Q1)     true)
(check-expect (solved? BD4-Q2)     true)

(define (solved? bd)                    ;BOT: composition, filter
  (local [(define (Q? v)
            (= Q v))]
    (= SIZE (length (filter Q? bd)))))
;-)

;; Board -> (listof Board)
;; produce list of valid next-boards from board
;; finds all empty squares (L)
;; put a Queen in each of them (and hers' Ts)
(check-expect (next-boards BD4-2-9) (list (fill-queen 15 BD4-2-9)))
(check-expect (next-boards BD4-9)   
              (list 
               (fill-queen 0 BD4-9)
               (fill-queen 2 BD4-9)
               (fill-queen 7 BD4-9)
               (fill-queen 15 BD4-9)))

(define (next-boards bd)                ;BOT: composition
  (queens-on-boards bd (find-blanks bd)))
;-)

;; Board -> (listof Pos)
;; produce the positions of all blank squares; empty if none
(check-expect (find-blanks BD4)     POSITIONS)
(check-expect (find-blanks BD4-0)   (list 6 7 9 11 13 14))
(check-expect (find-blanks BD4-9)   (list 0 2 7 15))
(check-expect (find-blanks BD4-2-9) (list 15))

(define (find-blanks bd)                ;BOT: filter
  (local [(define (blank? p)
            (= L (read-square bd p)))]
    (if (empty? bd)
        empty
        (filter blank? POSITIONS))))
;-)

;; Board Pos -> Val
;; produce value at given position on board
(check-expect (read-square BD4-0 (r-c->pos 0 0)) Q)
(check-expect (read-square BD4-0 (r-c->pos 1 3)) L)

(define (read-square bd p)              ;BOT: list-ref
  (list-ref bd p))               
;-)

;; Board (listof Pos) -> (listof Board)
;; produce list of valid boards with Q at given p, and X for all attacked
(check-expect (queens-on-boards BD4-2-9 (find-blanks BD4-2-9))
              (list (fill-queen 15 BD4-2-9)))
(check-expect (queens-on-boards BD4-9 (find-blanks BD4-9))
              (list 
               (fill-queen 0 BD4-9)
               (fill-queen 2 BD4-9)
               (fill-queen 7 BD4-9)
               (fill-queen 15 BD4-9)))

(define (queens-on-boards bd lop)       ;BOT: list
  (cond [(empty? lop) empty]
        [else
         (cons
          (fill-queen (first lop) bd)
          (queens-on-boards bd (rest lop)))]))
;-)

;; Pos Board -> Board
;; produces one board where Q is on p, and X on all attacked squares
(check-expect (fill-queen (r-c->pos 0 0) BD4)   BD4-0)
(check-expect (fill-queen (r-c->pos 0 2) BD4-9) BD4-2-9)

(define (fill-queen qp bd)              ;BOT: composition
  (fill-T (attacked-positions qp)
          (fill-square bd qp Q)))
;-)

;; (listof Pos) Board -> Board
;; produces board where X are on all attacked squares from qp
(check-expect (fill-T (attacked-positions 0) (fill-square BD4 0 Q))
              BD4-0)

(define (fill-T lop bd)                 ;BOT: list
  (cond [(empty? lop) bd]
        [else
         (fill-T (remove (first lop) lop)
                 (fill-square bd (first lop) X))]))
;-)

;; Pos -> (listof Pos)
;; produces list of squares under attack from qp (no qp included)
(check-expect (attacked-positions (r-c->pos 2 1))
              (list 1 3 4 5 6 8 10 11 12 13 14))

(define (attacked-positions qp)         ;BOT: composition
  (remove qp (sort (remove-duplicates
                    (merge-units (attacked-units qp UNITS))) <)))
;-)

;; Pos (listof Unit) -> (listof Unit)
;; produces list of units that are under attack from queen on qp
(check-expect (attacked-units (r-c->pos 2 1) UNITS)
              (list
               (list 8 9 10 11)
               (list 1 5 9 13)
               (list 4 9 14)
               (list 3 6 9 12)))

(define (attacked-units qp lou)         ;BOT: filter
  (local [(define (has-member? u)
            (member? qp u))]
    (filter has-member? lou)))
;-)

;; (listof Unit) -> (listof Pos)
;; produces list of all merged units
(check-expect (merge-units (list
                            (list 8 9 10 11)
                            (list 1 5 9 13)
                            (list 4 9 14)
                            (list 3 6 9 12)))
              (list 8 9 10 11 1 5 9 13 4 9 14 3 6 9 12))

(define (merge-units lou)               ;BOT: list
  (cond [(empty? lou) empty]
        [else
         (append (first lou)
                 (merge-units (rest lou)))]))
;-)

;; Board Pos Val -> Board
;; produce new board with val at given position
(check-expect (fill-square BD4 (r-c->pos 0 0) 1)
              (cons 1 (rest BD4)))

(define (fill-square bd p nv)           ;BOT: Board
  (cond [(zero? p) (cons nv (rest bd))]
        [else
         (cons (first bd)
               (fill-square (rest bd) (sub1 p) nv))]))
;-)

;; (listof X) -> (listof X)
;; abstract function: produce list of X with no duplicates
(check-expect (remove-duplicates (list BD4-0 BD4-15 BD4-15 BD4-9 BD4-0))
              (list BD4-0 BD4-15 BD4-9))
(check-expect (remove-duplicates (list 2 3 4 1 8 4 9 3 2))
              (list 2 3 4 1 8 9))

(define (remove-duplicates lox)         ;BOT: foldr, list, filter
  (local [(define (remove-all-for-one x lox)
            (cons x
                  (local [(define (not-equal y)
                            (not (equal? x y)))]
                    (filter not-equal lox))))]
    (foldr remove-all-for-one empty lox)))
;-)

;; ==== Not in assignment =====
;; Board -> (listof String)
;; produces string literals for maybe? easier reading
(check-expect (print BD4) (local [(define (fn v) "L")] (map fn BD4)))

(define (print bd)                      ;BOT: map, Val
  (local [(define (v->ch v)
            (cond [(= v L) "L"]
                  [(= v Q) "Q"]
                  [(= v X) "X"]))]
    (map v->ch bd)))
;-)