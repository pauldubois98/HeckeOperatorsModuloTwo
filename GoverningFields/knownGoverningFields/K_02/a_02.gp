P = z^4+1;
Q8 = nfinit(P);

M0 = rnfinit(Q8, y^2-(z+z^7), 1);
M = nfinit(M0);
G = galoisinit(M);

/* open file */
file = fileopen("a_02_data.txt", "w");
filewrite(file, "Extension");
filewrite(file, "#2");
filewrite(file, "\\zeta_8");
filewrite(file, "\\sqrt[4]{2}");
filewrite(file, "\n");

/* first group identification */
filewrite(file, "Galois identify");
filewrite(file, galoisidentify(G));
filewrite(file, "\n");

/* second conjugacy classes */
filewrite(file, "Galois conjug classes");
filewrite(file, galoisconjclasses(G));
filewrite(file, "\n");

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
