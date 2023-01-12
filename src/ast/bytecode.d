module PzBytes;

import std.stdio;
import PzObject, PzNumber, PzString, PzFunction;
import PzExec;


alias PzOBJECT[string] HEAP;


class PzByte {
	PzByte[string] hash;

	PzOBJECT opCall(HEAP _heap){ return new PzOBJECT(); }

	PzByte[] opCode(){ return []; }

	int type(){ return 0; }
}


class Op_Var: PzByte {
	PzByte value;
	string key;

	this(string key, PzByte value){
		this.value = value;
		this.key = key;
	}

	override PzOBJECT opCall(HEAP _heap) {
		_heap[this.key] = this.value(_heap);
		return new PzOBJECT();
	}
}


class Op_Id: PzByte {
	string key;

	this(string key){
		this.key = key;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return _heap[key];
	}
}


class Op_FnDef: PzByte {
	string name;
	PzByte[] code;
	string[] params;
	PzByte[] defaults;

	this(string name, string[] params, PzByte[] defaults, PzByte[] code){
		this.code = code;
		this.name = name;
		this.params = params;
		this.defaults = defaults;
	}

	override PzOBJECT opCall(HEAP _heap){
		_heap[name] = new PzFn(name, params, code, defaults, _heap);
		return new PzOBJECT();
	}
}


class Op_FnCall: PzByte {
	PzByte def;
	PzByte[] args;

	this(PzByte def, PzByte[] args){
		this.def = def;
		this.args = args;
	}

	override PzOBJECT opCall(HEAP _heap){
		PzOBJECT[] params;

		foreach(PzByte i; this.args)
			params ~= i(_heap);

		return this.def(_heap)(params);
	}
}


class Op_If: PzByte {
	PzByte exe;
	PzByte[] code;

	this(PzByte exe, PzByte[] code){
		this.exe = exe;
		this.code = code;
	}

	override PzOBJECT opCall(HEAP _heap) {
		return exe(_heap);
	}

	override PzByte[] opCode(){
		return this.code;
	}
}

class Op_IfCase: PzByte {
	PzByte[] ifs;

	this(PzByte[] ifs){
		this.ifs = ifs;
	}

	override PzOBJECT opCall(HEAP _heap) {
		foreach(PzByte fi; ifs){
			if(fi(_heap).__true__){
				new _Interpreter(fi.opCode, _heap);
				break;
			}
		}

		//new _Interpreter(code, _heap);
		return new PzOBJECT();
	}
}


