module PzExec;


import std.stdio;

import PzParser, PzLexer, PzNode, PzBytes, PzIntermediate;
import PzObject, PzString;


alias PzOBJECT[string] Memory; 


class _Interpreter {
	PzByte[] code;
	Memory heap;

	this(PzByte[] code, Memory heap){
		this.code = code;
		this.heap = heap;

		this._initialize();
	}

	void _initialize(){
		foreach(PzByte i; this.code)
			i(heap);
	}
}

