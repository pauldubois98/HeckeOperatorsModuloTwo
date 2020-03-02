using PrettyTables
include("codeOfNumbers.jl")


START = 100
MAX_ROWS = 26
code_table = Array{Any, 2}(undef, MAX_ROWS, 3)
code_header = ["k", "code of k", "h(k)"]
for j in 1:MAX_ROWS
    code_table[j,1] = string(2*(j-1)+START)*" , "*string(2*j-1+START)
    c = code(2*j-1+START)
    code_table[j,2] = "[ "*string(c[1])*" , "*string(c[2])*" ]"
    code_table[j,3] = string(h(2*j-1+START))
end

#latex
pretty_table(code_table, code_header, backend=:latex)
#text
pretty_table(code_table, code_header)

