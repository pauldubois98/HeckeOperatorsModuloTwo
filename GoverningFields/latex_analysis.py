from frobenius_loader import *
from a_ij_loader import *
import os
import re

def latex_group_name(group_name):
    if group_name=='D16':
        return 'D_{16}'
    if group_name=='QD16':
        return 'QD_{16}'
    elif group_name=='Q16':
        return 'Q_{16}'
    elif group_name=='D32':
        return 'D_{32}'
    elif group_name=='QD32':
        return 'QD_{32}'
    elif group_name=='Q32':
        return 'Q_{32}'
    else:
        return group_name\
               .replace('D', 'D_')\
               .replace('C', 'C_')\
               .replace('x', '\\times')

def analysis(file, i,j, last=[], align=False, equal=' = '):
    #print('\t\t'+'='*10+' a_'+str(i)+','+str(j)+' '+str(file)+' '+'='*10)
    # DATA
    primes1, primes0, primes_undefined = a_ij(i,j)
    conjugacy_classes = galois_conjugacy_classes(file)
    galois_ident = galois_group_id(file)
    galois_name = group_name(galois_ident)
    extension_name = full_extension(file, tex=2)
    extension_name_bis = readable_extension(file, tex=2)


    #init frob lists
    frobenius0 = list()
    frobenius1 = list()

    #fill 1-primes frob elements
    for p in primes1:
        #load element
        F_p = frobenius_of_prime(p, file)
        # we add it to the list of 0-primes frob
        found=False
        for F in frobenius1:
            if same_conjugacy_classes(F_p, F, conjugacy_classes):
                found=True
                break
        if found:
            pass
        else:
            frobenius1.append(F_p)


    #fill 0-primes frob elements
    for p in primes0:
        #load element
        F_p = frobenius_of_prime(p, file)
        # check it is not conjugate to a frob of a 1-prime
        found=False
        for F in frobenius1:
            if same_conjugacy_classes(F_p, F, conjugacy_classes):
                found=True
                break
        if found:
            # if it is, there is a problem for this prime
            print(p, ": wrong conjugacy class")
            print(F_p)
        else:
            # if not, we add it to the list of 0-primes frob
            found=False
            for F in frobenius0:
                if same_conjugacy_classes(F_p, F, conjugacy_classes):
                    found=True
                    break
            if found:
                pass
            else:
                frobenius0.append(F_p)

    # Extension identification
    if len(last)==0:
        print("Governing field:")
        if not align:
            if extension_name_bis[:len(extension_name)]!=extension_name:
                #print(extension_name)
                #print(" - or - ")
                print("$$M_{"+str(i)+str(j)+"}"+equal+extension_name_bis[2:])
            else:
                print("$$M_{"+str(i)+str(j)+"}"+equal+extension_name[2:])
        else:
            a,b = extension_name_bis.split('\nand')
            print(a)
            print('and')
            b = '\\begin{align*}\n\t'+b[4:-2]+'\n\\end{align*}'
            b = b.replace('-', '\n\t-').replace('+', '\n\t+')
            c=0
            l=[]
            for i in range(len(b)):
                if b[i]=='+' or b[i]=='-':
                    c+=1
                    if c%3==1:
                        l.append(i)
            
            for i in l[1:][::-1]:
                b = b[:i-1]+'\\\\\n\t&'+b[i:]
            i=l[0]
            b = b[:i-1]+'&'+b[i:]
            
            print(b)
    else:
        print("Same governing field as $\
a_{"+str(last[0])+str(last[1])+"}$, \
thus also same Galois group ($\
M_{"+str(i)+str(j)+"}"+equal+"\
M_{"+str(last[0])+str(last[1])+"}$ and $\
G_{"+str(i)+str(j)+"}"+equal+"\
G_{"+str(last[0])+str(last[1])+"}$).")

    #multicols
    print("\\begin{multicols}{2}")
    
    #itemize - group
    print("\t\\begin{itemize}")
    print("\t\t\\item $G_{"+str(i)+str(j)+"} = "\
          +latex_group_name(galois_name)+"$")
    print("\t\t\\item $\\abs{S_{"+str(i)+str(j)+"}^1} = "\
          +str(conjugacy_classes_size(frobenius1, conjugacy_classes))+"$")
    print("\t\t\\item $\\abs{C_{"+str(i)+str(j)+"}^1} = "\
          +str(len(frobenius1))+"$")
    print("\t\\end{itemize}")
    
    #itemize - primes
    print("\t\\begin{itemize}")
    p_0 = str(len(primes0))
    p_1 = str(len(primes1))
    p_tot = str(len(primes0)+len(primes1))
    grp_size = group_size(conjugacy_classes)
    frac0 = (grp_size*len(primes0))\
           /(len(primes1)+len(primes0))
    frac1 = (grp_size*len(primes1))\
           /(len(primes1)+len(primes0))
    #primes 0
    print("\t\t\\item $\\abs{\\{ p \\in \\primes \
\\mid a_{"+str(i)+str(j)+"}(p)=0, p<10^4 \\}} = "+p_0+"$\\\\")
    print("Ratio: $\\nicefrac{ "+p_0+" }{ "+p_tot+" } \\approx \
\\nicefrac{ "+str(int(frac0+0.5))+" }{ "+str(grp_size)+" }$")
    #primes 1
    print("\t\t\\item $\\abs{\\{ p \\in \\primes \
\\mid a_{"+str(i)+str(j)+"}(p)=1, p<10^4 \\}} = "+p_1+"$\\\\")
    print("Ratio: $\\nicefrac{ "+p_1+" }{ "+p_tot+" } \\approx \
\\nicefrac{ "+str(int(frac1+0.5))+" }{ "+str(grp_size)+" }$")
    print("\t\\end{itemize}")
    
    #multicols
    print("\\end{multicols}")



if __name__=='__main__':
    root = os.getcwd()
    f = open('to_analyse_latex.txt', 'r')
    l = f.readline()
    while l!='':  
        if l[-2]=='?':
            equal = ' \stackrel{?}{=} '
            l = l[:-1]
        else:
            equal = ' = '
        if l[0]=="#":
            pass
        elif l[0]=="%":
            os.chdir(root+'\\\\'+l[1:-1])
        elif l[0]=="\\":
            print(l[1:-1])
        elif l[0]=="-":
            if l[1]!='-':
                name = l[1:-1]
                print("\n\n\n\subsection{$a_{"+name+"}$}\n\
Here we look at the maps $a_{"+name+"}$.")
            else:
                name = l[2:-1]
                print("\n\\subsubsection{$a_{"+name+"}$}")
        elif l[0]=="*":
            i, j, file = l[1:-1].split(',')
            i = int(i)
            j = int(j)
            analysis(file, i,j, (last_i, last_j), equal=equal)
        elif l[0]=="+":
            i, j, file = l[1:-1].split(',')
            i = int(i)
            j = int(j)
            analysis(file, i,j, align=True, equal=equal)
            last_i = int(i)
            last_j = int(j)
        else:
            i, j, file = l[:-1].split(',')
            i = int(i)
            j = int(j)
            analysis(file, i,j, equal=equal)
            last_i = int(i)
            last_j = int(j)
        l = f.readline()
    
    f.close()
