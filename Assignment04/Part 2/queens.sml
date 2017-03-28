val callcc = SMLofNJ.Cont.callcc
val throw  = SMLofNJ.Cont.throw
type 'a cont  = 'a SMLofNJ.Cont.cont

type choice   = int cont * (int -> int) * int
val cpStack : choice list ref = ref nil
fun pushCP p = cpStack := p::(!cpStack)
fun popCP () = let val (a::bs)= !cpStack
                   val _      = cpStack := bs
               in a
               end

fun label (lb,ub) =
    let val s = callcc (fn k =>let fun branch c = if (c < ub)
                                                  then (pushCP (k,branch,c+1);c)
                                                  else ub
                               in (pushCP(k,branch,lb+1);lb)
                               end)
    in {value=s,dom=(lb,ub)}
    end

fun backtrack() = if null (!cpStack)
                  then ()
                  else let val (k,C,n) = popCP ()
                       in throw k (C n)
                       end

fun labelList [] = nil
    | labelList (a::bs) = (label a)::(labelList bs)

fun printList nil = "\n"
    | printList ({value=a,dom=(lb,ub)}::bs) = Int.toString(a) ^ "," ^ (printList bs)

fun runCheck (counter, {value=a,dom=(lb,ub)}::bs, toTest) = 
        if (toTest + counter) = a orelse (toTest - counter) = a orelse toTest = a then false
        else if bs = nil then true
        else runCheck(counter + 1, bs, toTest)

fun checkQueen nil = true
    | checkQueen({value=a,dom=(lb,ub)}::bs) = 
        let
            val start = a
        in
            if bs = nil then true
            else if (runCheck(1, bs, a)) then checkQueen(bs)
            else false
        end

fun main() = 
    let 
        (* val boardSize = N, or size of the chessboard! Change value for different sizes. *)
        val boardSize = 6
        fun generateList(n, counter) = if counter = 0 then [] else (0, (n - 1)) :: generateList(n, counter-1);
        val boardDomain = generateList(boardSize, boardSize)
    in 
        let 
            val x = labelList boardDomain
        in
            if checkQueen(x) then (print (printList x); backtrack())
            else backtrack()
        end
    end
    
val _ = main()

  
