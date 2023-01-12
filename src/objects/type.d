module PzType;

import std.stdio;
import PzObject, PzBytes2, PzBytes, PzExec;

alias PzOBJECT[string] store;


class PzTyp: PzOBJECT {
	store heap;
	string name;
	PzByte[] code;
	string[] attrs;
	PzOBJECT[] contrib;
	
	this(string name, PzOBJECT[] contrib, string[] attrs, PzByte[] code, store heap){
		this.heap = heap;
		this.name = name;
		this.code = code;
		this.attrs = attrs;
		this.contrib = contrib;

		// class attributes
		writeln(attrs);
	}

	override PzOBJECT opCall(PzOBJECT[] args){
		return new PzOBJECT();
	}

	override string __str__(){
		return "<type '"~ name ~"'>";
	}
}

