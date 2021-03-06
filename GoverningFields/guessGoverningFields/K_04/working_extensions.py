from frobenius_loader import *
from a_ij_loader import *
import os

## LOAD DATA
# frobenian elements
files = [f for f in os.listdir() if f[:2]=='a_' and f[-4:]=='.txt'][:-1]

out_file = open('to_analyse.txt', 'w')
out_file.write("#i,j,filename\n")

#iterate through files
for file in files:
    print("\n\n\t"+file)
    conjugacy_classes = galois_conjugacy_classes(file)
    galois_ident = galois_group_id(file)
    galois_name = group_name(galois_ident)
    extension_name = full_extension(file, form=2)

    # Galois group identification
    print("\t Galois group identification:")
    print("In GAP4:", galois_ident)
    print("Name:", galois_name)
    print()

    
    #iterate through i+j=3
    for I,J in [(0,1), (1,0), \
                (2,0), (1,1), (0,2), \
                (3,0), (2,1), (1,2), (0,3), \
                (4,0), (3,1), (2,2), (1,3), (0,4), \
                (5,0), (4,1), (3,2), (2,3), (1,4), (0,5), ]:
        i = int(os.getcwd()[-2:-1]) + I
        j = int(os.getcwd()[-1:]) + J
        print("a_",i,',',j,':', sep='', end=' ')
        # a_ij
        primes1, primes0, primes_undefined = a_ij(i,j)

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

        wrong = False

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
                print(p, "wrong conjugacy class")
                wrong = True
                #print(F_p)
                break
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
        if not wrong:
            print() # no wrong conjugacy class
            out_file.write(str(i)+','+str(j)+','+file+'\n')

out_file.close()

