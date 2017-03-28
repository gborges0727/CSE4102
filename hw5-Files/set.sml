signature Set =
sig
    type ''a Set
    val single : ''a -> ''a Set
    val empty  : unit -> ''a Set
    val insert : ''a -> ''a Set -> ''a Set
    val union  : ''a Set -> ''a Set -> ''a Set
    val inter  : ''a Set -> ''a Set -> ''a Set
    val member : ''a -> ''a Set -> bool
    val remove : ''a -> ''a Set -> ''a Set
    val show   : ''a Set -> (''a -> string) -> string
end;

structure LSet : Set = struct
   type ''a Set = ''a list
   fun empty () = nil : ''a list
   fun single x  = [x] : ''a Set
   fun member x nil  = false
     | member x (y::t) = x=y orelse member x t
  
(* only do the insertion if the element is not already a member of the set*)
   fun insert x l = if member x l
		    then l
		    else x::l

(* If the element is found, return the tail. This is valid since the list
   never contains duplicates *)
		   
   fun remove x nil = nil
     | remove x (y::t) = if x=y then t else y::(remove x t)

(* Induction on the first list. If the element is a member of the second,
   simply skip it. Otherwise, add it to the result. The first case of
   union is just an optimization *)

   fun union a nil = a
     | union nil b = b
     | union (a::ra) b = if member a b then union ra b else a::(union ra b)

(* Induction on the first list. If a is a member of l as well, add it to the
   result list, otherwise skip it *)

   fun inter a nil = nil
     | inter nil a = nil
     | inter (a::ra) l = if member a l
			 then a::(inter ra l)
			 else inter ra l

(* Show uses an auxiliary function defined in a local let form. 
   The auxiliary has 2 base cases (again, induction on the list).
   case 1: List is empty, produce a closing curly brace
   case 2: List has 1 element exactly: convert the element and add the curly brace
   induction: (at least 2 elements): convert the head, add a comma and apply 
              toString recursively to produce the tail.
   The function show reduces to concatenating the open curly brace with the
   result of toString and prints it out *)
									
   fun show l f = 
       let fun toString nil = "}"
	     | toString [a] = (f a) 
	     | toString (a::b) = (f a) ^ "," ^ (toString b);
       in "{" ^ (toString l) ^ "}"
       end
end
