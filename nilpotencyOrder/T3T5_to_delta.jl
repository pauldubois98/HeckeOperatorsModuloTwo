using PrettyTables
include("codeOfNumbers.jl")

MAX_ROWS = 5*10^2
MAX_COLS = 5*10^2
code_table = Array{Any, 2}(undef, MAX_ROWS+1, MAX_COLS+2)
code_header = Array{Any, 1}(undef, MAX_COLS+2)

for a in 1:MAX_ROWS+1
    #code_table[a,1] = a-1
    code_table[a,1] = "T_3^"*string(a-1)
    #code_table[a,1] = "\$T_3^{"*string(a-1)*"}\$"
    for b in 2:MAX_COLS+2
        code_table[a,b] = "∆^"*string(number_odd([a-1,b-2]))
        #code_table[a,b] = "\$\\Delta^{"*string(number_odd([a-1,b-2]))*"}\$"
    end
end
code_header[1] = ""
for b in 2:MAX_COLS+2
    #code_header[b] = b-2
    code_header[b] = "T_5^"*string(b-2)
    #code_header[b] = "\$T_5^{"*string(b-2)*"}\$"
end

#### FILES ODD
### TXT file
# f = open("T3T5_to_delta.txt", "w")
# pretty_table(f, code_table, code_header)
# close(f)

### CSV file
# f = open("T3T5_to_delta.csv", "w")
# for h in code_header
#     write(f, h)
#     write(f, ",")
# end
# write(f, '\n')
# for i in 1:size(code_table, 1)
#     for j in 1:size(code_table, 2)
#         write(f, code_table[i,j])
#         write(f, ",")
#     end
#     write(f, '\n')
# end
# write(f, '\n')
# close(f)

### PRINTS
## text
pretty_table(code_table, code_header)
## latex
#pretty_table(code_table, code_header, backend=:latex)
