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
z8 = M.tu[2];


forvec(X=[[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]], {
	if(X==[0,0,0,0,0,0,0,0], next());
	
	/* element to extend */
	beta = z8^X[8];
	for(i=1,7,beta *= M.fu[i]^X[i]);
	
	/* extension */
	u = varhigher("u");
	L0 = rnfinit(M4, u^2-beta, 0);
	L = nfinit(L0);
	G = galoisinit(L);
	
	/* *** avoid non galois ext *** */
	if(G==0, next());

	print(X)
	
})
