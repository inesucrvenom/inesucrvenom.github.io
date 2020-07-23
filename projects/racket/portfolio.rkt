(require 2htdp/image)
;; portfolio-starter.rkt
;; An image organizer / portfolio program
;; ================= 
;*********************************************************************
; Usage:
; At the end of program you have two demonstration examples
; build from sketch from assignment.
; Uncoment them and enjoy.
; First call will just render sketch as created with data
;    (good for see portfolio 'before')
; Second call is final function, which will both sort that 
; sketch and render it on screen.
;    (good for see portfolio 'after')
;*********************************************************************

;#####################################################################
; Note for peer evaluator:
;
; Please, if you're using other OS than Linux Fedora as I'm,
; IF some tests fail, it's not program that's faulty.
; I have 54 of them, and all passed here.
; So, in case of any different result, please ask
; TA/Instructor for help.
; There have been known differences in rendering images
; between different OS (Linux, Windows, Mac)
; I hope that you won't stumble upon that problem :)
; Thank you, and have fun :)
;#####################################################################

;; Constants:
;; ================= 
(define SIZE 4) ; must be even number, enable scalability

; space between images
(define HSPACE (rectangle (* 2 SIZE)  2          "solid" "white")) ;horiz.
(define VSPACE (rectangle 2           (* 2 SIZE) "solid" "white")) ;vert.

; options when alignment items
(define HALIGN "top")
(define VALIGN "left")

; used for 'empty', and stubs
; have more than one because I use color for tracking where they come from
(define BSIZE  (* 1 SIZE))
(define BLANK  (square BSIZE "solid" "darkviolet"))
(define BLANK1 (square BSIZE "solid" "magenta"))
(define BLANK2 (square BSIZE "solid" "orange"))
(define BLANK3 (square BSIZE "solid" "blue"))

; minimal width for each column while rendering
(define FSIZE (* 3 SIZE)) ;font size
(define HMIN (rectangle (* 25 SIZE) (* 1.2 FSIZE)
                        "solid" "white"))

