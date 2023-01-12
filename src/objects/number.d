module PzNumber;


import std.conv;

import PzObject;


class PzNum: PzObject.PzOBJECT {
	double num;
	
	this(double num){
		this.num = num;
	}

	override double __num__(){
		return this.num;
	}

	override string __str__(){
		return to!string(num);
	}

	override double __true__(){
		return this.num;
	}
}
