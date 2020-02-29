P = z^4+1;
Q8 = nfinit(P);

M0 = rnfinit(Q8, y^2-(1+z^2), 1);
M = nfinit(M0);
G = galoisinit(M);

file = fileopen("a_20_data.txt", "w");
filewrite(file, "Galois conjug classes");
filewrite(file, galoisconjclasses(G));

print(G);
print(galoisconjclasses(G));



forprime(p=3, b=10000, {
	pr = idealprimedec(M,p)[1];
	idealfrob = idealfrobenius(M, G, pr);
	/*print("pr: ", pr);
	print("idealfrob: ", idealfrob);*/
	
	filewrite(file, "\n");
	filewrite(file, p);
	filewrite(file, idealfrob);

});

fileclose(file);

