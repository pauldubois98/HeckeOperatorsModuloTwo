using JLD2, FileIO
using Primes
using PrettyTables
using LaTeXStrings

# load data
MAX_PRIME = 10000
MAXI = 20
# load
file_name = "a_ij(p)-merged"
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")

for p in [19]#primes(3,MAX_PRIME)
    global a_ij

    # write table
    table = Array{Any, 2}(undef, MAXI, MAXI+1-4)
    header = Array{Any, 1}(undef, MAXI+1-4)
    header[1] = "\$ T_"*string(p)*"\$"
    for i in 1:MAXI
        table[i,1] = "\$ T_3^{"*string(i-1)*"} \$"
    end
    for j in 1:MAXI-4
        header[j+1] = "\$ T_5^{"*string(j-1)*"} \$"
    end
    for i in 1:MAXI
        for j in 1:MAXI-4
            if a_ij[p][i,j]!=-1
                table[i,j+1] = string(a_ij[p][i,j])
            else
                table[i,j+1] = ""
            end
        end
    end

    ### TEXT
    pretty_table(table, header, backend=:latex)

end
