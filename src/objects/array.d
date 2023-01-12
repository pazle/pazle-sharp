module PzArray;

import PzObject;


class PzArr: PzOBJECT {
	PzOBJECT[] arr;
	
	this(PzOBJECT[] arr){
		this.arr = arr;
	}

	override PzOBJECT[] __array__(){
		return this.arr;
	}

	override PzOBJECT __index__(PzOBJECT arg){
		return this.arr[cast(ulong)arg.__num__];
	}

	override void __assign__(PzOBJECT index, PzOBJECT value){
		this.arr[cast(ulong)index.__num__] = value;
	}

	override string __str__(){
		return "[...]";
	}
}


