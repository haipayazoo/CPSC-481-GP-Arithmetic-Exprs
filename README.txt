Program Name:
Genetic Programming Arithmetic Expressions


Team Name: CCJ


Authors/Contact info: 
Cameron Mathos - cmathos@csu.fullerton.edu
John Shelton - john.shelton789@csu.fullerton.edu
Christopher Bos - cbos95@csu.fullerton.edu


Class Number: 481


Intro:
This project is the Genetic Programming Arithmetic Expressions project. The purpose of this project is to create a population of fifty critters, or random expressions, and then evaluate their fitness based on the test samples provided by the project instructions. The fitness is based on the error rate of how accurate each expression is from the actual answer of the test data.

From there, the program evaluates the best, worst, and overall average fitness of that generation

Afterwards, each critter mates with another and produces kids. This is done by selecting a random section of each parent and crossing them over to produce children.

The parents are purged from the pool and the kids are addded into the pool. The pool is then exposed to radiation, giving each critter a 5% chance of undergoing a mutation, which is replacing a random part of the critter with either an operator, a variable or a number.

This process is repeated for 50 generations, with each generation printing their best expression and fitness, worst fitness, and overall average fitness.


External Requirements: CLISP


Setup and Usage:
The program was written in a text editor, Atom, and the code was compiled in CLISP, a GNU Common Lisp multi-architectural compiler for Windows. A link to download CLISP is provided right here:

https://sourceforge.net/projects/clisp/files/latest/download

Once you install CLISP, you compile the code by going to your Command Prompt, finding the location of the file (if you extract the file to your Desktop you would use the "cd" command to navigate to your desktop "cd Desktop") and from there you would input the command "clisp project2.lisp". The code should then compile and run with the correct path. If you want to observe the source code, just open up the file in a text editor.


Extra Features:
The ability to print out the population and the fitness values. Also, for the sake of diversity and minimizing bias when mating, before each crossover, the pool is shuffled.


Bugs: None