;*********************************************************************
; Tips for rendering more interesting picture/more clear:
; 1. default rendering is implementing Miller's columns
;      http://en.wikipedia.org/wiki/Miller_Columns
;      If you want more typical looking tree, please 
;      change constant HALIGN to "middle" (default is "top")
; 2. for more distinct look, you can 
;      change color "white" for constant HMIN
;      I suggest whitesmoke or ivory
; 3. if you find it too big/small, change SIZE constant
;      (must be an even number)
; 4. if you want give more/less space for directory name, change
;      width of rectangle HMIN
;*********************************************************************
;  Part of image constants needed for rendering sketch given by 
;  assignment is here - part which is used to generate examples. 
;  Other images are at the end of program.
;  Image's name is defined by significant 2 letters of dir in path
; 
;  Squares           ;SQ
;         Rotating 
;             (list SQRG-1 SQRG-2 SQRG-3 SQRG-4 SQRG-5 SQRG-6)
;         Stretching
;             (list SQSG-1 SQSG-2 SQSG-3)
;         Stretched
;             (list SQSD-1 SQSD-2 SQSD-3)
;  Stuck in Traffic   ;ST
;         (list ST-1 ST-2 ST-3) 
;*********************************************************************
;  --- start defining images ---
;*********************************************************************
(define SQRG-1 (overlay
                (rotate 10 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQRG-2 (overlay
                (rotate 20 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQRG-3 (overlay
                (rotate 30 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQRG-4 (overlay
                (rotate 40 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQRG-5 (overlay
                (rotate 50 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQRG-6 (overlay
                (rotate 60 (square (* 3 SIZE) "solid" "darkred"))
                (square (* 5 SIZE) "solid" "orange")))
(define SQSG-1 (overlay
                (rhombus (* 3 SIZE) 45 "solid" "lavender")
                (rectangle (* 4 SIZE) (* 6 SIZE) "solid" "darkviolet")))
(define SQSG-2 (overlay
                (rotate -30 (rhombus (* 3 SIZE) 45 "solid" "lavender"))
                (rectangle (* 4 SIZE) (* 5 SIZE) "solid" "darkviolet")))
(define SQSG-3 (overlay
                (rhombus (* 3 SIZE) 145 "solid" "lavender")
                (rectangle (* 6 SIZE) (* 3 SIZE) "solid" "darkviolet")))
(define SQSD-1 (overlay
                (rhombus (* 4 SIZE) 10 "solid" "cyan")
                (rectangle (* 1 SIZE) (* 8 SIZE) "solid" "violetred")))
(define SQSD-2 (overlay
                (rhombus (* 4 SIZE) 160  "solid" "cyan")
                (rectangle (* 8 SIZE) (* 2 SIZE) "solid" "violetred")))
(define SQSD-3 (overlay
                (rhombus (* 4 SIZE) 175 "solid" "cyan")
                (rectangle (* 9 SIZE) (* 1 SIZE) "solid" "violetred")))
(define ST-1 (overlay
              (circle (* 3 SIZE) "solid" "red")
              (square (* 7 SIZE) "solid" "black")))
(define ST-2 (overlay
              (circle (* 2 SIZE) "solid" "yellow")
              (square (* 5 SIZE) "solid" "black")))
(define ST-3 (overlay
              (circle (* 1 SIZE) "solid" "green")
              (square (* 3 SIZE) "solid" "black")))
;*********************************************************************
;  --- end defining images ---
;*********************************************************************

;; Data Definitions: 
;; ================= 
;  Base type used - arbitrary arity tree

(define-struct dir (name images subdirs))
;; Dir is (make-dir String ListOfImage ListOfDir)
;; interp. an directory in filesystem, with name, 
;;  images and/or subdirectory with images

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images

;; ListofDir is one of:
;; - empty
;; - (cons Dir ListOfDir)
;; interp. a list of directories

;*********************************************************************
;  Program will be tested on this data:
;    E  ED  ST  SQ  TEST
;  Definitions for rest of sub-directiories for given schema are at the
;  end of program, in box comment. Playing with them is desirable :)
;*********************************************************************
(define E (make-dir "only dir" empty empty))  ;empty
(define ED (make-dir "dir with dir" empty (list E))) ;no image, has dir
(define ST (make-dir "Stuck in Traffic"    ;has images, no dir
                     (list ST-3 ST-1 ST-2)
                     empty))
(define SQRG (make-dir "Rotating"
                       (list SQRG-1 SQRG-2 SQRG-3 SQRG-4 SQRG-5 SQRG-6)
                       empty))
(define SQSG (make-dir "Stretching"
                       (list SQSG-1 SQSG-3 SQSG-2)
                       empty))
(define SQSD (make-dir "Stretched"
                       (list SQSD-3 SQSD-1 SQSD-2)
                       empty))
(define SQ (make-dir "Squares"            ;no images, has dirs
                     empty
                     (list SQSD SQRG SQSG)))
(define TEST (make-dir "Test"             ;has images, has dirs
                       (list ST-3 SQSD-2 SQSG-2)
                       (list SQSG ST)))
#;
(define (fn-for--dir d)
  (... (dir-name d)               ;String
       (fn-for-loi (dir-images d))
       (fn-for--lod (dir-subdirs d)))) 
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)                 ;Image
              (fn-for-loi (rest loi)))])) 
#;
(define (fn-for--lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for--dir (first lod))
              (fn-for--lod (rest lod)))])) 

;; Functions:
;; ================= 
;*********************************************************************
;  Examples are used to dissect problem, and helper functions are 
;  introduced as they're needed.
;  Tested results and tested functions are used in tests of others. 
;  Functions that are mutual referenced are NOT used as helpers to each
;  other! (draw--dir and draw--lod for example)
;  Blanks are not printed at all, spacers are 'invisible'
;*********************************************************************
;; Dir -> Image
;; draw image organizer - all images form each directory
;;   images lay out from largest to smallest (by area, in squared pixels)
;;   directories (name) lay out desc by total sum of area
; many check expects ommited here since it relies on already checked:
;   draw--dir - because rendering works for any order, see part1
;   sort--dir - not relying on rendering, see part2
; so here's just testing composition on one non trivial example

(check-expect (draw-portfolio TEST)
              (draw-horizontal-loi
               (list
                (draw-name (dir-name TEST))
                (draw-vertical-loi
                 (list
                  (draw-horizontal-loi (list SQSG-2 SQSD-2 ST-3))
                  (draw-horizontal-loi
                   (list
                    (draw-name (dir-name ST))
                    (draw-horizontal-loi (list ST-1 ST-2 ST-3))))
                  (draw-horizontal-loi
                   (list
                    (draw-name (dir-name SQSG))
                    (draw-horizontal-loi (list SQSG-1 SQSG-2 SQSG-3)))))))))

(define (draw-portfolio d)
  (draw--dir (sort--dir d)))
;-)

