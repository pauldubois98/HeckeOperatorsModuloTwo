def plot(i,j):
    print('\t<h5>a<sub>'+str(i)+str(j)+'</sub>(p)</h5>\n\
\t<img src="graph/a_'+str(i)+','+str(j)+'_exact.svg" alt="exact plot of a_'+str(i)+str(j)+'(p)"><br>\n\
\t<img src="graph/a_'+str(i)+','+str(j)+'_relative.svg" alt="relative plot of a_'+str(i)+str(j)+'(p)"><br>')


for j in range(1,8):
	plot(0,j)

plot(1,1)

for i in range(1,8):
	plot(i,0)



