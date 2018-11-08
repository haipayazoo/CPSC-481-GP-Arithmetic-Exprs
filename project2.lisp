; TO-DO list
; Create the following functions:
; *Function that mutates an expresssion
; *Function that does a crossover between parents to produce kids
; *A function that purges functions
; *A function that prints the best and worst fitness of each generation
; *A function that calculates the fitness of each expression given the sample data
; *A function that creates a population of critters
; *A function that prints the best expression of each data
;
; There might be more things but those are the big functions that need to be done

; Creates a critter (random expression) to add to the population - uses
; recursion in order to create a deep expresssion based on a random number
(defun create_critter ()
  (let (parent kid1 kid2 random_num)

    ; The parent will always have an operator to be a legal expression
    (setq parent (random_op))

    ; Depending on the random number the kid will
    ; have a number, an operator, or another expression
    (setq random_num (random 5))
    (if (< random_num 2)
      (setq kid1 (random_number))

      (if (< random_num  4)

        (setq kid1 (random_var))

        (setq kid1 (create_critter))
      )
    )

    ; Depending on the random number the kid will
    ; have a number, an operator, or another expression
    (setq random_num (random 5))
    (if (< random_num 2)
      (setq kid2 (random_number))

      (if (< random_num  4)

        (setq kid2 (random_var))

        (setq kid2 (create_critter))
      )
    )

    (list parent kid1 kid2))

)

; Gets a random number from -9 to 9
(defun random_number ()
  (let ((num_list (list -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9)))
    (nth (random (length num_list)) num_list))
)

; Gets a random variable x, y, or z
(defun random_var ()
 (let ((var_list (list 'x 'y 'z)))
  (nth (random (length var_list)) var_list))
)

; Gets an either the '+', '-', or '*' operator
(defun random_op ()
  (let ((op_list (list '+ '- '*)))
    (nth (random (length op_list)) op_list))
)

(defun test-expression(xval yval zval)
  (setq x xval)
  (setq y yval)
  (setq z zval)
  (eval (write (create_critter)))
)