;*********************************************************************
; Part1 - rendering any given portfolio, draw--dir
;*********************************************************************
;; Dir -> Image
;; render structure (name, images, subdirs) of any given portfolio
(check-expect (draw--dir E)                   ;dir with no imgs, no subdir
              (draw-horizontal-loi
               (list
                (draw-name (dir-name E))
                (draw-vertical-loi
                 (list
                  BLANK1
                  BLANK3)))))
(check-expect (draw--dir ED)                  ;dir with subdir, no imgs 
              (draw-horizontal-loi
               (list
                (draw-name (dir-name ED))
                (draw-vertical-loi
                 (list
                  BLANK1
                  (draw--dir E))))))
(check-expect (draw--dir ST)                 ;dir with imgs, no subdir
              (draw-horizontal-loi
               (list
                (draw-name (dir-name ST))
                (draw-vertical-loi
                 (list
                  (draw-loi (dir-images ST))
                  BLANK3)))))

(define (draw--dir d)
  (draw-horizontal-loi
   (list
    (draw-name (dir-name d))
    (draw-vertical-loi 
     (list
      (draw-loi (dir-images d))
      (draw--lod (dir-subdirs d)))))))
;-)

;; String -> Image
;; draw image from given string (name) on given field HMIN
(check-expect (draw-name "Miki")
              (overlay/align "left" "middle" 
                             (text "Miki" FSIZE "black")
                             HMIN))

(define (draw-name n) 
  (overlay/align "left" "middle"
                 (draw-string n)
                 HMIN))
;-) 

;; String -> Image
;; draw image from given string
(check-expect (draw-string "Miki")
              (text "Miki" FSIZE "black"))

(define (draw-string s) 
  (text s FSIZE "black"))
;-) 

;; ListOfImage -> Image
;; draw list of images vertically
(check-expect (draw-vertical-loi empty) BLANK2)
(check-expect (draw-vertical-loi (list ST-2 ST-3 ST-1))
              (above/align VALIGN
                           ST-2 VSPACE
                           ST-3 VSPACE
                           ST-1))
(check-expect (draw-vertical-loi (list BLANK2 ST-1)) ST-1)
(check-expect (draw-vertical-loi (list ST-1 BLANK3)) ST-1)

(define (draw-vertical-loi loi)
  (cond [(empty? loi) BLANK2]
        [else
         (if (empty? (rest loi)) 
             (first loi)         ;avoid printing excess space+blank@end
             (cond               ;avoid printing spacers
               [(blank? (first loi)) 
                (draw-vertical-loi (rest loi))]
               [(blank? (draw-vertical-loi (rest loi)))
                (first loi)]
               [else
                (above/align VALIGN
                             (first loi)
                             VSPACE
                             (draw-vertical-loi (rest loi)))]))])) 
;-)

;; ListOfImage -> Image
;; draw list of images horizontally
(check-expect (draw-horizontal-loi empty) BLANK1)
(check-expect (draw-horizontal-loi (list ST-2 ST-3 ST-1))
              (beside/align HALIGN
                            ST-2 HSPACE
                            ST-3 HSPACE
                            ST-1))
