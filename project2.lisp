

; Creates a critter (random expression) to add to the population - uses
; recursion in order to create a deep expresssion based on a random number
(defun create_critter ()
  (let parent kid1 kid2 random_num)

    ; The parent will always have an operator to be a legal expression
    (setq parent (random_op))

    ; Depending on the random number the kid will
    ; have a number, an operator, or another expression
    (setq random_num (random 5)
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

    (list parent kid1 kid2)))

)

; Gets a random number from -9 to 9
(defun random_number ()
  (let (num_list)
    (setq num_list (list -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9))
    (nth (random (length num_list)) num_list))
)

; Gets a random variable x, y, or z
(defun random_var ()
 (let (var_list)
  (setq var_list (list 'x 'y 'z))
  (nth (random (length var_list)) var_list))
)

; Gets an either the '+', '-', or '*' operator
(defun random_op ()
  (let (op_list)
    (setq op_list (list '+ '- '*))
    (nth (random (length op_list)) op_list))
)
