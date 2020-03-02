using PrettyTables
using Plots
using Plots.PlotMeasures
using LaTeXStrings
include("codeOfNumbers.jl")


function print_nb(n, nb_digits=5)
    s = string(n)
    len_s = length(s)
    return "0"^(nb_digits-len_s)*s
end

MAXI = 1000000
MAX = 10
i=0
while MAX < MAXI
    global MAX, i
    array = 1:MAX
    n_3_array = Array{Int, 1}(undef, MAX)
    n_5_array = Array{Int, 1}(undef, MAX)
    h_array = Array{Int, 1}(undef, MAX)
    g_array = Array{Int, 1}(undef, MAX)
    sqrt_array = Array{Float64, 1}(undef, MAX)
    for k in array
        n_3_array[k] = n_3(k)
        n_5_array[k] = n_5(k)
        h_array[k] = h(k)
        g_array[k] = g(k)
        sqrt_array[k] = sqrt(k)
    end

    #final plot
    plt = plot(array, [n_3_array, n_5_array, h_array, sqrt_array, ], label=["\$n_3(k)\$" "\$n_5(k)\$" "\$h(k)\$" "\$\\sqrt{k}\$"], xlabel="\$k\$", grid=false, )
    
    #save for GIF
    savefig(plt, joinpath(@__DIR__, "graph/framesExponential/behaviour_up_to_"*print_nb(MAX, 8)*".png") )
    println(MAX)
    MAX = floor(Int, MAX*1.15)
    i += 1 
end

print(i)
print(" frames")
