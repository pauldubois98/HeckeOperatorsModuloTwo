using Primes
using JLD2, FileIO
using SparseArrays: SparseVector, spzeros, dropzeros!, sparse
include("../../ModularFormsModuloTwo.jl/src/ModularFormsModuloTwo.jl")
using .ModularFormsModuloTwo
MF2 = ModularFormsModuloTwo
include("number_types.jl");

# load Hecke powers
MAX_DELTA = 1000
MAX_POWER = 50
Hecke_powers = MF2.loadHeckePowersListBinary(MAX_POWER, MAX_DELTA)
# load Hecke primes
MAX_DELTA = 100
MAX_PRIME = 10000
Hecke_primes = MF2.loadHeckePrimesListBinary(MAX_PRIME, MAX_DELTA)



MAXI = 20
MAXI_3 = MAXI
MAXI_5 = MAXI

primes = Primes.primes(3, MAX_PRIME)
a_ij = Array{Union{Array{Int8,2},Nothing},1}(undef, MAX_PRIME)
# for p in primes
#     print(p, ' ')
#     a_ij[p] = zeros(Int8, MAXI_3, MAXI_5)
# end


for p in primes
    # init 
    a_p = sparse([1,], [1,], [2,], MAXI, MAXI)
    a_p = -ones(MAXI, MAXI)
    a_p[1,1]=0
    #known
    if p%8 == 3
        a_p[2,1]=1
    else
        a_p[2,1]=0
    end
    if p%8 == 5
        a_p[1,2]=1
    else
        a_p[1,2]=0
    end
    
    if p%8 == 7
        a_p[2,2]=1
    else
        a_p[2,2]=0
    end
    if isOfForm1(p)
        a_p[3,1]=1
    else
        a_p[3,1]=0
    end
    if isOfForm2(p)
        a_p[1,3]=1
    else
        a_p[1,3]=0
    end
    #-1: not set
    # 1: one set
    # 0: zero set

    for k in 3:2:MAX_DELTA-2
        n = (k+4)/2
        df = Hecke_primes[p][k+1]
        
        form_s = Array{SparseVector{Int8,Int64}}(undef, 0)
        i_s = Array{Int64}(undef, 0)
        j_s = Array{Int64}(undef, 0)
        c=0
        for i in 1:MAXI
            for j in 1:MAXI
                if i+j<=MAXI
                    if a_p[i,j]==1
                        # add the modular form
                        df += Hecke_powers[i,j][k+1]
                    elseif a_p[i,j]==0
                        # add zero
                        # => do nothing
                    elseif a_p[i,j]==-1
                        # if not zero, add the modular form to the basis
                        if i+j<=n
                            df_base = Hecke_powers[i,j][k+1]
                            if !iszero(df_base)
                                push!(form_s, df_base)
                                push!(i_s, i)
                                push!(j_s, j)
                                c+=1
                            end
                        end
                    end
                end
            end
        end
        #create matrices that represent the problem
        M = Matrix{Int8}(undef, length(df), c)
        for i in 1:c
            for j in 1:length(df)
                M[j,i] = form_s[i][j]
            end
        end
        #match coef
        lambdas = M\df
        #save results
        for i in 1:c
            a_p[i_s[i],j_s[i]] = Int(lambdas[i])
        end
    end
    #save in main variable
    a_ij[p] = a_p
end


println(size(a_ij))
    
# final saving (standard naming)
@save joinpath(@__DIR__, "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)*".jdl2") a_ij
