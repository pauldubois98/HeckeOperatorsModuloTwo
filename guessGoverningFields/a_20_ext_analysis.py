from frobenius_loader import *
from a_ij_loader import *


## LOAD DATA
# frobenian elements
files = [
    "a_20_ext_0100.txt",
    "a_20_ext_1000.txt",
    "a_20_ext_1100.txt",
    ]
#iterate through files
for file in files:
    print('\n\n\n')
    print("\t\t"+file)
    conjugacy_classes = galois_conjugacy_classes(file)
    
    #iterate through i+j=3
    for i,j in [(3,0), (2,1), (1,2), (0,3), (4,0), (3,1), (2,2), (1,3), (0,4), (5,0), (0,5), ]:
        print("\n\ta_",i,',',j,':', sep='')
        # a_ij
        primes1, primes0, primes_undefined = a_ij(i,j)

        # print primes types
##        print("0 - primes:")
##        print(primes0[:10])
##        print("1 - primes:")
##        print(primes1[:10])
##        print()


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