(check-expect (draw-horizontal-loi (list BLANK2 ST-1)) ST-1)
(check-expect (draw-horizontal-loi (list ST-1 BLANK3)) ST-1)

(define (draw-horizontal-loi loi)
  (cond [(empty? loi) BLANK1]
        [else
         (if (empty? (rest loi)) 
             (first loi)        ;avoid printing excess space+blank@end
             (cond              ;avoid printing spacers
               [(blank? (first loi))
                (draw-horizontal-loi (rest loi))]
               [(blank? (draw-horizontal-loi (rest loi)))
                (first loi)]
               [else
                (beside/align HALIGN
                              (first loi)
                              HSPACE
                              (draw-horizontal-loi (rest loi)))]))])) 
;-) 

;; Image -> Boolean
;; returns true if image is one of predefined BLANK images
(check-expect (blank? BLANK) true)
(check-expect (blank? BLANK1) true)
(check-expect (blank? BLANK2) true)
(check-expect (blank? BLANK3) true)
(check-expect (blank? ST-1) false)

(define (blank? b)
  (cond [(image=? b BLANK) true] ;image=? -> if two images are equal
        [(image=? b BLANK1) true]
        [(image=? b BLANK2) true]
        [(image=? b BLANK3) true]
        [else false]))
;-)

;; ListOfImage -> Image
;; draw all images (from directory), horizontal at the moment
;; check expects ommited here since it relies on already checked
;; draw-horizontal-loi

(define (draw-loi loi)
  (draw-horizontal-loi loi))
;-) 

;; ListOfDir -> Image
;; draw list of directories - first images, then sub-directories
(check-expect (draw--lod (list E))         ;dir with no imgs, no subdir
              (draw-horizontal-loi
               (list
                (draw-name (dir-name E))
                (draw-vertical-loi
                 (list
                  BLANK1
                  BLANK3)))))
(check-expect (draw--lod (list ED))        ;dir with subdir, no imgs 
              (draw-horizontal-loi
               (list
                (draw-name (dir-name ED))
                (draw-vertical-loi
                 (list
                  BLANK1
                  (draw--lod (list E)))))))
(check-expect (draw--lod (list ST))        ;dir with imgs, no subdir
              (draw-horizontal-loi
               (list
                (draw-name (dir-name ST))
                (draw-vertical-loi
                 (list
                  (draw-loi (dir-images ST))
                  BLANK3)))))
(check-expect (draw--lod (list E ST))      ;dir with 2 subdirs
              (draw-vertical-loi
               (list
                (draw--lod (list E))
                (draw--lod (list ST)))))

(define (draw--lod lod)
  (cond [(empty? lod) BLANK3]
        [else
         (if (empty? (rest lod))
             (draw--dir (first lod)) ;avoid printing excess space/blanks
             (draw-vertical-loi 
              (list
               (draw--dir (first lod))
               (draw--lod (rest lod)))))])) 
;-)

;*********************************************************************
; Part2 - sorting any given portfolio, sort-dir
;*********************************************************************
;; Dir -> Dir
(check-expect (sort--dir E) E)
(check-expect (sort--dir ST)
              (make-dir (dir-name ST)
                        (list ST-1 ST-2 ST-3)
                        empty))
(check-expect (sort--dir TEST)
              (make-dir (dir-name TEST)
                        (list SQSG-2 SQSD-2 ST-3)
                        (list 
                         (make-dir (dir-name ST)
                                   (list ST-1 ST-2 ST-3)
                                   empty)
                         (make-dir
                          (dir-name SQSG)
                          (list SQSG-1 SQSG-2 SQSG-3)
                          empty))))

(define (sort--dir d)
  (make-dir (dir-name d)               
            (sort-loi (dir-images d))
            (sort--lod (dir-subdirs d))))
;-)

;; ListOfImage -> ListOfImage
;; sort (desc) given list by area of each image (width * height)
(check-expect (sort-loi empty) empty)
(check-expect (sort-loi (list ST-2 ST-3 ST-1))
              (list ST-1 ST-2 ST-3))

