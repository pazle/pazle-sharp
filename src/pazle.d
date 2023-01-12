import std.stdio, std.file;

import PzParser, PzLexer, PzNode, PzBytes, PzIntermediate, PzExec;
import PzObject, PzString;


alias PzOBJECT[string] Memory;

int main(){
	string code = readText("src/test/main.pz");

	Token[] tokens = new Lex(code).tokens;
	Node[] tree = new Parse(tokens, " ").ast;

	PzByte[] bcode = new _GenInter(tree).bytez;

	Memory storage;
	new _Interpreter(bcode, ["print": new PzPrint()]);

	return 0;
}
