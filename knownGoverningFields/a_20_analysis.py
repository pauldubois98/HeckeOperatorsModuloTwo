from frobenius_loader import *
from a_ij_loader import *


## LOAD DATA
# a_ij
primes1, primes0, primes_undefined = a_ij(2,0)
# frobenian elements
file = "a_20_data.txt"
conjugacy_classes = galois_conjugacy_classes(file)


# print primes types
print("\t 0 - primes:")
print(primes0[:100])
print("\t 1 - primes:")
print(primes1[:100])
print()


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

# frobenian elements of 0-primes
print()
print("\t Frobenius of 0-primes:")
print(frobenius0)

# frobenian elements of 0-primes
print()
print("\t Frobenius of 1-primes:")
print(frobenius1)

