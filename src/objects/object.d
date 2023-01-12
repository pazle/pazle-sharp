module PzObject;

import std.stdio;
import core.stdc.stdio;
import PzBytes, PzBytes2;


class PzOBJECT {
	PzOBJECT[string] hash;

	string __str__(){ return ""; }

	double __num__(){ return 0; }

	PzOBJECT[] __array__(){ return []; }

	PzOBJECT[string] __hash__ (){ return hash; }

	char[] __chars__() { return []; }

	PzOBJECT __index__(PzOBJECT arg) {return new PzOBJECT(); }

	void __assign__(PzOBJECT index, PzOBJECT value){ }

	PzOBJECT opCall(PzOBJECT[] args) { return new PzOBJECT(); }

	double __true__(){ return 0; }
}


class PzPrint: PzOBJECT {
	override PzOBJECT opCall(PzOBJECT[] args){
		foreach(PzOBJECT i; args)
			printf("%.*s ", cast(int) i.__str__.length, i.__str__.ptr);

		printf("\n");
		return new PzOBJECT();
	}

	override string __str__(){
		return "<print (builtin method)>";
	} 
}
