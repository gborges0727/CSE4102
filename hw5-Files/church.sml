signature ChurchSig = sig
    val int2Church : int -> Lambda.expr
    val church2Int : Lambda.expr -> int
end;


structure Church : ChurchSig = struct 
exception Bad of string

fun church2Int e = 
    let val Lambda.abs(s,w) = e  (* pattern match to extract in w the second abstraction *)
	val Lambda.abs(z,x) = w  (* pattern match to extract in x the body: s (s (s ... (s z))) *)
	fun c2int s z (Lambda.var(b)) = if z = b
					then 0
					else raise Bad "no match"
	  | c2int s z (Lambda.apply(Lambda.var(a),b)) = if a = s
							then 1 + (c2int s z b)  
							else raise Bad "no match" 

	  | c2int s z _  = raise Bad "no match"
    in c2int s z x
    end

fun int2Church n =
    let fun body 0 = Lambda.var("z")
	  | body n = Lambda.apply(Lambda.var("s"),body (n-1))
    in Lambda.abs("s",Lambda.abs("z",body n))
    end
	
end

