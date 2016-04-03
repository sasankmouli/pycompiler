
package parser;

import java_cup.runtime.*;
import java.io.IOException;
import java.util.Stack;

import parser.sym;
import static parser.sym.*;

%%

%class LekserLex

%unicode
%line
%column
%public
%cup

%init{
	this.IndentStack.push(0);
	count = 0;
	
	
%init}

%{
  	private Symbol symbol(int type) {
    	return new Symbol(type, yyline, yycolumn);
  	}
  
 	private Symbol symbol(int type, Object value) {
    	return new Symbol(type, yyline, yycolumn, value);
  	}
	
	private static final int TAB_LENGTH = 4;
	
	Stack<Integer> IndentStack = new Stack<Integer>();
	private int count,i,len_token;
	private StringBuilder value_token = new StringBuilder(1000);
	private String s;
%}

Char = [^\r\n\"\\\']
Identifier = [a-zA-Z][a-zA-Z0-9_]*
OctalDigit = [0-7]
Octal = 0+ [1-3]? {OctalDigit} {1,15}
OctalLong	= 0+ 1? {OctalDigit} {1,21} [lL]
Decimal = 0 | [1-9][0-9]*
DecimalLong = {Decimal} [lL]
Hexadecimal = 0 [xX] 0* [0-9a-fA-F] {1,8}
HexadecimalLong = 0 [xX] 0* [0-9a-fA-F] {1,16} [lL]
Double = (([0-9]+ \. [0-9]*)|(\. [0-9]+)|([0-9]+)) ([eE] [+-]? [0-9]+)?
Float  = {Double} [fF]
NewLine = \r|\n|\r\n
Comment = "#" [^\r\n]* {NewLine}?
WhiteSpace =  [ \t\f]

%state STRING, MULTILINESTRING, INDENT

%%

<YYINITIAL> {

"and"			{return symbol(sym.AND);}
"false"			{return symbol(sym.FALSE);}
"true"			{return symbol(sym.TRUE);}
"__import__"			{return symbol(sym.__IMPORT__);}
"__name__"			{return symbol(sym.__NAME__);}
"abs"			{return symbol(sym.ABS);}
"apply"			{return symbol(sym.APPLY);}
"as"			{return symbol(sym.AS);}
"assert"			{return symbol(sym.ASSERT);}
"bool"			{return symbol(sym.BOOL);}
"break"			{return symbol(sym.BREAK);}
"buffer"			{return symbol(sym.BUFFER);}
"callable"			{return symbol(sym.CALLABLE);}
"chr"			{return symbol(sym.CHR);}
"class"			{return symbol(sym.CLASS);}
"classmethod"			{return symbol(sym.CLASSMETHOD);}
"cmp"			{return symbol(sym.CMP);}
"coerce"			{return symbol(sym.COERCE);}
"compile"			{return symbol(sym.COMPILE);}
"complex"			{return symbol(sym.COMPLEX);}
"continue"			{return symbol(sym.CONTINUE);}
"def"			{return symbol(sym.DEF);}
"del"			{return symbol(sym.DEL);}
"delattr"			{return symbol(sym.DELATTR);}
"dict"			{return symbol(sym.DICT);}
"dir"			{return symbol(sym.DIR);}
"divmod"			{return symbol(sym.DIVMOD);}
"elif"			{return symbol(sym.ELIF);}
"Ellipsis"			{return symbol(sym.ELLIPSIS);}
"else"			{return symbol(sym.ELSE);}
"enumerate"			{return symbol(sym.ENUMERATE);}
"eval"			{return symbol(sym.EVAL);}
"except"			{return symbol(sym.EXCEPT);}
"exec"			{return symbol(sym.EXEC);}
"execfile"			{return symbol(sym.EXECFILE);}
"file"			{return symbol(sym.FILE);}
"filter"			{return symbol(sym.FILTER);}
"finally"			{return symbol(sym.FINALLY);}
"float"			{return symbol(sym.FLOAT);}
"for"			{return symbol(sym.FOR);}
"from"			{return symbol(sym.FROM);}
"frozenset"			{return symbol(sym.FROZENSET);}
"getattr"			{return symbol(sym.GETATTR);}
"global"			{return symbol(sym.GLOBAL);}
"globals"			{return symbol(sym.GLOBALS);}
"hasattr"			{return symbol(sym.HASATTR);}
"hash"			{return symbol(sym.HASH);}
"help"			{return symbol(sym.HELP);}
"hex"			{return symbol(sym.HEX);}
"id"			{return symbol(sym.ID);}
"if"			{return symbol(sym.IF);}
"import"			{return symbol(sym.IMPORT);}
"in"			{return symbol(sym.IN);}
"input"			{return symbol(sym.INPUT);}
"int"			{return symbol(sym.INT);}
"intern"			{return symbol(sym.INTERN);}
"is"			{return symbol(sym.IS);}
"isinstance"			{return symbol(sym.ISINSTANCE);}
"issubclass"			{return symbol(sym.ISSUBCLASS);}
"iter"			{return symbol(sym.ITER);}
"lambda"			{return symbol(sym.LAMBDA);}
"len"			{return symbol(sym.LEN);}
"list"			{return symbol(sym.LIST);}
"locals"			{return symbol(sym.LOCALS);}
"long"			{return symbol(sym.LONG);}
"map"			{return symbol(sym.MAP);}
"max"			{return symbol(sym.MAX);}
"min"			{return symbol(sym.MIN);}
"name"			{return symbol(sym.NAME);}
"None"			{return symbol(sym.NONE);}
"not"			{return symbol(sym.NOT);}
"NotImplemented"			{return symbol(sym.NOTIMPLEMENTED);}
"object"			{return symbol(sym.OBJECT);}
"oct"			{return symbol(sym.OCT);}
"open"			{return symbol(sym.OPEN);}
"or"			{return symbol(sym.OR);}
"ord"			{return symbol(sym.ORD);}
"pass"			{return symbol(sym.PASS);}
"pow"			{return symbol(sym.POW);}
"print"			{return symbol(sym.PRINT);}
"property"			{return symbol(sym.PROPERTY);}
"raise"			{return symbol(sym.RAISE);}
"range"			{return symbol(sym.RANGE);}
"raw_input"			{return symbol(sym.RAW_INPUT);}
"reduce"			{return symbol(sym.REDUCE);}
"reload"			{return symbol(sym.RELOAD);}
"repr"			{return symbol(sym.REPR);}
"return"			{return symbol(sym.RETURN);}
"reversed"			{return symbol(sym.REVERSED);}
"round"			{return symbol(sym.ROUND);}
"self"			{return symbol(sym.SELF);}
"set"			{return symbol(sym.SET);}
"setattr"			{return symbol(sym.SETATTR);}
"slice"			{return symbol(sym.SLICE);}
"sorted"			{return symbol(sym.SORTED);}
"staticmethod"			{return symbol(sym.STATICMETHOD);}
"str"			{return symbol(sym.STR);}
"sum"			{return symbol(sym.SUM);}
"super"			{return symbol(sym.SUPER);}
"try"			{return symbol(sym.TRY);}
"tuple"			{return symbol(sym.TUPLE);}
"unichr"			{return symbol(sym.UNICHR);}
"unicode"			{return symbol(sym.UNICODE);}
"vars"			{return symbol(sym.VARS);}
"while"			{return symbol(sym.WHILE);}
"with"			{return symbol(sym.WITH);}
"xrange"			{return symbol(sym.XRANGE);}
"yield"			{return symbol(sym.YIELD);}
"yield"			{return symbol(sym.YIELD);}
"zip"			{return symbol(sym.ZIP);}


/*Operators*/
"+"					{	return symbol(sym.PLUS);}
"-"					{	return symbol(sym.MINUS);}
"**"				{	return symbol(sym.POW);}
"*"					{	return symbol(sym.MULT);}
"/"					{	return symbol(sym.DIV);}
"%"					{	return symbol(sym.MOD);}
"("					{	return symbol(sym.LEFTPARENTHESE);}
")"					{	return symbol(sym.RIGHTPARENTHESE);}
","					{	return symbol(sym.COMMA);}
"<"					{	return symbol(sym.LESS);}
">"					{	return symbol(sym.GREATER);}
"=="				{	return symbol(sym.EQUAL);}
">="				{	return symbol(sym.GREATEROREQUAL);}
"<="				{	return symbol(sym.LESSOREQUAL);}
"!="				{	return symbol(sym.NOTEQUAL);}
":"					{	return symbol(sym.COLON);}
";"					{	return symbol(sym.SEMICOLON);}
"="					{	return symbol(sym.ASSIGN);}
"["					{	return symbol(sym.LEFTSQUAREBRACKET);}
"]"					{	return symbol(sym.RIGHTSQUAREBRACKET);}
"{"					{	return symbol(sym.LEFTCURLYBRACKET);}
"}"					{	return symbol(sym.RIGHTCURLYBRACKET);}
"//"				{	return symbol(sym.OP_ARITH_FLDIV); }
"<<"				{	return symbol(sym.OP_BIT_LSHIFT); }
">>"				{	return symbol(sym.OP_BIT_RSHIFT); }
"&"					{	return symbol(sym.OP_BIT_AND); }
"|"					{	return symbol(sym.OP_BIT_OR); }
"^"					{	return symbol(sym.OP_BIT_XOR); }
"~"					{	return symbol(sym.OP_BIT_NOT); }
"<>"				{	return symbol(sym.OP_COMP_NOTEQ); }
"@"|"`"  { 	return symbol(sym.OP_MISC); }
"+="				{	return symbol(sym.OP_INLINE_ARITH_PLUS); }
"-="				{	return symbol(sym.OP_INLINE_ARITH_MINUS); }
"*="				{	return symbol(sym.OP_INLINE_ARITH_MULT); }
"/="				{	return symbol(sym.OP_INLINE_ARITH_DIV); }
"//="				{	return symbol(sym.OP_INLINE_ARITH_FLDIV); }
"%="				{	return symbol(sym.OP_INLINE_ARITH_MODULO); }
"&="				{	return symbol(sym.OP_INLINE_BIT_AND); }
"|="				{	return symbol(sym.OP_INLINE_BIT_OR); }
">>="				{	return symbol(sym.OP_INLINE_BIT_RSHIFT); }
"<<="				{	return symbol(sym.OP_INLINE_BIT_LSHIFT); }
"**="				{	return symbol(sym.OP_INLINE_ARITH_EXP); }

/*Strings*/
 \"{3} | \'{3} { yybegin(MULTILINESTRING);  len_token = 3; }
 \"  | \' { yybegin(STRING);  len_token = 1; }

{Identifier}		{	return symbol(sym.IDENTIFIER, yytext().toUpperCase());}
 

/*Numbers*/
 {Decimal} | {DecimalLong} | {Hexadecimal} | {HexadecimalLong} | {Octal} |
 {OctalLong} 
 {return symbol(sym.INTEGER, yytext());}

{Float}	| {Double} | {Float}[jJ] {return symbol(sym.FLOAT,yytext());}

 "."					{	return symbol(sym.FULLSTOP);}

/*Comments*/
 {Comment} {}

/*Whitespaces*/
 {WhiteSpace} { }

/*Identifiers*/ 
{NewLine} {yybegin(INDENT); count = 0; return symbol(sym.NEWLINE);}

 

/*Errors*/
  "$" | "?" { return symbol(sym.ERROR); }
}


<INDENT> {
	
" "			   		{	count++; }
"\t"			   	{	count = count + TAB_LENGTH; }

.					{	yypushback(1);
						if(count > IndentStack.peek()){
							IndentStack.push(count);
							yybegin(YYINITIAL);
							return symbol(sym.INDENT);
						}
						else if(count == IndentStack.peek()){
							yybegin(YYINITIAL);
						}
						else{
							IndentStack.pop();
							return symbol(sym.DEDENT);
						}
					}
{NewLine}	{if(count > IndentStack.peek()){
							IndentStack.push(count);
							yybegin(YYINITIAL);
							return symbol(sym.INDENT);
						}
						else if(count == IndentStack.peek()){
							yybegin(YYINITIAL);
						}
						else{
							yypushback(1);
							IndentStack.pop();
							return symbol(sym.DEDENT);
						}
					}
	
}


<STRING> {
  \"  | \' { 
	yybegin(YYINITIAL); 
	String s = value_token.toString();
	value_token.delete(0,len_token);
	return symbol(sym.STRING, s);}

  {Char}+ { len_token += yylength(); value_token.append(yytext()); }

  \\[0-3]?{OctalDigit}?{OctalDigit} { len_token += yylength(); value_token.append(yytext()); }
  
  /* escape sequences */
  \\. { len_token += 2; value_token.append(yytext());}
  {NewLine} { yybegin(YYINITIAL); }
}

<MULTILINESTRING> {
  \"{3} | \'{3} {
	yybegin(YYINITIAL);
	String s = value_token.toString();
	value_token.delete(0,len_token);
	return symbol(sym.MULTILINESTRING, s);
}

  {Char}+ { len_token += yylength(); value_token.append(yytext()); }

  \\[0-3]?{OctalDigit}?{OctalDigit} { len_token += yylength(); value_token.append(yytext());}

  /* escape sequences */
  \\. { len_token += 2; value_token.append(yytext());}
  {NewLine} { len_token ++; value_token.append(yytext()); }
}


/*Error handling*/
.|\n {}

/* End Of File */
<<EOF>> {return null; }
