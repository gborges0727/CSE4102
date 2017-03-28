(* Gabriel Borges
   CSE4102 - Prog Languages
   Assignment 03
   2/14/17 *)

(* Intro Section in Homework Assignment
   Functions are used in below answers *)
datatype 'a Stream = Nil
	| Cons of 'a * (unit -> 'a Stream);
exception Bad of string;

fun from seed next = Cons(seed, fn() => from (next seed) next);

fun head (Nil) = raise Bad("got nil in head")
	| head (Cons(a, b)) = a;

fun tail (Nil) = raise Bad("got nil in tail")
	| tail (Cons(a, b)) = b();

fun take 0 stream = nil
	| take n (Nil) = raise Bad("got nil in take")
	| take n (Cons(h, t)) = h::(take (n - 1) (t()));

(* Question 1 -------------------------------------------------- *)
(* Sub-question 1 *)
val nat = from 1.0 (fn x => x + 1.0);
(* Sub-question 2 *)
val one = from 1.0 (fn x => x);
(* Sub question 3 *)
val zero = from 0.0 (fn x => x);
(* Sub question 4 *)
val alt = from 1.0 (fn x => ~1.0 * x);

(* Question 2 -------------------------------------------------- *)
fun mul a b = Cons(((head a) : real) * ((head b) : real),
	fn() => mul (tail a) (tail b));

(* Question 3 -------------------------------------------------- *)
(* Stream 'reals' is used to isolate value for 0!, which could 
   not be done with great ease using nat. Therefore, I simply 
   made the stream reals to start with 0 to make the below 
   somewhat easier :D *)
val reals = from 0.0 (fn x => x + 1.0)

(* In the below function, curr retains the current factorial 
   value, whereas stream will reuse retain the reals stream 
   defined above *)
fun factProduce curr stream =
	let
		val value = (curr : real) * ((head stream) : real)
		val streamTail = tail stream
	in
		if Real.floor (head stream) = 0 
			then Cons(1.0, fn() => factProduce 1.0 streamTail)
		else Cons(value, fn() => factProduce value streamTail)
end;

val fs = factProduce 0.0 reals;

(* Note: Below is used in question 8! ~ putting here as it relates
   to problem 3 - Objectively the same as factProduce, except this 
   only takes every other factorial: i.e. 2!, 4!, 6! ... *)
fun doubleFact curr stream =
	let
		val value = (curr : real) * (((head stream) : real) * 2.0) 
			* (((head stream) : real) * 2.0 - 1.0)
		val streamTail = tail stream
	in
		if Real.floor (head stream) = 0 
			then Cons(1.0, fn() => doubleFact 1.0 streamTail)
		else Cons(value, fn() => doubleFact value streamTail)
end;

val fs2 = doubleFact 0.0 reals;

(* Question 4 -------------------------------------------------- *)
(* Main idea: begin with the head of the first stream: the next will 
   be the head of the second (which is why we pass "b" first in the
   tail), then pass the tail of a in as the new "b." *)
fun weave a b = Cons((head a), fn() => weave b (tail a));

(* Question 5 -------------------------------------------------- *)
(* Idea: multiply the previous value, or the seed, by the input value
   x. The result is a stream that is x * x infinitely. *)
fun px x = from 1.0 (fn y => y * x);

(* Question 6 -------------------------------------------------- *)
fun frac s = Cons((1.0 / head s), fn() => frac (tail s));

(* Question 7 -------------------------------------------------- *)
(* sumList = helper function for eval / taken from HW1 *)
fun sumList nil = 0.0
	| sumList (a::b) = (a : real) + sumList b;	

(* Creates the denominator for eval: 1 / n! *)	
val coefs = (frac fs);

(* Function to calculate the taylor approx *)
fun eval s x order = 
let
	val taylorList = take order (mul (px x) s);
in 
	sumList taylorList
end;

(* Function we call to make things easy *)
fun ex x = eval coefs x 100;

(* Question 8 -------------------------------------------------- *)
(* Creates the denominator for eval2 *)
val coefs2 = frac (mul alt fs2);

(* Function to calculate the cosine approx - Objectively similar 
   to eval, except the numerator needs to be calculated differently, 
   like the denominator was above in doubleFact - every other numerator
   is taken (i.e. 1, x^2, x^4 etc). Hence the new function eval2. *)
fun eval2 s x order = 
let 
	val cosList = take order (mul (mul (px x) (px x)) s);
in
	sumList cosList
end;

(* Function we call to make things easy *)
fun cos x = eval2 coefs2 x 100;

