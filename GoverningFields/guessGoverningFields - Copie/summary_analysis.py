from frobenius_loader import *
from a_ij_loader import *


setups = [
    #(0,2,"a_02_ext_0111.txt"),
    (0,3,"a_02_ext_0111.txt"),
    (0,4,"a_02_ext_0111.txt"),
    #(2,0,"a_20_ext_1100.txt"),
    (3,0,"a_20_ext_1100.txt"),
    (4,0,"a_20_ext_1100.txt"),
    ]


for i,j,filename in setups:
    ## LOAD DATA
    # a_ij
    primes1, primes0, primes_undefined = a_ij(i,j)
    # frobenian elements
    conjugacy_classes = galois_conjugacy_classes(filename)
    ident = galois_group_id(filename)
    name = group_name(ident)

    # Galois group identification
    print('\n\n\n\t\t', "i =",i, ", j =",j, "; extension:", filename)
    print("\t Galois group identification:")
    print("In GAP4:", ident)
    print("Name:", name)

    #init frob lists
    frobenius0 = list()
    frobenius1 = list()

    #fill 1-primes frob elements
    for p in primes1:
        #load element
        F_p = frobenius_of_prime(p, filename)
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
        F_p = frobenius_of_prime(p, filename)
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

    # Chebotarev
    print("\t Chebotarev Density Theorem Data:")
    print("Frobenius of 1-primes classes sizes:")
    print("#C =", conjugacy_classes_size(frobenius1, conjugacy_classes), \
          '\t', "(arranged in", len(frobenius1), "conjugacy classes)")
    print("Goup size:")
    print("#G =", group_size(conjugacy_classes))

    # probas
    print("\t Probablities Data:")
    print("Number of 1-primes:", len(primes1))
    print("Number of 0-primes:", len(primes0))
    print("Number of odd primes:", len(primes0)+len(primes1))
