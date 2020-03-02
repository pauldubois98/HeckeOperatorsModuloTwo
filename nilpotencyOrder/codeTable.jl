using PrettyTables
include("codeOfNumbers.jl")

MAX_ROWS = 11
MAX_COLS = 16
code_table = Array{Any, 2}(undef, MAX_ROWS, MAX_COLS+1)
code_header = Array{Any, 1}(undef, MAX_COLS+1)

for a in 1:MAX_ROWS
    code_table[a,1] = a-1
    #code_table[a,1] = "T_3^{"*string(a-1)*"}"
    #code_table[a,1] = "\$T_3^{"*string(a-1)*"}\$"
    for b in 2:MAX_COLS+1
        code_table[a,b] = number_even([a-1,b-2])
        #code_table[a,b] = number_odd([a-1,b-2])
        #code_table[a,b] = "\$\\Delta^{"*string(number_odd([a-1,b-2]))*"}\$"
    end
end
code_header[1] = ""
for b in 2:MAX_COLS+1
    code_header[b] = b-2
    #code_header[b] = "T_5^{"*string(b-2)*"}"
    #code_header[b] = "\$T_5^{"*string(b-2)*"}\$"
end

#text
pretty_table(code_table, code_header)
#latex
pretty_table(code_table, code_header, backend=:latex)





