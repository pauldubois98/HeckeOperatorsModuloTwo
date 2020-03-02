
function isOfForm1(p::Int)::Bool
    a = 0
    b = 1
    while (a*a)+(8*b*b) < p
        while a*a+8*b*b < p
            b+=2
        end
        if a*a+8*b*b == p
            break
        end
        b = 1
        a += 1
    end
    if a*a+8*b*b == p
        return true
    else
        return false
    end
end

function isOfForm2(p::Int)::Bool
    a = 0
    b = 1
    while (a*a)+(16*b*b) < p
        while a*a+16*b*b < p
            b+=2
        end
        if a*a+16*b*b == p
            break
        end
        b = 1
        a += 1
    end
    if a*a+16*b*b == p
        return true
    else
        return false
    end
end



function pmatrix(M)
    for i in 1:MAXI
        for j in 1:MAXI
            if M[i, j]!=-1
                print(M[i, j])
            end
            print('\t')
        end
        println()
    end
end