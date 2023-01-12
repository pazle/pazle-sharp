module PzFunction;

import std.stdio;
import PzObject, PzBytes2, PzBytes, PzExec;


alias PzOBJECT[string] store;

class PzFn: PzOBJECT {
	store heap;
	string name;
	PzByte[] code;
	string[] params;
	PzOBJECT[] defaults;
	
	this(string name, string[] params, PzOBJECT[] defaults, PzByte[] code, store heap){
		this.name = name;
		this.code = code;
		this.heap = heap;
		this.params = params;
		this.defaults = defaults;
	}

	override PzOBJECT opCall(PzOBJECT[] args){
		new _Interpreter(code, heap.dup);
		return new PzOBJECT();
	}

	override string __str__(){
		return "<function '" ~ this.name ~ "'>";
	}
}
