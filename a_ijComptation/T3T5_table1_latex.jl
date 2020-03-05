using JLD2, FileIO
using Primes
using PrettyTables
using LaTeXStrings

# table & header init
table = Array{Any, 2}(undef, 183, 2)
header = ["\$a_{ij}\$", "\$ \\lbrace p \\in \\primes \\ | \\ a_{ij}(p) = 1 \\rbrace \$", ] # latex

# parameters
MAX_PRIME = 10000
MAXI = 20
# load
file_name = "a_ij(p)-merged"
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")

line = 1
for s in 0:MAXI-1
    global line
    for i in 0:s
        j = s-i
        # sort primes
        primes_0 = Vector{Int}()
        primes_1 = Vector{Int}()
        primes_undef = Vector{Int}()
        for p in Primes.primes(3, MAX_PRIME)
            if a_ij[p][i+1,j+1]==1
                push!(primes_1, p)
            elseif a_ij[p][i+1,j+1]==0
                push!(primes_0, p)
            else
                push!(primes_undef, p)
            end
        end
        if length(primes_1)==0
            #pass
        else
            table[line,1] = "\$ a_{"*string(i)*" "*string(j)*"} \$"
            table[line,2] = string(primes_1)[2:end-1]
            line += 1
        end
    end
end

####################################################################################################################

### TEXT
pretty_table(table, header, alignment=[:r,:l], backend=:latex)
