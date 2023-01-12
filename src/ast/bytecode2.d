module PzBytes2;


import std.conv;

import PzBytes;
import PzObject, PzNumber, PzString;


alias PzOBJECT[string] HEAP;


class Op_Num: PzByte {
	PzOBJECT _num;

	this(double number){
		this._num = new PzNum(number);
	}

	override PzOBJECT opCall(HEAP _heap) {
		return this._num;
	}
	override int type(){ return 1; }
}


class Op_Nadd: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzNum(left(_heap).__num__ + right(_heap).__num__);
	}
	override int type(){ return 1; }
}


class Op_Nminus: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzNum(left(_heap).__num__ - right(_heap).__num__);
	}
	override int type(){ return 1; }
}


class Op_Ntimes: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzNum(left(_heap).__num__ * right(_heap).__num__);
	}
	override int type(){ return 1; }
}


class Op_Ndivide: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzNum(left(_heap).__num__ / right(_heap).__num__);
	}
	override int type(){ return 1; }
}


class Op_Nremainder: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzNum(left(_heap).__num__ % right(_heap).__num__);
	}
	override int type(){ return 1; }
}


class Op_Str: PzByte {
	PzOBJECT _str;

	this(string st){
		this._str = new PzStr(st);
	}

	override PzOBJECT opCall(HEAP _heap) {
		return this._str;
	}
	override int type(){ return 2; }
}


class Op_Sadd: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzStr(left(_heap).__str__ ~ right(_heap).__str__);
	}
	override int type(){ return 2; }
}


class Op_Stimes: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		int times = cast(int)right(_heap).__num__;
		string gen;

		for(int i =0; i < times; i++)
			gen ~= left(_heap).__str__;

		return new PzStr(gen);
	}
	override int type(){ return 2; }
}
