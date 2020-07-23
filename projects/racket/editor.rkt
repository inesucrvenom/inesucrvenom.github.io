(require 2htdp/image)
(require 2htdp/universe)

;; editor-project-starter.rkt
;;
;; In this project you will design a simple one line text editor.  
;;
;; The screen looks like:
;; 
;;     abc|def
;;
;; where | is the cursor.
;;
;; Typing a character inserts that character before the cursor.
;; The backspace key deletes the character before the cursor.
;; The left and right arrow keys move the cursor left and right.



;; =================================================================================
;; Constants:

(define WIDTH  200)
(define HEIGHT  20)

(define TEXT-SIZE  18)
(define TEXT-COLOR "BLACK")

(define CURSOR (rectangle 1 20 "solid" "red"))

(define MTS (empty-scene WIDTH HEIGHT))



;; =================================================================================
;; Data Definitions:

(define-struct editor (txt cp))
;; Editor is (make-editor String Natural)
;; interp. the current text (txt) and cursor position (cp) using a 0-based index

(define ED1 (make-editor ""       0)) ; empty
(define ED2 (make-editor "abcdef" 0)) ; cursor at beginning as in |abcdef
(define ED3 (make-editor "abcdef" 3)) ; cursor in middle of text as in abc|def
(define ED4 (make-editor "abcdef" 6)) ; cursor at end as in abcdef|

#;
(define (fn-for-editor e)
  (... (editor-txt e)
       (editor-cp e)))

;; =================================================================================
;; Functions:

;; Editor -> Editor
;; start the world with an initial state e, for example (main (make-editor "" 0))
(define (main e)
  (big-bang e
            (to-draw    render)                  ; Editor -> Image
            (on-key     handle-key)))            ; Editor KeyEvent -> Editor



;; Editor -> Image
;; place text with cursor at left, middle edge of MTS
; original test
(check-expect (render (make-editor "abcdef" 3))
              (overlay/align "left"
                             "middle"
                             (beside (text "abc" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "def" TEXT-SIZE TEXT-COLOR))
                             MTS))
; another example using helper function draw-text, to clear up things:
(check-expect (render (make-editor "ggg45hh" 4))
              (overlay/align "left"
                             "middle"
                             (beside (draw-text "ggg4")
                                     CURSOR
                                     (draw-text "5hh"))
                             MTS))
; another example, with h.f. merge-parts = part1 | part2, to clear up more:
(check-expect (render (make-editor "iiii56jjj" 5))
              (overlay/align "left" "middle"
                             (merge-parts (draw-text "iiii5") (draw-text "6jjj"))
                             MTS))
; example when cursor is at the beginning
(check-expect (render (make-editor "begin" 0))
              (overlay/align "left" "middle"
                             (merge-parts (draw-text "") (draw-text "begin"))
                             MTS))
; example when cursor is at the end
(check-expect (render (make-editor "endend" 6))
              (overlay/align "left" "middle"
                             (merge-parts (draw-text "endend") (draw-text ""))
                             MTS))
; (define (render e) MTS) ;stub
; use template from Editor

;  Concluded idea:
;  split string in two parts on cp, and combine images of parts: P1|P2 

(define (render e)
  ;combine images to MTS
  (merge-parts
   (draw-text (substring (editor-txt e) 0             (editor-cp e)))  ;P1
   (draw-text (substring (editor-txt e) (editor-cp e)             )))) ;P2



; --- start --- helper functions for make-editor
;; String -> Image
;; draw image text from given string
(check-expect (draw-text "fff") (text "fff" TEXT-SIZE TEXT-COLOR))
; (define (draw-text t) (square 10 "solid" "red")) ;stub
#;
(define (draw-text t)
  (... t))

(define (draw-text t) (text t TEXT-SIZE TEXT-COLOR))



;; Image Image -> Image
;; merge two parts into one image on MTS, with cursor in middle: P1|P2
(check-expect (merge-parts (draw-text "kkk") (draw-text "lll"))
              (overlay/align "left" "middle"
                             (beside (draw-text "kkk")
                                     CURSOR
                                     (draw-text "lll"))
                             MTS))
; (define (merge-parts I1 I2) (square 10 "solid" "red")) ;stub
#;
(define (merge-parts I1 I2)
  (... I1 I2) )

(define (merge-parts I1 I2)
  (overlay/align "left" "middle"
                 (beside I1
                         CURSOR
                         I2)
                 MTS))

; --- end --- helper functions for make-editor



