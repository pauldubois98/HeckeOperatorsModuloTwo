import requests
from sympy import *

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


def load_vars(file, text='Extension'):
    f = open(file, 'r')
    l = f.readline()
    while text+'\n'!=l:
        l = f.readline()
    nb = int(f.readline()[1:-1])
    for n in range(nb):
        f.readline()
    #y alpha x beta
    x = y = alpha = beta = 0
    try:
        y = eval(f.readline()[:-1]\
                 .replace("Mod(", '')\
                 .split(", ")[0]\
                 .replace('^', '**') )
    except:
        pass
    try:
        alpha = eval(f.readline()[:-1]\
                     .replace("Mod(", '')\
                     .split(", ")[0]\
                     .replace('^', '**') )
    except:
        pass
    alpha = nsimplify(alpha, rational_conversion='exact')
    try:
        x = eval(f.readline()[:-1]\
                 .replace("Mod(", '')\
                 .split(", ")[0]\
                 .replace('^', '**') )
    except:
        pass
    try:
        beta = eval(f.readline()[:-1]\
                    .replace("Mod(", '')\
                    .split(", ")[0]\
                    .replace('^', '**') )
    except:
        pass
    beta = nsimplify(beta, rational_conversion='exact')
    f.close()
    return y, alpha, x, beta

def readable_extension(file, text='Extension', tex=True, form=1):
    parts = extension_parts(file, text, tex, form)
    if tex<2:
        return parts[0]+"\nwhere:\n"+"\nand \n".join(parts[1])
    else:
        return '$$'+parts[0]+"$$\nwhere:\n$$"+"$$\nand \n$$".join(parts[1])+'$$'

def extension_parts(file, text='Extension', tex=True, form=1):
    #load vars
    y, alpha, x, beta = load_vars(file, text)
    #skip lines
    f = open(file, 'r')
    l = f.readline()
    while text+'\n'!=l:
        l = f.readline()
    #read extension size
    nb = int(f.readline()[1:-1])
    #read elements
    adjoint_elements = []
    for n in range(nb):
        e = f.readline()[:-1]
        if e[0]=='\\':
            pass
        elif tex:
            e = e.replace('sqrt(', '\\sqrt{\\').replace(')', '}')
        adjoint_elements.append(e)
    f.close()
    #base field
    if tex:
        ext = '\\mathbb{Q}'
    else:
        ext = 'Q'
    #adjoin elements to extension
    if form==1:
        extension = ext+'('+', '.join(adjoint_elements)+')'
    else:
        extension = ext+'('+')('.join(adjoint_elements)+')'
    #tex brackets
    if tex:
        extension = extension.replace('(', '\\left(').replace(')', '\\right)')
    #addons
    addons = []
    try:
        addons.append('\\alpha = '+latex(alpha))
    except:
        pass
    if beta!=0:
        try:
            addons.append('\\beta = '+latex(beta).replace(latex(alpha), '\\alpha'))
        except:
            pass
    
    return extension, addons

    

def full_extension(file, text='Extension', tex=True, form=1):
    #load vars
    y, alpha, x, beta = load_vars(file, text)
    #skip lines
    f = open(file, 'r')
    l = f.readline()
    while text+'\n'!=l:
        l = f.readline()
    #read extension size
    nb = int(f.readline()[1:-1])
    #read elements
    adjoint_elements = []
    for n in range(nb):
        e = f.readline()[:-1]
        if e[0]=='\\':
            pass
        else:
            if tex:
                e = latex(eval(e))
            else:
                e = eval(e)
        adjoint_elements.append(e)
    f.close()
    #base field
    if tex:
        ext = '\\mathbb{Q}'
    else:
        ext = 'Q'
    #adjoin elements to extension
    if form==1:
        extension = ext+'('+', '.join(adjoint_elements)+')'
    else:
        extension = ext+'('+')('.join(adjoint_elements)+')'
    #tex brackets
    if tex:
        extension = extension.replace('(', '\\left(').replace(')', '\\right)')
    if tex>1:
        return '$$'+extension+'$$'
    else:
        return extension



