using JLD2
using Primes, FileIO
using Plots
using LaTeXStrings

# load data
MAX_PRIME = 10000
MAXI = 20
file_name = "a_ij(p)-"*"max_prime"*string(MAX_PRIME)*"-"*"length"*string(MAXI)
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")



for i in 0:3
    #init vars
    j=3-i
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
    plt1 = plot(x, number_ones, legend=false, title="\$S_n = \\{a_{"*string(i)*","*string(j)*"}(p)=1 \\ | \\ p \\leq p_n\\}\$", xlabel = "\$n\$", ylabel = "\$|S_n|\$")
    plt2 = plot(x, ratio_ones, legend=false, title="\$S_n = \\{a_{"*string(i)*","*string(j)*"}(p)=1 \\ | \\ p \\leq p_n\\}\$", xlabel = "\$n\$", ylabel = "\$\\frac{|S_n|}{n}\$")
    #save
    savefig(plt1, joinpath(@__DIR__, "a_"*string(i)*","*string(j)*"_exact.svg") )
    savefig(plt2, joinpath(@__DIR__, "a_"*string(i)*","*string(j)*"_relative.svg") )
    savefig(plt1, joinpath(@__DIR__, "a_"*string(i)*","*string(j)*"_exact.png") )
    savefig(plt2, joinpath(@__DIR__, "a_"*string(i)*","*string(j)*"_relative.png") )


end
