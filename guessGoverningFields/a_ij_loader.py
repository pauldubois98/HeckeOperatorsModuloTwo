
def a_ij(i,j, file="a_ij(p)-max_prime10000-length20.txt"):
    f = open(file, 'r')
    l = f.readline()
    text = "\ta_"+str(i)+','+str(j)+":\n"
    while text!=l:
        l = f.readline()
    # 1 - primes
    try:
        primes1 = eval(f.readline()[3:-1])
    except:
        primes1=[]
    # 0 - primes
    try:
        primes0 = eval(f.readline()[3:-1])
    except:
        primes0=[]
    # undefined primes
    try:
        primes_undefined = eval(f.readline()[3:-1])
    except:
        primes_undefined=[]
    #close file
    f.close()
    return primes1, primes0, primes_undefined
