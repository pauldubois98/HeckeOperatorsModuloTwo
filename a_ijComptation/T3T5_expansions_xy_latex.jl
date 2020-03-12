using JLD2, FileIO
using Primes

# load data
MAX_PRIME = 100
MAXI = 20
# load
file_name = "a_ij(p)-merged"
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")

println("\$x = T_3\$")
println("\$y = T_5\$")
println("\$x^iy^j = T_3^iT_5^j\$")
println("")

for p in primes(3,MAX_PRIME)
    global a_ij

    exp = "T_{"*string(p)*"} = "
    for s in 0:MAXI-1
        for i in 0:s
            j = s - i
            if a_ij[p][i+1,j+1]==1
                exp *= "x^{"*string(i)*"}y^{"*string(j)*"} + "
            else
                #pass
            end
        end
    end

    ### TEXT
    println("\$"*exp[1:end-3]*" + \\dots \$\\\\")

    ### FILE TEXT

end
