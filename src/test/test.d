import std.stdio;


class Fig{
	int i;

	this(){
		this.i = 9;
	}

	int opCall(){
		writeln(this.i);
		return 1;
	}
}

void main(){
	Fig fig = new Fig();

	writeln(fig());
}
