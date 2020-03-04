using JLD2, FileIO
using Primes
using PrettyTables
using LaTeXStrings

# load data
MAX_PRIME = 10000
MAXI = 20
# load
file_name = "a_ij(p)-merged"
a_ij = load(joinpath(@__DIR__, file_name*".jdl2"), "a_ij")

# open writing files
f_txt = open(joinpath(@__DIR__, "a_ij_p.txt"), "w")
f_csv = open(joinpath(@__DIR__, "a_ij_p.csv"), "w")

for p in primes(3,MAX_PRIME)
    global a_ij, f_csv, f_txt
    # println(p)

    # write table
    table = Array{Any, 2}(undef, MAXI, MAXI+1)
    header = Array{Any, 1}(undef, MAXI+1)
    header[1] = "T_"*string(p)
    for i in 1:MAXI
        table[i,1] = "T_3^"*string(i-1)
    end
    for j in 1:MAXI
        header[j+1] = "T_5^"*string(j-2)
    end
    for i in 1:MAXI
        for j in 1:MAXI
            if a_ij[p][i,j]!=-1
                table[i,j+1] = string(a_ij[p][i,j])
            else
                table[i,j+1] = ""
            end
        end
    end

    ### TEXT
    # pretty_table(table, header)

    ### FILE TEXT
    pretty_table(f_txt, table, header)

    ### FILE CSV
    for h in header
        write(f_csv, h)
        write(f_csv, ",")
    end
    write(f_csv, '\n')
    for i in 1:size(table, 1)
        for j in 1:size(table, 2)
            write(f_csv, table[i,j])
            write(f_csv, ",")
        end
        write(f_csv, '\n')
    end
    write(f_csv, '\n')

end

close(f_txt)
close(f_csv)
