using Plots
using Plots.PlotMeasures
using LaTeXStrings
include("codeOfNumbers.jl")

pyplot()


function print_nb(n, nb_digits=2)
    s = string(n)
    len_s = length(s)
    return "0"^(nb_digits-len_s)*s
end


for MAX_ROWS in 2:15
    MAX_COLS = MAX_ROWS
    x = Vector{Int}()
    y = Vector{Int}()
    z = Vector{Int}()
    code_table = Array{Any, 2}(undef, MAX_ROWS+1, MAX_COLS+2)
    code_header = Array{Any, 1}(undef, MAX_COLS+2)

    for a in 1:MAX_ROWS+1
        for b in 1:MAX_COLS+1
            push!(x, a)
            push!(y, b)
            push!(z, number_odd([a-1,b-1]))
        end
    end

    plt = plot(x, y, z, zcolor=reverse(z), linetype=:surface, grid=false, title="\$z=\\left[x,y\\right]\$", camera=(-45, 30), xaxis="X", yaxis="Y", zaxis="Z")
    savefig(plt, joinpath(@__DIR__, "graph/code_plot_"*print_nb(MAX_ROWS)*"-"*print_nb(MAX_COLS)*".png") )
end


