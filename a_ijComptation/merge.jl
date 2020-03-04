using JLD2, FileIO
using Primes


# load data
MAX_PRIME = 1000
MAXI = 20
# standard naming
file_name = "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)
# load
a_ij_A = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")


# load data
MAX_PRIME = 10000
MAXI = 20
# standard naming
file_name = "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)
# load
a_ij_B = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")


a_ij = Array{Union{Nothing, Array{Int8,2}},1}(undef, MAX_PRIME)


for p in primes(3, MAX_PRIME)
    a_p = -ones(MAXI, MAXI)
    for i in 1:MAXI
        for j in 1:MAXI
            if p < length(a_ij_A)
                if a_ij_A[p][i,j] != -1
                    a_p[i,j] = a_ij_A[p][i,j]
                end
            end
            if a_ij_B[p][i,j] != -1
                a_p[i,j] = a_ij_B[p][i,j]
            end
        end
    end

    a_ij[p] = a_p
end


    
# final saving (standard naming)
@save joinpath(@__DIR__, "a_ij(p)-merged.jdl2") a_ij
