(* Solution pulled from moodle - this was a skip *)

fun qSort nil    = nil
  | qSort (a::b) = let fun part e nil    = (nil,nil)
			 | part e (h::t) = let val (nh,nt) = part e t
					   in if (h<e)
					      then (h::nh,nt)
					      else (nh,h::nt)
					   end
		       val (l,r) = part a b
		   in (qSort l)@(a::(qSort r))
		   end


fun qsHigh nil    f = nil
  | qsHigh (a::b) f = let val (l,r) = (foldr (fn (e,(l,r)) => if (f e a)
							      then (e::l,r)
							      else (l,e::r))
					     (nil,nil) b)
		      in (qsHigh l f)@(a::(qsHigh r f))
		      end

fun less a b = if a < b then true else false
				       
(* Extend is an auxiliary function. It takes a list of elements (e0,e1,...,en)
   and a value x and creates a list of pairs ((x,e0),(x,e1),...(x,en))
 *)
fun extend x nil = nil
  | extend x (h::t) = (x,h)::(extend x t)
      
(* Induction on the first list. 
   base case: result is the empty list
   induction: extend b with x and concatenate the result with the cross
              product of the tail (xs) by b. 
*)
fun cross nil     b = nil
  | cross (x::xs) b = (extend x b)@(cross xs b)

(* Part 4. Compute the cross product with a higher-order *)

fun crossHigh a b = let fun extend x l = map (fn y => (x,y)) l
                    in foldl (op @) nil (map (fn x => extend x b) a)
                    end
	      
(* Part 5. Compute the cross product with a higher-order and no use of op@ *)
fun crossFold a b = foldr (fn (x,nl) => foldr (fn (y,nl2) => (x,y)::nl2) nl b)
			  nil
			  a