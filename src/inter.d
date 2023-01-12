module PzIntermediate;

import std.stdio;

import PzParser, PzLexer, PzNode, PzObject;
import PzBytes, PzBytes2;


class _GenInter {
	int branch, seed;
	Node[] tree; Node leaf; PzByte[] bytez;

	this(Node[] tree){
		this.branch = -1;  this.seed = 1;
		this.leaf = leaf;  this.tree = tree;
		this.bytez = bytez;
		this.climb();   this.irrigate();
	}


	void climb(){
		this.branch += 1;

		if (this.branch < this.tree.length)
			this.leaf = this.tree[this.branch];
		else
			this.seed = 0;
	}


	PzByte IntOp(string op, PzByte left, PzByte right){
		if (op == "+")
			return new Op_Nadd(left, right);

		else if (op == "-")
			return new Op_Nminus(left, right);

		else if (op == "*")
			return new Op_Ntimes(left, right);

		else if (op == "/")
			return new Op_Ndivide(left, right);

		else if (op == "%")
			return new Op_Nremainder(left, right);

		return right;
	}

	PzByte StrOp(string op, PzByte left, PzByte right){
		if (op == "+")
			return new Op_Sadd(left, right);

		else if (op == "*")
			return new Op_Stimes(left, right);

		return right;
	}

	PzByte BinaryOp(Node sap){
		int type = sap.leftRight[0].type;

		PzByte left = this.water(sap.leftRight[0]);
		PzByte right = this.water(sap.leftRight[1]);

		if (left.type == 1)
			return IntOp(sap.str, left, right);

		else if (left.type == 2)
			return StrOp(sap.str, left, right);

		else if (left.type == 3)
			return new Op_Aadd(left, right);
		
		return IntOp(sap.str, left, right);
	}

	PzByte FnCallOp(Node sap){
		PzByte[] args;
		PzByte def = this.water(sap.expr);

		foreach(Node i; sap.params)
			args ~= this.water(i);

		return new Op_FnCall(def, args);
	}

	PzByte FnDefOp(Node sap){
		PzByte[] defaults;
		
		foreach(Node i; sap.leftRight)
			defaults ~= this.water(i);

		//					fnName   params  def-params   fn-code-scope
		return new Op_FnDef(sap.str, sap.args, defaults, new _GenInter(sap.params).bytez);		
	}

	PzByte ArrOp(Node sap){
		PzByte[] arr;

		foreach(Node i; sap.params)
			arr ~= water(i);

		return new Op_Array(arr);
	}


	PzByte HashOp(Node sap){
		PzByte[] hs; 

		foreach(Node i; sap.params)
			hs ~= water(i);

		return new Op_Hash(sap.args, hs);
	}

	PzByte IndexOp(Node sap){
		PzByte key = water(sap.leftRight[0]);
		PzByte index = water(sap.leftRight[1]);

		if (sap.exe)
			return new Op_PiAssign(key, index, water(sap.leftRight[2]));
		
		return new Op_Pindex(key, index);
	}


	PzByte water(Node sap){
		if (sap.type == 26)
			return new Op_Id(sap.str);

		else if (sap.type == 1)
			return new Op_Num(sap.f64);
				
		else if (sap.type == 2)
			return new Op_Str(sap.str);

		else if (sap.type == 3)
			return this.ArrOp(sap);

		else if (sap.type == 5)
			return this.BinaryOp(sap);

		else if (sap.type == 7)
			return this.FnCallOp(sap);

		else if (sap.type == 4)
			return this.HashOp(sap);

		else if (sap.type == 9)
			return this.IndexOp(sap);

		else if (sap.type == 10)
			return this.FnDefOp(sap);

		return new PzByte();
	}

	void gen_var(){
		bytez ~= new Op_Var(this.leaf.str, water(this.leaf.expr));
	}

	void gen_fndef(){
		bytez ~= water(this.leaf);
	}

	void gen_fncall(){
		bytez ~= water(this.leaf);
	}

	void gen_objdef() {
		PzByte[] herits;
		string[] attrs;

		foreach(Node i; leaf.leftRight)
			herits ~= water(i);

		foreach(Node x; leaf.params){
			if (x.type == 10 || x.type == 6)
				attrs ~= x.str;
		}
		bytez ~= new Op_Pobj(leaf.str, herits, attrs, new _GenInter(leaf.params).bytez);
	}

	void gen_if() {
		PzByte[] elifs;

		foreach(Node i; this.leaf.params)
			elifs ~= new Op_If(water(i.expr), new _GenInter(i.params).bytez);

		bytez ~= new Op_IfCase(elifs);
	}

	void gen_while() {
		PzByte base = water(leaf.expr);
		PzByte[] code = new _GenInter(leaf.params).bytez;

		bytez ~= new Op_While(base, code);
	}

	void gen_for() {
		bytez ~= new Op_For(leaf.str, water(leaf.leftRight[0]), water(leaf.leftRight[1]), new _GenInter(leaf.params).bytez);
	}

	void gen_indexing() {
		bytez ~= water(this.leaf);
	}

	void irrigate(){
		while (this.seed){
			switch (this.leaf.type){
				case 6:
					gen_var();
					break;
				case 7:
					gen_fncall();
					break;
				case 9:
					gen_indexing();
					break;
				case 14:
					gen_if();
					break;
				case 16:
					gen_while();
					break;
				case 18:
					gen_for();
					break;
				case 10:
					gen_fndef();
					break;
				case 11:
					gen_objdef();
					break;
				default:
					
			}
			this.climb();
		}
	}
}