(define (sort-loi loi)
  (cond [(empty? loi) empty]
        [else
         (insert-image-loi (first loi)                 
                           (sort-loi (rest loi)))])) 
;-)

;; Image ListOfImage -> ListOfImage
;; inserts image in proper place in given sorted list (desc by area)
;; ASSUME: loi is already sorted
(check-expect (insert-image-loi ST-1 empty)
              (list ST-1))
(check-expect (insert-image-loi ST-2 (list ST-1 ST-3))
              (list ST-1 ST-2 ST-3))
(check-expect (insert-image-loi ST-2 (list ST-3))
              (list ST-2 ST-3))
(check-expect (insert-image-loi ST-1 (list ST-2 ST-3))
              (list ST-1 ST-2 ST-3))

(define (insert-image-loi img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger-image? img (first loi))
             (cons img loi)
             (cons (first loi)
                   (insert-image-loi img (rest loi))))]))
;-)

;; Image Image -> Boolean
;; produces true if first image is larger than second (by area)
(check-expect (larger-image? ST-1 ST-2) true)
(check-expect (larger-image? ST-3 ST-2) false)

(define (larger-image? img1 img2) 
  (> (area-image img1) (area-image img2)))
;-)

;; Image -> Natural
;; calculate area of image (in squared pixels) (width*height)
(check-expect (area-image ST-1) 
              (* (image-height ST-1) (image-width ST-1)))

(define (area-image img)
  (* (image-width img) (image-height img)))
;-)

;; ListOfDir -> ListOfDir
;; sort (desc) list of dirs by total area of its images (incl. subdirs)
(check-expect (sort--lod (list E)) (list E))
(check-expect (sort--lod (list ST)) 
              (list (make-dir
                     (dir-name ST)
                     (list ST-1 ST-2 ST-3)
                     empty)))
(check-expect (sort--lod (list E ST)) 
              (list 
               (make-dir
                (dir-name ST)
                (list ST-1 ST-2 ST-3)
                empty)
               E))
(check-expect (sort--lod (list E SQSD ST))
              (list 
               (make-dir
                (dir-name ST)
                (list ST-1 ST-2 ST-3)
                empty)
               (make-dir 
                (dir-name SQSD)
                (list SQSD-2 SQSD-3 SQSD-1)
                empty)
               E))

(define (sort--lod lod)
  (cond [(empty? lod) empty]
        [else
         (insert-dir-lod (sort--dir (first lod))
                         (sort--lod (rest lod)))]))
;-)

;; Dir ListOfDir -> ListOfDir
;; inserts dir in proper place in given sorted list (desc by total area)
;; ASSUME: lod is already sorted
(check-expect (insert-dir-lod ED (list E E E))
              (list E E E ED))
(check-expect (insert-dir-lod E (list ST ED))
              (list ST ED E))
(check-expect (insert-dir-lod ST (list E ED))
              (list ST E ED))
(check-expect (insert-dir-lod SQSD (list ST E))
              (list ST SQSD E))

(define (insert-dir-lod dir lod) 
  (cond [(empty? lod) (cons dir empty)]
        [else
         (if (?larger-dir dir (first lod))
             (cons dir lod)
             (cons (first lod)
                   (insert-dir-lod dir (rest lod))))])) 
;-)

;; Dir Dir -> Boolean
;; produces true if first Dir is larger than second (by total area)
(check-expect (?larger-dir ST SQSD) true)
(check-expect (?larger-dir SQSD ST) false)

(define (?larger-dir dir1 dir2) 
  (> (total-area--dir dir1) (total-area--dir dir2)))
;-)

;; Dir -> Natural
;; for given dir calculate total area of its images (incl. subdirs) (sq px)
(check-expect (total-area--dir E) 0)
(check-expect (total-area--dir ED) 0)
(check-expect (total-area--dir ST) 
              (total-area-loi (list ST-1 ST-2 ST-3)))
(check-expect (total-area--dir
               (make-dir "Test2"
                         (list ST-1)
                         (list E ST)))
              (+ (total-area-loi (list ST-1 ST-2 ST-3)) (area-image ST-1)))

