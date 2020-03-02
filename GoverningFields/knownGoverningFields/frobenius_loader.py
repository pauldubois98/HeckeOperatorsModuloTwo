import requests

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


def galois_group_id(file, text='Galois identify'):
    f = open(file, 'r')
    l = f.readline()
    while text+'\n'!=l:
        l = f.readline()
    l = f.readline()
    f.close()
    return eval(l)

def group_name(ident):
    url = "https://pari.math.u-bordeaux.fr/galpol/"+str(ident[0])+"/"+str(ident[1])+"/index.html"
    r = requests.get(url)
    txt = r.text
    txt = txt[txt.find('Name:'):]
    txt = txt[:txt.find('\n')]
    return txt[6:]


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

def group_size(conjugacy_classes):
    n=0
    for conj_class in conjugacy_classes:
        n+= len(conj_class)
    return n


def conjugacy_classe_size(element, conjugacy_classes):
    i_element = 0
    for i in range(len(conjugacy_classes)):
        if element in conjugacy_classes[i]:
            i_element = i
            break
    return len(conjugacy_classes[i_element])

def conjugacy_classes_size(elements, conjugacy_classes):
    n=0
    for e in elements:
        n += conjugacy_classe_size(e, conjugacy_classes)
    return n


