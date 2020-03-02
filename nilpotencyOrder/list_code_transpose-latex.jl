using PrettyTables
include("codeOfNumbers.jl")


MAX_ROWS = 8
code_table = Array{Any, 2}(undef, 2, MAX_ROWS+1)
code_header = Array{Any, 1}(undef, MAX_ROWS+1)
code_header[1] = "k"
code_table[1,1] = "code of k"
code_table[2,1] = "h(k)"
for j in 2:MAX_ROWS+1
    code_header[j] = string(2*(j-2))*" , "*string(2*j-3)
    c = code(2*j-1)
    code_table[1,j] = "[ "*string(c[1])*" , "*string(c[2])*" ]"
    code_table[2,j] = string(h(2*j-3))
end

#latex
pretty_table(code_table, code_header, backend=:latex)
#text
pretty_table(code_table, code_header)