;; Editor KeyEvent -> Editor
;; call appropriate function for each keyboard command
(check-expect (handle-key (make-editor "meow" 3) "left")  (make-editor "meow" 2))
(check-expect (handle-key (make-editor "woof" 0) "right") (make-editor "woof" 1))
(check-expect (handle-key (make-editor "qwack" 3) "\b")   (make-editor "qwck" 2))
(check-expect (handle-key (make-editor "wack" 0) "Q")     (make-editor "Qwack" 1))
(check-expect (handle-key (make-editor "krek" 3) "e")     (make-editor "kreek" 4))
(check-expect (handle-key (make-editor "woof" 4) "!")     (make-editor "woof!" 5))
(check-expect (handle-key (make-editor "hiss" 2) "shift") (make-editor "hiss" 2))

;(define (handle-key e key) e) ;stub

(define (handle-key e key)
  (cond [(key=? key "left")        (move-cursor-left e)]
        [(key=? key "right")       (move-cursor-right e)]
        [(key=? key "\b")          (delete-before e)]      
        [(= (string-length key) 1) (insert-char key e)]
        [else e]))

; Note: 
; "left" is the left arrow key, "right" is the right arrow key, and 
; "\b" is the backspace key.




; --- start --- helper functions for handle-key
;; Editor -> Editor
;; move cursor left (unless already at left end of text), arrow key left
(check-expect (move-cursor-left (make-editor "miki" 3))  (make-editor "miki" 2))
(check-expect (move-cursor-left (make-editor "bmiki" 0)) (make-editor "bmiki" 0))
; (define (move-cursor-left e) e) ;stub
; use template from Editor

(define (move-cursor-left e)
  (if (> (editor-cp e) 0)
      (make-editor (editor-txt e) (sub1 (editor-cp e))) ;subtract one, decrement
      e))


;; Editor -> Editor
;; move cursor right (unless already at right end of text), arrow key right
(check-expect (move-cursor-right (make-editor "kiki" 3))  (make-editor "kiki" 4))
(check-expect (move-cursor-right (make-editor "ekiki" 6)) (make-editor "ekiki" 6))
; (define (move-cursor-right e) e) ;stub
; use template from Editor

(define (move-cursor-right e)
  (if (< (editor-cp e) (string-length (editor-txt e)))
      (make-editor (editor-txt e) (add1 (editor-cp e))) ;add one, increment
      e))



;; Editor -> Editor
;; delete char before the cursor (if there's one), key backspace
(check-expect (delete-before (make-editor "fifi" 3))  (make-editor "fii" 2))
(check-expect (delete-before (make-editor "bfifi" 0)) (make-editor "bfifi" 0))
; (define (delete-before e) e) ;stub
; use template from Editor

(define (delete-before e)
  (if (> (editor-cp e) 0)
      (make-editor
       (string-shrink (editor-txt e) (editor-cp e))
       (sub1 (editor-cp e)))
      e))



;; String Natural -> String
;; for given string and cursor pos (> 0) return string one char less at that pos
(check-expect (string-shrink "One word" 3) "On word")
(check-expect (string-shrink "Hello" 5) "Hell")
;(define (string-shrink str pos) "test") ;stub
#;
(define (string-shrink str pos)
  (... str pos))

(define (string-shrink str pos)
  (string-append (substring str 0 (sub1 pos)) ;first part - last char
                 (substring str pos)))        ;rest



;; Key Editor -> Editor
;; normal character inserted at the cursor position
(check-expect (insert-char "h" (make-editor "Jon Doe" 2))
              (make-editor "John Doe" 3))
(check-expect (insert-char "s" (make-editor "Jon Doe" 7))
              (make-editor "Jon Does" 8))
(check-expect (insert-char "J" (make-editor "Jon Doe" 0))
              (make-editor "JJon Doe" 1))
; (define (insert-char key e) e) ;stub
#;
(define (insert-char key e)
  (... key 
       (editor-txt e)
       (editor-cp e)))

(define (insert-char key e)
  (make-editor
   (string-grow (editor-txt e) key (editor-cp e)) 
   (add1 (editor-cp e))))



;; String String Natural -> String
;; for given string, char, pos return string with char inserted at that pos
(check-expect (string-grow "One world" "s" 3) "Ones world")
(check-expect (string-grow "ero" "H" 0) "Hero")
(check-expect (string-grow "Hey" "!" 3) "Hey!")
;(define (string-grow str c pos) "testing")
#;
(define (string-grow str c pos)
  (... str s pos))

(define (string-grow str c pos)
  (string-append (substring str 0 pos) ;first part
                 c
                 (substring str pos))) ;rest

; --- end --- helper functions for handle-key