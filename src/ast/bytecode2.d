module PzBytes2;


import std.conv;
import std.stdio;

import PzBytes;
import PzObject, PzNumber, PzString, PzArray;
import PzHash, PzType;


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


class Op_Array: PzByte {
	PzByte[] items;

	this(PzByte[] items){
		this.items = items;
	}

	override PzOBJECT opCall(HEAP _heap) {
		PzOBJECT[] arr;

		foreach(PzByte i; items)
			arr ~= i(_heap);

		return new PzArr(arr);
	}
	override int type(){ return 3; }
}


class Op_Aadd: PzByte {
	PzByte left, right;

	this(PzByte left, PzByte right){
		this.left = left;
		this.right = right;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return new PzArr(left(_heap).__array__ ~ right(_heap).__array__);
	}

	override int type(){ return 3; }
}


class Op_Hash: PzByte {
	string[] keys;
	PzByte[] values;

	this(string[] keys, PzByte[] values){
		this.keys = keys;
		this.values = values;
	}

	override PzOBJECT opCall(HEAP _heap) {
		PzOBJECT[string] hash;

		for(int i = 0; i < keys.length; i++)
			hash[keys[i]] = values[i](_heap);

		return new PzHsh(hash);
	}

	override int type(){ return 3; }
}


class Op_Pindex: PzByte {
	PzByte value, index;

	this(PzByte value, PzByte index){
		this.value = value;
		this.index = index;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return value(_heap).__index__(index(_heap));
	}
}


class Op_PiAssign: PzByte {
	PzByte key, index, value;

	this(PzByte key, PzByte index, PzByte value){
		this.key = key;
		this.index = index;
		this.value = value;
	}

	override PzOBJECT opCall(HEAP _heap) {
		key(_heap).__assign__(index(_heap), value(_heap));
		return new PzOBJECT();
	}
}


class Op_Pobj: PzByte {
	string name;
	string[] attrs;
	PzByte[] contrib, code;

	this(string name, PzByte[] contrib, string[] attrs, PzByte[] code){
		this.name = name;
		this.code = code;
		this.attrs = attrs;
		this.contrib = contrib;
	}

	override PzOBJECT opCall(HEAP _heap){
		PzOBJECT[] h;

		foreach(PzByte i; contrib)
			h ~= i(_heap);

		_heap[name] = new PzTyp(name, h, attrs, code, _heap);
		return new PzOBJECT();
	}
}

