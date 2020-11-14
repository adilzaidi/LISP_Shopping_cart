
;Program: Shopping Simulator
;Description: Simulates a shopping scenario where a user can purchase items, view item categories, access an ATM, and manage a shopping cart. 


;Global Variables
(defvar savings 10000)
(defvar wallet 2000)
(defvar items 0)

;Array Creation
(setf history (make-array '(100)))


;Constant
(defconstant TAX .0725)

;---Functions---

(defun menu () "This function starts the program with several options."
    (write-line " ")
    (write-line "Hello, I am your personal shopping assistant. What would you like to do today?")
    (write-line "(1) Purchase Items")
    (write-line "(2) Access ATM")
    (write-line "(3) Exit")
    
    (setq choice (read))
     (case choice
        (1 (categories))
        (2 (atm))
        (3 (write-line "Thank You. Have a Great Day!")))
)



(defun categories () "This function displays the items that can be purchased." 
    (write-line " ")
    (write-line "What would you like to buy? Price Does Not Include Tax (7.25%)")
    
    (dolist (a '("(1) T-Shirt: 20$" "(2) Video Game: 60$" "(3) Television: 300$" "(4) Go Back"))
         (write-line a))
         
    (setq a (read))
    (case a 
        (1 (setq wallet (- wallet (+ 20 (* 20 TAX))))
            (write-line "Thank you. Your new balance is: ")
            (write wallet)
            (princ "$")
            (write-line " ")
            (setf (aref history items) "T-Shirt: 20$")
            (setq items (+ items 1))
            (categories))
        (2 (setq wallet (- wallet (+ 60 (* 60 TAX))))
            (write-line "Thank you. Your new balance is: ")
            (write wallet)
            (princ "$")
            (write-line " ")
            (setf (aref history items) "Video Game: 60$")
            (setq items (+ items 1))    
            (categories))
        (3 (setq wallet (- wallet (+ 300 (* 300 TAX))))
            (write-line "Thank you. Your new balance is: ")
            (write wallet)
            (princ "$")
            (write-line " ")
            (setf (aref history items) "Television: 300$")
            (setq items (+ items 1))    
            (categories))
        (4 (menu)))
) 


(defun atm () "This function displays the atm prompt."
    (write-line " ")
    (write-line "What would you like to do?")
    (write-line "(1) Withdraw")
    (write-line "(2) Check Balance")
    (write-line "(3) View Purchase History")
    (write-line "(4) Go Back")
    (write-line "(5) Exit Program")
    
    (setq a (read))
    (case a 
        (1 (withdraw))
        (2 (write-line "---Your Savings Balance---")
        (write savings)
        (princ "$")
        (write-line " ")
        (write-line "---Your Wallet Balance---")
        (write wallet)
        (princ "$")
        (write-line " ")
        (atm))
        (3 (viewHist items))   
        (4 (menu))
        (5 (write-line "Thank You.")))
)

(defun withdraw () 
    (write-line "How much would you like to withdraw?")
    (setq ammount (read))
    (setq new (- savings ammount))
    
    (if (< new 0.0)
        (progn (write-line "Sorry, you do not have the funds to withdraw that amount.")
               (atm))
            ;ELSE   
            (progn (write-line "Withdraw Complete!")
                   (setq savings (- savings ammount))
                   (setq wallet (+ wallet ammount))
                   (atm))
    )
)

(defun viewHist (ind) 
    (setq myIndex ind)
    (if (= ind 0)
        (progn (write-line "No recent purchases to show.")
               (atm))
        (progn (write-line " ") (write-line "---Purchase History---") (setq end (- items 1)) 
            (loop for x from 0 to end
                    do (progn (princ (aref history x)) (write-line " ")))
                    (atm))
    )
)

;---Main---

(menu)




