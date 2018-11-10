; TO-DO list
; Create the following functions:
; *Function that mutates a kid
; *Function that does a crossover between parents to produce kids
; *A function that purges adds the kids only into the pool and not the parents
;
; There might be more things but those are the big functions that need to be done

; Creates a critter (random expression) to add to the population - uses
; recursion in order to create a deep expresssion based on a random number
; Creates a critter (random expression)
(defun create_critter ()

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

    (list parent kid1 kid2)

)


; Creates a population of 50 critters (random expressions)
(defun populate ()

  ; Sets the pool list empty
  (setq pool '())

  ; Loops 50 times for each critter; change the value if you want more or less
  ; critters in the pool
  (loop while (< (length pool) 50) do

    ; Creates a critter
    (setq expression (create_critter))

    ; Adds the critter to the pool
    (setq pool (append pool (list expression)))

  )

)

; Gets the fitness (which is the error) of each critter and forms
; a list of fitness values of the pool
(defun critter_fitness ()
  ; Empties the fitness list every time it's called (each generation)
  (setq fitness_list '())

  ; The test samples from the project used to test for fitness value
  (setq test_samples (list
         '(0 -2 1 -16)
         '(-4 -5 -3 58)
         '(9 8 -6 72)
         '(9 -7 5 113)
         '(-8 7 3 150)
         '(5 4 -5 20)
         '(6 -4 6 41)
         '(-5 3 -7 -24)
         '(-6 -5 9 -18)
         '(1 0 2 2))
  )

  ; Loops for ever critter in the pool
  (dolist (critter pool)

      (setq fitness 0)

      ; Loops for every test sample
      (dolist (sample test_samples)
          (setq x (nth 0 sample))
          (setq y (nth 1 sample))
          (setq z (nth 2 sample))
          (setq answer (nth 3 sample))

          ; Evaluates the critter and checks how different it is from the
          ; actual answer
          (setq error (abs (- answer (eval critter))))

          ; Adds the error to the total fitness value
          (setq fitness (+ fitness error))

      )

        ; Sets the list
        (setq fitness_list (append fitness_list (list fitness)))
    )
)

; Finds the best expression of the generation based on fitness
(defun best_expression ()

    ; The current index to be incremented in the loop
    (setq index 0)

    ; The current minimum found in the fitness list
    (setq minimum (nth 0 fitness_list))

    ; The index of the expresssion of the current minimum
    (setq min_index 0)

    ; Loops for every critter in the pool (every fitness value)
    (loop while (< index (length fitness_list)) do

        ; If a new minimum has been found
        (if (> minimum (nth index fitness_list))
            (progn

                  ; Changes minimum to the new minimum
                  (setq minimum (nth index fitness_list))

                  ; New index of the new minimum
                  (setq min_index index)
            )

        )

        ; Increments loop
        (setq index (+ index 1))
    )

    ; Prints best expression
    (format t "Best Expression: ~S~%" (nth min_index pool))
)


; Finds the best fitness value of that generation
(defun best_fitness ()

    ; The current index to be incremented in the loop
    (setq index 0)

    ; The current minimum found in the fitness list
    (setq minimum (nth 0 fitness_list))

    ; Loops for every critter in the pool (every fitness value)
    (loop while (< index (length fitness_list)) do

        ; If a new minimum has been found
        (if (> minimum (nth index fitness_list))

            ; Changes minimum to the new minimum
            (setq minimum (nth index fitness_list))
        )

        ; Increments loop
        (setq index (+ index 1))
    )

    ; Prints the best fitness (lowest error)
    (format t "Best Fitness: ~S~%" minimum)
)


; Finds the worst fitness value of that generation
(defun worst_fitness ()

    ; The current index to be incremented in the loop
    (setq index 0)

    ; The current maximum found in the fitness list
    (setq maximum (nth 0 fitness_list))

    ; Loops for every critter in the pool (every fitness value)
    (loop while (< index (length fitness_list)) do

        ; If a new maximum has been found
        (if (< maximum (nth index fitness_list))

            ; Changes maximum to the new minimum
            (setq maximum (nth index fitness_list))
        )

        ; Increments loop
        (setq index (+ index 1))
    )

    ; Prints the worst (highest error)
    (format t "Worst Fitness: ~S~%" maximum)
)

; Finds the average fitness value of that generation
(defun average_fitness ()

    ; Index of the loop
    (setq index 0)

    ; The average fitness
    (setq average 0)

    ; Loops for every critter (fitness value)
    (loop while (< index (length fitness_list)) do

        ; Adds up every critter's fitness value
        (setq average (+ average (nth index fitness_list)))

        ; Increments the loop iterator
        (setq index (+ index 1))

    )

    ; Divides the sum by the amount of critters in the pool, obtaining our average
    (setq average (/ average (float (length fitness_list))))

    ; Outputs the average; converts to floating point number
    (format t "Average Fitness: ~S~%" average)
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

; Does a crossover of two random parents and creates two kids from the
; crossover.
(defun crossover ()

    ; Shuffles the pool
    (shuffle_pool)

    (setq index 0)

    

)

; Randomizes the pool so that the crossovers aren't biased towards a sepcific
; area of the pool; more diversity
(defun shuffle_pool ()

    ; Loop shuffles the pool
    (loop for i from (length pool) downto 2 do

        (rotatef (elt pool (random i)) (elt pool (1- i)))

    )

)


;(defun print_population ()
;    (setq index 0)
;    (loop while (< index (length fitness_list)) do
;        (format t "Index: ~D  - ~S~%" index (nth index pool))
;        (setq index (+ index 1))
;    )
;

(defun main ()
    (populate)
    (critter_fitness)
    ;(print_population)
    ;(format t "Fitness List: ~S~%" fitness_list)
    (best_expression)
    (best_fitness)
    (worst_fitness)
    (average_fitness)
    ;(shuffle_pool)
    ;(print_population)

)

(main)
