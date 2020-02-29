

def frobenius_of_prime(p, file):
    f = open(file, 'r')
    l = f.readline()
    while str(p)+'\n'!=l:
        l = f.readline()
    l = f.readline()
    f.close()
    return eval(l[9:-2])

def galois_conjugacy_classes(file, text='Galois conjug classes'):
    f = open(file, 'r')
    l = f.readline()
    while text+'\n'!=l:
        l = f.readline()
    l = f.readline()
    f.close()
    return eval(l[:-1].replace('Vecsmall(', '').replace(')', ''))


def same_conjugacy_classes(element1, element2, conjugacy_classes):
    i_element1 = 0
    for i in range(len(conjugacy_classes)):
        if element1 in conjugacy_classes[i]:
            i_element1 = i
            break
    i_element2 = 0
    for i in range(len(conjugacy_classes)):
        if element2 in conjugacy_classes[i]:
            i_element2 = i
            break
    return i_element1==i_element2

