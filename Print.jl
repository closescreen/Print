module Print




"""[\"a\\n\",\"b\\n\",\"c\\n\"] |> Iter.print(STDOUT)"""
print(wio::IO; printfunc::Function=Base.print, closeio::Bool=false) =
    iter->print(wio::IO, iter, printfunc=printfunc, closeio=closeio)

"""[\"a\",\"b\",\"c\"] |> Iter.println(STDOUT)"""
println(wio::IO; closeio::Bool=false) = 
    print(wio, printfunc=Base.println, closeio=closeio)


"""[\"a\\n\",\"b\\n\",\"c\\n\"] |> Iter.print # print to STDOUT"""
print(iter)   = print(STDOUT,iter)


"""[\"a\",\"b\",\"c\"] |> Iter.println # println to STDOUT"""
println(iter) = print(STDOUT,iter,printfunc=Base.println)


"""
Iter.print(STDOUT, [\"a\\n\",\"b\\n\"])

Iter.print(STDOUT, 
    ([2,3,4],[4,5,6]), 
        printfunc=(wio,l)->println(wio, join(l,\"*\")))

"""
function print(wio::IO, iter; 
        printfunc::Function=Base.print, closeio::Bool=false) 
    for l in iter 
    printfunc(wio, l) 
    end
    if closeio
    close(wio)
    end 
end    
    

"""Iter.println(STDOUT, [\"a\",\"b\"])"""    
println(wio::IO, iter) = print(wio,iter,printfunc=Base.println)


"""
[\"a\\n\",\"b\\n\"] |> Iter.print(`bash -c 'gzip > \"aa.gz\"'`)

([2,3,4],[4,5,6]) |> 
    Iter.print(viatmp(\"cc.txt\"), 
    printfunc=(wio,l)->println(wio, join(l,\"*\")))
"""
print(wcmd::Cmd; printfunc::Function=Base.print) = 
    iter->print(wcmd, iter, printfunc=printfunc)


"""
    [\"a\",\"b\",\"c\"] |> Iter.println(`bash -c 'gzip > \"aa.gz\"'`)
"""    
println(wcmd::Cmd) = 
    print(wcmd, printfunc=Base.println)
    

"""
    Iter.print(`bash -c \"gzip > aa.gz\"`, [\"a\\n\",\"b\\n\"])
"""
function print(wcmd::Cmd, iter; 
        printfunc::Function=Base.print)
 (wio,wpr) = open(wcmd, "w")
 print(wio, iter, printfunc=printfunc)
 close(wio)
 wait(wpr)
 nothing
end


"""
    Iter.println(`bash -c \"gzip > aa.gz\"`, [\"a\",\"b\",\"c\"])
"""
println(wcmd::Cmd, iter) = 
    print(wcmd, iter, printfunc=Base.println)





end # module