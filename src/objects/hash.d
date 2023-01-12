module PzHash;

import PzObject;


class PzHsh: PzOBJECT {
	PzOBJECT[string] hash;
	
	this(PzOBJECT[string] hash){
		this.hash = hash;
	}

	override PzOBJECT __index__(PzOBJECT arg){
		return hash[arg.__str__];
	}

	override void __assign__(PzOBJECT index, PzOBJECT value){
		this.hash[index.__str__] = value;
	}

	override string __str__(){
		return "{.:.}";
	}
}
