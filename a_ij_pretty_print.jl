using JLD2, FileIO
using Primes


# load data
MAX_PRIME = 10000
MAXI = 20
# standard naming
file_name = "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)
# load
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")
println(file_name)
println(size(a_ij))

#joinpath(@__DIR__, filename)
file = open(file_name*".txt", "w")

# print data to file
for i in 1:MAXI
    for j in 1:MAXI
        println("a_",i,",",j)
        # sort primes
        primes_0 = Vector{Int}()
        primes_1 = Vector{Int}()
        primes_undef = Vector{Int}()
        for p in Primes.primes(3, MAX_PRIME)
            if a_ij[p][i,j]==1
                push!(primes_1, p)
            elseif a_ij[p][i,j]==0
                push!(primes_0, p)
            else
                push!(primes_undef, p)
            end
        end
        # write ot file
        write(file, "\n\ta_"*string(i-1)*","*string(j-1)*":\n")
        write(file, "1: ")
        write(file, string(primes_1), "\n")
        write(file, "0: ")
        write(file, string(primes_0), "\n")
        write(file, "undefined: ")
        write(file, string(primes_undef), "\n")
    end
end

# don't forget to close!
close(file)