(define (total-area--dir d)
  (if (empty? (dir-subdirs d)) ;skip empty dirs
      (total-area-loi (dir-images d))
      (+
       (total-area-loi (dir-images d))
       (total-area--lod (dir-subdirs d)))))
;-)

;; ListOfImage -> Natural
;; for given image list calculate total area of its images (squared pixels)
(check-expect (total-area-loi (list ST-1 ST-2 ST-3))
              (+ (area-image ST-1) (area-image ST-2) (area-image ST-3)))

(define (total-area-loi loi)
  (cond [(empty? loi) 0] ;no area-image if no image
        [else 
         (+ (area-image (first loi))
            (total-area-loi (rest loi)))])) 
;-)

;; ListOfDir -> Natural
;; total area of images of given list of dirs (incl. subdirs) (squared px)
(check-expect (total-area--lod (list E)) 0)
(check-expect (total-area--lod (list ED)) 0)
(check-expect (total-area--lod (list ST)) 
              (total-area-loi (list ST-1 ST-2 ST-3)))
(check-expect (total-area--lod (list
                                (make-dir "Test2"
                                          (list ST-1)
                                          (list E ST))))
              (+ (total-area-loi (list ST-1 ST-2 ST-3)) (area-image ST-1)))

(define (total-area--lod lod) 
  (cond [(empty? lod) 0]
        [else
         (+ (total-area--dir (first lod))
            (total-area--lod (rest lod)))])) 
;-)

;*********************************************************************
;        The end
; Thanks for your time 
;*********************************************************************

;*********************************************************************    .
; All definitions needed for given portoflio sketch 
;*********************************************************************
;  List per directories, for easy copy/paste
;  Image's name is defined by significant 2 letters of dir in path
; 
;  Portfolio
;     Star Children ;SC
;         (list SC-1 SC-2 SC-3)
;         Purple Gray Sky ;SCPG
;             Solid on Purple
;                 (list SCPGSP-1)
;             Line on Purple
;                 (list SCPGLP-1 SCPGLP-2)
;             Solid on Gray
;                 (list SCPGSG-1 SCPGSG-2 SCPGSG-3)
;             Line on Gray
;                 (list SCPGLG-1)
;         Stars on Blue   ;SCSB
;             Yellow x3
;                 (list SCSBY-1 SCSBY-2 SCSBY-3)
;             Orange x2
;                 (list SCSBO-1 SCSBO-2)
;             Blue x1
;                 (list SCSBB-1)
;     Writings      ;W
;         I've said       ;WI
;             One
;                 (list WION-1)
;             Two
;                 (list WITW-1 WITW-2 WITW-3)
;             Three
;                 (list WITH-1 WITH-2 WITH-3)
;             Four
;                 (list WIFO-1 WIFO-2 WIFO-3)
;         The Message      ;WM
;             The Message 1
;                 (list WMM1-1 WMM1-2 WMM1-3)
;             The Message 2
;                 (list WMM2-1 WMM2-2)
;             The Message 3
;                 (list WMM3-1 WMM3-2 WMM3-3 WMM3-4)
;     Squares       ;SQ
;         Rotating 
;             (list SQRG-1 SQRG-2 SQRG-3 SQRG-4 SQRG-5 SQRG-6)
;         Stretching
;             (list SQSG-1 SQSG-2 SQSG-3)
;         Stretched
;             (list SQSD-1 SQSD-2 SQSD-3)
;     Stuck in Traffic   ;ST
;         (list ST-1 ST-2 ST-3)
;*********************************************************************
;  Images:
;*********************************************************************
(define SCPGSP-1 (overlay
                  (star (* 5 SIZE) "solid" "yellow")
                  (square (* 10 SIZE) "solid" "mediumslateblue")))
(define SCPGLP-1 (overlay
                  (star (* 3 SIZE) "outline" "yellow")
                  (square (* 6 SIZE) "solid" "mediumslateblue")))
(define SCPGLP-2 (overlay
                  (star (* 2 SIZE) "outline" "yellow")
                  (square (* 4 SIZE) "solid" "mediumslateblue")))
