use "set.sml";

signature LExpr = sig
    exception Bad of string	
    datatype expr = var   of string 
	          | apply of expr   * expr 
	          | abs   of string * expr
    type 'a Set
    val toString : expr -> string
    
    val freeV    : expr -> string Set
    
    val newName  : string Set -> string
    val subst    : string -> expr -> expr -> expr
    val alpha    : expr -> string Set -> expr
    val normal   : expr -> bool
    val beta     : expr -> expr
    val simp     : expr -> expr 
end;

structure Lambda : LExpr = struct 
    type 'a Set  = 'a LSet.Set
    datatype expr =  var of string 
                  | apply of expr  * expr
                  | abs of  string * expr
    exception Bad of string

    fun toString (var x) = x
        | toString (apply(a,b)) = "(" ^ (toString a) ^ " " ^ (toString b) ^ ")"
        | toString (abs(v,e))   = "L"^ v ^ "." ^ (toString e)    

     
    (* You must implement freeV (see the type above) *)
	fun freeV (var x)         = LSet.single x
        | freeV (apply(a, b)) = LSet.union (freeV a) (freeV b)
        | freeV (abs(v, e))   = LSet.remove v (freeV e)
    
    
    (* You must implement newName  (see the type above) *)

    fun newName s =  
    let 
        val string = "x"
        val numAppend = 0
        fun runTest (string : string) num = 
            let val output = string ^ (Int.toString num)
            in 
                if LSet.member output s 
                then runTest string (num+1)
                else output 
            end
    in 
        runTest string numAppend
    end
       
(*
 Fill in the five missing functions
*)

    fun subst   x a (var y)       = if y = x then a else var y
        | subst x a (apply(b, c)) = apply((subst x a b), (subst x a c))
        | subst x a (abs(v, e))   = 
            let val freevars = freeV e
            in 
                if LSet.member x freevars then abs(v, (subst x a e)) 
                else abs(v, e)
            end
    
    fun alpha (var x) p      = (var x)
        | alpha (apply(a, b)) p = apply((alpha a p), (alpha b p))
        | alpha (abs(v, e)) p   = 
            let val nameRepl = newName p
                val newExpr = var(nameRepl)
                val exprToPass = subst v newExpr e
            in 
                if LSet.member v p then (abs(nameRepl, (alpha exprToPass (LSet.insert nameRepl p))))
                else abs(v, (alpha e p))
            end
    
    fun normal (var x) = true 
        | normal (apply(abs(v, e), b)) = false 
        | normal (apply(a, b)) = (normal b)
        | normal (abs(v, e)) = true
    
    (* Helper func for beta *)
    fun findChars (var x) = LSet.single x
        | findChars (apply (a, b)) = LSet.union (findChars a) (findChars b)
        | findChars (abs (v, e)) = LSet.union (LSet.empty()) (findChars e)
    
    fun beta (apply(abs(v, e), b)) = 
        let
            val freeSet = freeV b
            val a = (abs(v, e))
            val charSet = findChars e
            val common = LSet.inter freeSet charSet
            val renamed = alpha a common
        in
            subst v b e
        end
        | beta (var x) = var(x)
        | beta (apply(a, b)) = apply(a, b)
        | beta (abs (v, e)) = abs(v, e)
    
    fun simp e = 
        if (normal e) then e
        else simp (beta e)
    
end

(*val x = Lambda.abs("x", Lambda.abs("y", Lambda.apply(Lambda.apply(Lambda.var("x"), Lambda.var("y")), Lambda.var("x"))));*)
(*val y = LSet.single "y" y 
  val y = LSet.insert "x" y
 
Lambda.apply(Lambda.abs("x", Lambda.apply(Lambda.var("x"), Lambda.var("x"))), Lambda.apply(Lambda.abs("y", Lambda.var("y")), Lambda.var("z")))
*)





