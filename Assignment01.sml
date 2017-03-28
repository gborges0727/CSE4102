(* Gabriel Bergamini Borges
   CSE 4102
   1/31/17                *)

(* NOTE about the Real.fromInt function: I attempted to implement the function that was provided 
in the homework as far as converting from ints to reals for the purpose of calculation, and 
could not find a way to make it work (all sorts of errors were being thrown around), so I thought 
perhaps he may have meant to use this method to convert it. I also could not find any documentation 
on SML to do this conversion any other way. *)

(* Question 1 *)
(* #1 *)
fun sum n = if n = 0 then 0 
	else n + sum(n - 1);

(* #2 *)
fun sumsq n = if n = 0 then 0 
	else n * sumsq(n - 1);

(* #3 *)
fun sumOdd n = if n = 0 then 0
	else n * 2 - 1 + sumOdd(n - 1);

(* #4 *)
fun fib n = if n = 0 then 0
	else if n = 1 then 1
	else fib(n - 1) + fib(n - 2);

(* #5 *)
(* In order for fibFast to run in Linear time, we must move upward, whilst retaining
the values for prev and current. The function runFib does that for us, while holding
onto a counter, i, that increments with each recursion, until n is reached. *)
fun fibFast n = 
	let 
		fun runFib (prev, curr, i) = 
			let 
				val newCurr = curr + prev
			in 
				if i = n then curr
				else runFib(curr, newCurr, (i + 1))
			end;
	in 
		runFib(0, 1, 1)
end;


(* Question 2 *)
(* General note: In order to calculate the values for the numerator 
and denominator, you need to do the computation seperately to avoid 
a time complexity above linear *)
fun sinappx (x, n) = 
	let 
		fun calc i top bot = 
			let 
				(* In order to calculate each new numerator, -1 is multiplied by the current one in 
				order to reverse the sign each time. Then the current value is multiplied by x twice 
				in order to get x^y to be x^(y+2). I.e. x^3 * x * x = x ^5. *)
				val newtop = ~1.0 * top * x * x

				(* The denominator is done by multiplying the current value x!, by the next sequential 
				even number (x + 1)! and the next sequential odd (x + 2)!. This ensures that after the 
				first iteration, you will continously have an odd factorial. I.e. 3! * 4 * 5 = 5!. Then 
				5! * 6 * 7 = 7! and so on and so forth. *)
				val newbot = (2.0 * Real.fromInt i + 1.0) * (2.0 * Real.fromInt i) * bot
			in 
				if i = n then newtop / newbot							(* Checks whether we need to recurse again or not *)
				else newtop / newbot + calc (i + 1) newtop newbot       (* Recurses in the case that the previous check failed *)
			end;
	in 
		if n = 0 then x 												(* Checks whether n = 0: if yes simply return x :D *)
		else x + calc 1 x 1.0											(* Begins the function call, with x being added (as that's the first term) *)
end; 

(* Question 3 
Using the trapizoidal rule *)
fun integrate (f, a, b, n) = 
	let 
		val h = (b - a) / Real.fromInt n 								(* The trapizoidal rule requires the value h (see equation) *)
		(* runTrap is a function that will recurse through and ask 
			for the function x, what the value of each subsequent
			x is and add them together. By the trapizoid rule, all 
			but the first and last term are also multiplied by 2 *)
		fun runTrap (f, h, x, i) = 										
			let 
				val newX = x + h
				val funRet = f(x : real)
			in 
				if i = 1 then funRet + runTrap (f, h, newX, (i + 1))    (* Checks whether current iteration is the first one *)
				else if i = n then funRet							    (* Checks whether current iteration is the last one *)
				else 2.0 * funRet + runTrap (f, h, newX, (i + 1))       (* Runs "middle" of the trapizoidal computation *)
			end;
	in
		(b - a) / (2.0 * Real.fromInt n) * runTrap (f, h, a, 1)         (* Computes the final step (delta x / 2) and multiplies that by the trapizoid result *)
end;

(* Question 4 *)
(* Auxilary function sum & listLength taken from slides *)
fun sumList nil = 0
	| sumList (a::b) = a + sumList b;									(* Used in LHS calculation below *)
fun sumListSq nil = 0
	| sumListSq (a::b) = (a * a) + sumListSq b;							(* Used in RHS calculation below *)
fun listLength nil = 0
	| listLength (a::b) = 1 + length b;

fun variance a = 
	let 
		val avgsq = Real.fromInt (sumListSq a)  						(* This line calculates the numerator of the left hand side *)
		val sqavg = Real.fromInt (sumList a)    						(* This line calculates the numerator of the right hand side *)
		val listSize = Real.fromInt (listLength a) 						(* Naming the size of the list to use later *)
	in 
		(avgsq / listSize) - ((sqavg / listSize)*(sqavg / listSize)) 	(* Running the full computation *)
end;