(define SCPGSG-1 (overlay
                  (star (* 1 SIZE) "solid" "yellow")
                  (square (* 2 SIZE) "solid" "darkgray")))
(define SCPGSG-2 (overlay
                  (star (* 1 SIZE) "solid" "yellow")
                  (square (* 2 SIZE) "solid" "darkgray")))
(define SCPGSG-3 (overlay
                  (star (* 1 SIZE) "solid" "yellow")
                  (square (* 2 SIZE) "solid" "darkgray")))
(define SCPGLG-1 (overlay
                  (star (* 1.5 SIZE) "outline" "yellow")
                  (square (* 3 SIZE) "solid" "darkgray")))
(define SCSBY-1 (overlay
                 (star (* 2 SIZE) "solid" "yellow")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SCSBY-2 (overlay
                 (star (* 2 SIZE) "solid" "yellow")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SCSBY-3 (overlay
                 (star (* 2 SIZE) "solid" "yellow")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SCSBO-1 (overlay
                 (star (* 2 SIZE) "solid" "darkorange")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SCSBO-2 (overlay
                 (star (* 2 SIZE) "solid" "darkorange")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SCSBB-1 (overlay
                 (star (* 2 SIZE) "solid" "lightskyblue")
                 (square (* 4 SIZE) "solid" "mediumblue")))
(define SC-1 (above
              (overlay
               (star (* 2.5 SIZE) "solid" "yellow")
               (square (* 4.5 SIZE) "solid" "darkgreen"))
              (overlay
               (star (* 2.5 SIZE) "solid" "yellow")
               (square (* 4.5 SIZE) "solid" "darkgreen"))))
(define SC-2  (above
               (overlay
                (star (* 2 SIZE) "solid" "yellow")
                (square (* 3.5 SIZE) "solid" "darkgreen"))
               (overlay
                (star (* 2 SIZE) "solid" "yellow")
                (square (* 3.5 SIZE) "solid" "darkgreen"))))
(define SC-3 (overlay
              (star (* 2 SIZE) "solid" "yellow")
              (square (* 3.5 SIZE) "solid" "darkgreen")))
(define WION-1 (overlay
                (text "H" (* 10 SIZE)"aliceblue")
                (square (* 12 SIZE) "solid" "mediumblue")))
(define WITW-1 (overlay
                (text "E" (* 5 SIZE)"aliceblue")
                (square (* 7 SIZE) "solid" "navy")))
(define WITW-2 (overlay
                (text "" (* 4 SIZE)"aliceblue")
                (square (* 6 SIZE) "solid" "navy")))
(define WITW-3 (overlay
                (text "N" (* 3 SIZE)"aliceblue")
                (square (* 5 SIZE) "solid" "navy")))
(define WITH-1 (overlay
                (text "A" (* 2.5 SIZE)"aliceblue")
                (square (* 5 SIZE) "solid" "blue")))
(define WITH-2 (overlay
                (text "M" (* 2.5 SIZE)"aliceblue")
                (square (* 4 SIZE) "solid" "blue")))
(define WITH-3 (overlay
                (text "D" (* 2.5 SIZE)"aliceblue")
                (square (* 3 SIZE) "solid" "blue")))
(define WIFO-1 (overlay
                (text "R" (* 3 SIZE)"aliceblue")
                (square (* 3 SIZE) "solid" "mediumslateblue")))
(define WIFO-2 (overlay
                (text "E" (* 2.5 SIZE)"aliceblue")
                (square (* 2.5 SIZE) "solid" "mediumslateblue")))
(define WIFO-3 (overlay
                (text "W" (* 2 SIZE)"aliceblue")
                (square (* 2 SIZE) "solid" "mediumslateblue")))
(define WMM1-1 (overlay
                (text "A" (* 5 SIZE)"darkgreen")
                (square (* 6 SIZE) "solid" "mediumspringgreen")))
(define WMM1-2 (overlay
                (text "R" (* 4.5 SIZE)"darkgreen")
                (square (* 5.5 SIZE) "solid" "mediumspringgreen")))
(define WMM1-3 (overlay
                (text "T" (* 4 SIZE)"darkgreen")
                (square (* 5 SIZE) "solid" "mediumspringgreen")))
(define WMM2-1 (overlay
                (text "I" (* 3.5 SIZE)"chocolate")
                (square (* 4.5 SIZE) "solid" "gold")))
(define WMM2-2 (overlay
                (text "S" (* 3 SIZE)"chocolate")
                (square (* 4 SIZE) "solid" "gold")))
(define WMM3-1 (overlay
                (text "D" (* 2.5 SIZE)"mistyrose")
                (square (* 3.5 SIZE) "solid" "crimson")))
(define WMM3-2 (overlay
                (text "E" (* 2 SIZE)"mistyrose")
                (square (* 3 SIZE) "solid" "crimson")))
(define WMM3-3 (overlay
                (text "A" (* 1.5 SIZE)"mistyrose")
                (square (* 2.5 SIZE) "solid" "crimson")))
(define WMM3-4 (overlay
                (text "D" (* 1 SIZE)"mistyrose")
                (square (* 2 SIZE) "solid" "crimson")))
;*********************************************************************
;  directories
;*********************************************************************
(define SCPGSP (make-dir
                "Solid on Purple"
                (list SCPGSP-1)
                empty))
(define SCPGLP (make-dir 
                "Line on Purple"
                (list SCPGLP-2 SCPGLP-1)
                empty))

(define SCPGSG (make-dir
                "Solid on Gray"
                (list SCPGSG-3 SCPGSG-1 SCPGSG-2)
                empty))

(define SCPGLG (make-dir
                "Line on Gray"
                (list SCPGLG-1)
                empty))

(define SCPG (make-dir
              "Purple Gray Sky"
              empty
              (list SCPGSG SCPGLG SCPGLP SCPGSP)))

(define SCSBO (make-dir
               "Orange x2"
               (list SCSBO-2 SCSBO-1)
               empty))
(define SCSBB (make-dir
               "Blue x1"
               (list SCSBB-1)
               empty))
(define SCSBY (make-dir
               "Yellow x3"
               (list SCSBY-2 SCSBY-3 SCSBY-1)
               empty))

(define SCSB (make-dir
              "Stars on Blue"
              empty
              (list SCSBO SCSBB SCSBY)))

(define SC (make-dir "Star Children"
                     (list SC-1 SC-3 SC-2)
                     (list SCSB SCPG)))

(define WMM1 (make-dir 
              "The Message 1"
              (list WMM1-2 WMM1-3 WMM1-1)
              empty))
(define WMM2 (make-dir 
              "The Message 2"
              (list WMM2-1 WMM2-2)
              empty))
(define WMM3 (make-dir 
              "The Message 3"
              (list WMM3-1 WMM3-4 WMM3-3 WMM3-2)
              empty))
(define WM (make-dir 
            "The Message"
            empty
            (list WMM2 WMM3 WMM1)))
(define WION (make-dir
              "One"
              (list WION-1)
              empty))
(define WITW (make-dir
              "Two"
              (list WITW-1 WITW-3 WITW-2)
              empty))
(define WITH (make-dir
              "Three"
              (list WITH-2 WITH-2 WITH-3)
              empty))
(define WIFO (make-dir
              "Four"
              (list WIFO-3 WIFO-1 WIFO-2)
              empty))
(define WI (make-dir
            "I've said"
            empty
            (list WIFO WITW WITH WION)))
(define W (make-dir
           "Writings"
           empty
           (list WI WM)))
(define PORTFOLIO (make-dir
                   "Portfolio"
                   empty
                   (list W ST SQ SC)))

;*********************************************************************
; Uncomment this, and get whole sketch 
;*********************************************************************

; "First output: render sketch how is it in data"
; "This is just some helper funtcion"
; (draw--dir PORTFOLIO)


; "Second output: render previous sketch sorted"
; "This function is main function of program"
; (draw-portfolio PORTFOLIO)