P = z^4+1;
Q8 = nfinit(P);
M0 = rnfinit(Q8, y^2-(z+z^7), 1);
M1 = nfinit(M0);
M2 = bnfinit(M1[1]);
v1 = M2.fu[1];
v2 = M2.fu[2];
v3 = M2.fu[3];
alpha = v1*v2*v3;
M3 = rnfinit(M1, x^2-alpha, 0);
M4 = nfinit(M3);
T = M4[1];
M = bnfinit(T);


print("# torsion units:")
print(length(M.tu));
print("# fundamental units:")
print(length(M.fu));

/* generator for the torsion units */
mu = M.tu[2];

ext_codes = [ [0, 0, 0, 0, 0, 0, 0, 1], [0, 0, 0, 1, 1, 1, 1, 0], [0, 0, 0, 1, 1, 1, 1, 1] ]

for(ind=1, 3,{
	/* extension details */
	X = ext_codes[ind];
	print(X);
	beta = mu^X[8];
	for(i=1,7,beta *= M.fu[i]^X[i]);
	
	/* extension */
	u = varhigher("u");
	L0 = rnfinit(M4, u^2-beta, 0);
	L = nfinit(L0);
	G = galoisinit(L);
	
	/* open file */
	filename = Str("a_04_ext_" X[1] X[2] X[3] X[4] X[5] X[6] X[7] X[8] ".txt");
	file = fileopen(filename, "w");
	print(filename);
	filewrite(file, "Extension");
	filewrite(file, "#4");
	filewrite(file, "\\zeta_8");
	filewrite(file, "\\sqrt[4]{2}");
	filewrite(file, "sqrt(alpha)");
	filewrite(file, "sqrt(beta)");
	
	filewrite(file, "sqrt(sqrt(2))");
	filewrite(file, alpha);
	filewrite(file, "sqrt(alpha)");
	filewrite(file, beta);
	filewrite(file, "\n");

	/* first group identification */
	filewrite(file, "Galois identify");
	filewrite(file, galoisidentify(G));
	filewrite(file, "\n");
	
	/* second conjugacy classes */
	filewrite(file, "Galois conjug classes");
	filewrite(file, galoisconjclasses(G));
	filewrite(file, "\n");
	
	/* forbenius elemnts of primes >2 */
	forprime(p=3, b=10000, pr = idealprimedec(L,p)[1]; idealfrob = idealfrobenius(L,G,pr); filewrite(file, p); filewrite(file, idealfrob));
	
	/*pr = idealprimedec(L,3)[1];
	idealfrob = idealfrobenius(L,G,pr);
	print("idealfrob: ", idealfrob);*/
	
	fileclose(file)

	
})
