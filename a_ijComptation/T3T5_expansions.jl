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

# open writing files
f_txt = open(joinpath(@__DIR__, "T_p_expansions_T3T5.txt"), "w")

for p in primes(3,MAX_PRIME)
    global a_ij, f_txt

    exp = "T_"*string(p)*" = "
    for s in 0:MAXI-1
        for i in 0:s
            j = s - i
            if a_ij[p][i+1,j+1]==1
                exp *= "T_3^"*string(i)*"T_5^"*string(j)*" + "
            else
                #pass
            end
        end
    end

    ### TEXT
    # println(exp[1:end-3])

    ### FILE TEXT
    write(f_txt, exp[1:end-3])
    write(f_txt, '\n')

end

close(f_txt)
