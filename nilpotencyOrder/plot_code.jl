using PrettyTables
using Plots
using Plots.PlotMeasures
using LaTeXStrings
pyplot()
include("codeOfNumbers.jl")


function print_nb(n, nb_digits=5)
    s = string(n)
    len_s = length(s)
    return "0"^(nb_digits-len_s)*s
end

for MAX in [5, 10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 10000]
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
    
    #save formats
    savefig(plt, joinpath(@__DIR__, "graph/svg/behaviour_up_to_"*string(MAX)*".svg") )
    savefig(plt, joinpath(@__DIR__, "graph/png/behaviour_up_to_"*string(MAX)*".png") )
    savefig(plt, joinpath(@__DIR__, "graph/eps/behaviour_up_to_"*string(MAX)*".eps") )

end

