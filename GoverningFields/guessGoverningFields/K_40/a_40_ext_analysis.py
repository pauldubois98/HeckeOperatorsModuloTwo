from frobenius_loader import *
from a_ij_loader import *


## LOAD DATA
# frobenian elements
files = [
    "a_40_ext_00000001.txt",
    "a_40_ext_11100000.txt",
    "a_40_ext_11100001.txt",
    ]
#iterate through files
for file in files:
    print("\n\n\t"+file)
    conjugacy_classes = galois_conjugacy_classes(file)
    ident = galois_group_id(file)
    name = group_name(ident)

    # Galois group identification
    print("Galois group identification:")
    print("In GAP4:", ident)
    print("Name:", name)
    print()
    
    for i,j in [(2,0), (3,0), (4,0), \
                (5,0), (4,1), (3,2), (2,3), (1,4), (0,5), \
                (6,0), (5,1), (4,2), (3,3), (2,4), (1,5), (0,6), \
                (7,0), (0,7), \
                (8,0), (0,8), \
                (9,0), (0,9), ]:
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


