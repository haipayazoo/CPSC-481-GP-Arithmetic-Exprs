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

        ; Sets kid1 to a random number
        (setq kid1 (random_number))

        (if (< random_num  4)

          ; Sets kid1 to a random variable
          (setq kid1 (random_var))

          ; Otherwise, sets kid1 to a list, further extending the equation
          (setq kid1 (create_critter))
        )

    )

    ; Depending on the random number the kid will
    ; have a number, an operator, or another expression
    (setq random_num (random 5))
    (if (< random_num 2)

        ; Sets kid2 to a random number
        (setq kid2 (random_number))

        (if (< random_num  4)

            ; Sets kid2 to a random variable
            (setq kid2 (random_var))

            ; Otherwise, sets kid2 to a list, further extending the equation
            (setq kid2 (create_critter))
        )
    )

    ; Creates part of the expression
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

    ; Empties the new pool so it is ready to have kids in it
    (setq new_pool '())

    ; Shuffles the current pool
    (shuffle_pool)

    (setq index 0)

    ; Loops for every critter in the pool
    (loop while (< index (length pool)) do

        ;(print index)

        ; Gets the first two parents from the shuffled pool
        (setq parent1 (nth index pool))
        (setq parent2 (nth (+ index 1) pool))

        ; Acquires a random, legal node from each parent
        (setq node1 (find_random_node parent1))
        (setq node2 (find_random_node parent2))

        ; Creates kids based on each parent and the nodes acquired
        (setq kid1 (create_kid parent1 node1 node2))
        (setq kid2 (create_kid parent2 node2 node1))

        ; Adds both kids into the new pool
        (setq new_pool (append new_pool (list kid1)))
        (setq new_pool (append new_pool (list kid2)))

        ; Increments the loop by 2 so we can get the next two parents
        (setq index (+ index 2))

    )

    ; The old pool becomes the new pool of the next generation of kids
    (setq pool new_pool)

)

; Picks a valid node of an expression at random to be used to create a kid
(defun find_random_node (parent)

    ; Picks either argument one or argument two of the parent randomly
    (setq node (nth (+ 1 (random 2)) parent))

    ; If the node is not a list, then we can't go further
    (if (not (listp node))

        ; Return selected node
        node

        (progn

            ; If the node length is one, then we can't go any further
            (if (= (length node) 1)

                ; Return the selected node
                node

                (progn

                    ; 50% chance the selected node will be returned or we will
                    ; keep going further down the expression tree
                    (if (= (random 2) 0)
                        node

                        ; Recursive call to go further down the expression tree
                        (find_random_node node))
                )
            )
        )
    )
)


; Creates a kid from one of the two parents using random nodes chosen
; from each parent. Each node is a crossover point from each parent.
(defun create_kid (parent node1 node2)

    ; Condition statement
    (cond

        ; If the parent is not a list, then the parent is returned
        ( (not (listp parent)) parent)

        ; If the parent and node1 are the same, then swap node1 with node2
        ( (eq parent node1) node2)

        ; These conditions verify the section of the parent where node1 comes
        ; from in the parent and swaps it out with node2 from the other parent.
        ; This is the actual crossover that will create a new kid inheriting
        ; traits of the both parents
        ( (eq (nth 0 parent) node1) (list node2 (nth 1 parent)  (nth 2 parent)))
        ( (eq (nth 1 parent) node1) (list (nth 0 parent) node2 (nth 2 parent)))
        ( (eq (nth 2 parent) node1) (list (nth 0 parent) (nth 1 parent) node2))

        ; Otherwise create the kid with the operator from the parent and the
        ; two arguments
        (t (progn

              ; Sets the operator of the kid
              (setq op (nth 0 parent))

              ; Sets argument one based on what the recursive function returns
              (setq arg1 (create_kid (nth 1 parent) node1 node2))

              ; Sets argument two based on what the recusive function returns
              (setq arg2 (create_kid (nth 2 parent) node1 node2))

              ; Forms the equation
              (list op arg1 arg2)
           )
        )
    )
)


; Randomizes the pool so that the crossovers aren't biased towards a sepcific
; area of the pool; more diversity
(defun shuffle_pool ()

    ; Loop shuffles the pool
    (loop for i from (length pool) downto 2 do

        (rotatef (elt pool (random i)) (elt pool (1- i)))

    )

)

; Each critter is exposed to radiation and has a 5% chance of undergoing
; a random mutation
(defun radiate ()

    ; For practical purposes, "mutations" counts how many mutations have
    ; occured in each generation. This initializes "mutations" to 0 every
    ; generation
    (setq mutations 0)

    (setq index 0)

    (loop while (< index (length pool)) do

        ; If the random number is less than 5 (0-4); which is 5%
        ; then a mutation occurs
        (if (< (random 100) 5)

            ; Evaluate the following
            (progn

                ; Replaces the kid in the pool with mutated kid
                (setf (nth index pool) (mutate (nth index pool)))

                ; Since a mutation has occured, increment "mutations"
                (setq mutations (+ mutations 1))

                ;(format t "A mutation has occurred in index ~D.~%" index)

            )

        )

        ; Increment loop counter
        (setq index (+ index 1))

    )

)


; The process of mutating a critter from the pool
(defun mutate (critter)

    ; Finds a leaf from the critter
    (setq leaf (find_leaf critter))

    ; Gets a list of operators
    (setq ops '(+ - *))

    ; If the leaf is an operator then the operator is replaced
    (if (member leaf ops)

        ; Replaces the leaf with an operator
        (setq new_leaf (random_op))

        ; Otherwise, replace the leaf with either a variable or a number
        (progn

            ; 50% chance of getting either a variable or a number as a
            ; replacement
            (if (eq (random 2) 0)

                ; Replace with a variable
                (setq new_leaf random_var)

                ; Replace with a number
                (setq new_leaf random_num)

            )

        )

    )

        ; Creates the same kid but with the mutation replaced
        (create_kid critter leaf new_leaf)

)

; Finds a leaf from the critter that will be used to mutate
(defun find_leaf (critter)

    (setq leaf (nth (random 3) critter))

    ; If the current node is not a list then it's a leaf
    (if (not (listp leaf))

        ; Return leaf
        leaf

        ; If the length of the node is one, then it's a leaf
        (if (= (length leaf) 1)

            ; Return leaf
            leaf


            ; Otherwise, continue traversing the tree until a leaf is found
            (find_leaf leaf)



        )

    )

)

; Used to debug functions to see if they work
; Displays the current pool
(defun print_population ()
    (setq index 0)
    (loop while (< index (length fitness_list)) do
        (format t "Index: ~D  - ~S~%" index (nth index pool))
        (setq index (+ index 1))
    )
)

(defun main ()
    (populate)
    (critter_fitness)

    (print_population)
    ;(format t "Fitness List: ~S~%" fitness_list)

    (best_expression)
    (best_fitness)
    (worst_fitness)
    (average_fitness)

    ;(shuffle_pool)
    ;(print_population)

    ;(crossover)
    (radiate)

    (print_population)

)

(main)
