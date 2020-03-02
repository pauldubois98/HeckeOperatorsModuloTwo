using PrettyTables
include("codeOfNumbers.jl")


START = 0
MAX_ROWS = 10^4
code_table = Array{Any, 2}(undef, MAX_ROWS, 3)
code_header = ["k", "code of k", "h(k)"]
for j in 1:MAX_ROWS
    code_table[j,1] = string(2*(j-1)+START)*" , "*string(2*j-1+START)
    c = code(2*j-1+START)
    code_table[j,2] = "[ "*string(c[1])*" , "*string(c[2])*" ]"
    code_table[j,3] = string(h(2*j-1+START))
end


#### FILES
### TXT file
# f = open("int_to_code_table.txt", "w")
# pretty_table(f, code_table, code_header)
# close(f)

### CSV file
# f = open("int_to_code_table.csv", "w")
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
# pretty_table(code_table, code_header)
## latex
# pretty_table(code_table, code_header, backend=:latex)
