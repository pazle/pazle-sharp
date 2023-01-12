module PzString;


import PzObject;


class PzStr: PzOBJECT {
	string _str;
	
	this(string _str){
		this._str = _str;
	}

	override string __str__(){
		return this._str;
	}
}
