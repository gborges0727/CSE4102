use "set.sml";
use "lambda.sml";
use "church.sml";
         
structure Main = struct     
structure L : LExpr = Lambda;
structure C : ChurchSig = Church;

(* This is the test function for the 3rd expression -- plus -- *)
fun test3 () = 
    let open L in 
	let val t = abs("x",apply(var "f",apply(var "x",var "x")))
	    val Y = abs("f",apply(t,t))
        
        (* succ gets next value for church numeral n *)
	    val succ = abs("n", abs("s", abs("z", apply(var "s", apply(apply(var("n"), var("s")), var("z"))))))
        (*
        (* Checks if given n is 0 :) *)
	    val isZero = apply(abs("n", var("n")), apply((abs("x", abs("a"), abs("b"), var("b"))), (abs("a", abs("b"), var("a")))))
	    val plus = ...
	    val mult = ...
	    val pair = ...
	    val first  = ...
	    val second = ...
	    val pred = ...
	    val toTest = apply(apply(plus,(C.int2Church 2)),(C.int2Church 3))*)
	in print (toString (simp toTest) ˆ ”\n”)
	end
    end
	  (*
fun fib arg = 
    let open L in 
	let val t = abs("x",apply(var "f",apply(var "x",var "x")))
	    val Y = abs("f",apply(t,t))
	    val succ = abs("n",abs("s",abs("z",
						   apply(var "s",
							 apply(apply(var "n",
								     var "s"),
							       var "z")))))

		       (*
			Please, fill in your implementation by inlining all the required 
			definitions to implement the Fibonacci function
			*)
	    val fib = ....
            val carg = C.int2Church arg
	    val fibe = apply(apply(Y,fib),carg)
	in print ("RES:" ^ ((toString (simp fibe)) ^ "\n"))
	end
    end*)
end
