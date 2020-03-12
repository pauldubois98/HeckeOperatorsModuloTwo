using JLD2
using Primes, FileIO
using Plots
using LaTeXStrings

# load data
MAX_PRIME = 10000
MAXI = 20
file_name = "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")


function theory(i,j)
    if i==1 && j==1
        return 2/8
    elseif i==0 && j==1
        return 1/4
    elseif i==0 && j==2
        return 1/8
    elseif i==0 && j==3
        return 2/16
    elseif i==0 && j==4
        return 1/16
    elseif i==0 && j==5
        return 4/32
    elseif i==0 && j==6
        return 2/32
    elseif i==0 && j==7
        return 2/32
    elseif i==1 && j==0
        return 1/4
    elseif i==2 && j==0
        return 1/8
    elseif i==3 && j==0
        return 2/16
    elseif i==4 && j==0
        return 1/16
    elseif i==5 && j==0
        return 4/32
    elseif i==6 && j==0
        return 2/32
    elseif i==7 && j==0
        return 2/32
    else
        return 0
    end
end



function graph(i,j)
    primes_list = Primes.primes(3,MAX_PRIME)
    number_ones = Array{Int, 1}(undef, length(primes_list))
    ratio_ones = Array{Float64, 1}(undef, length(primes_list))

    #loop
    nb = 0
    for n in 1:length(primes_list)
        nb += a_ij[primes_list[n]][i+1,j+1]
        number_ones[n] = nb
        ratio_ones[n] = nb/n
    end

    #plot
    x = 1:length(primes_list)
    println(number_ones)
    plt1 = plot(x, [number_ones [theory(i,j)*a for a in 1:length(primes_list)]], legend=false, title="\$S_n^1 = \\{a_{"*string(i)*","*string(j)*"}(p)=1 \\ | \\ p \\leq p_n\\}\$", xlabel = "\$n\$", ylabel = "\$|S_n^1|\$", lw=2, color=[:auto :red])
    plt2 = plot(x, [ratio_ones [theory(i,j) for a in primes_list]], legend=false, title="\$S_n^1 = \\{a_{"*string(i)*","*string(j)*"}(p)=1 \\ | \\ p \\leq p_n\\}\$", xlabel = "\$n\$", ylabel = "\$\\frac{|S_n^1|}{n}\$", lw=2, color=[:auto :red])
    #save
    savefig(plt1, joinpath(@__DIR__, "graph", "a_"*string(i)*","*string(j)*"_exact.svg") )
    savefig(plt2, joinpath(@__DIR__, "graph", "a_"*string(i)*","*string(j)*"_relative.svg") )
    savefig(plt1, joinpath(@__DIR__, "graph", "a_"*string(i)*","*string(j)*"_exact.png") )
    savefig(plt2, joinpath(@__DIR__, "graph", "a_"*string(i)*","*string(j)*"_relative.png") )
    # plot!(plt1)
    # plot!(plt2)
end

for i in 1:7
    graph(i,0)
end
graph(1,1)
for j in 1:8
    graph(0,j)
end
