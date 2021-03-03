grammar Simple;

@parser::header{
	import java.util.Map;
	import java.util.HashMap;
}

@parser::members{
	Map<String, Object> symbolTable = new HashMap<String, Object>();	
}

program: PROGRAM ID BRACKET_ABRIR 
	sentencia*
	BRACKET_CERRAR;
	
sentencia: 
	var_decl 
	| 
	var_assign 
	| 
	println;

var_decl: VAR ID PUNTOCOMA
	{symbolTable.put($ID.text,0);};
	
var_assign: ID ASIGNAR expresion PUNTOCOMA
	{symbolTable.put($ID.text,$expresion.value);};
	
println: IMPR expresion PUNTOCOMA
	{System.out.println($expresion.value);};
	
expresion returns [Object value]: 
	NUMERO {$value = Integer.parseInt($NUMERO.text);}
	| 
	ID {$value = symbolTable.get($ID.text);};

PROGRAM: 'program';
VAR: 'var';
IMPR: 'println';

SUMA: '+';
RESTA: '-';
MULT: '*';
DIV: '/';

Y: '&&';
O: '||';
NO: '!';

MAQ: '>';
MNQ: '<';
MAIQ: '>==';
MNIQ: '<==';
IQ: '==';
NIQ: '!=';

SI: 'if';
SINO: 'else';

ASIGNAR: '=';

BRACKET_ABRIR: '{';
BRACKET_CERRAR: '}';
PAR_ABRIR: '(';
PAR_CERRAR: ')';

PUNTOCOMA: ';';

ID:[a-zA-Z_][a-zA-Z0-9_]*;
NUMERO: [0-9]+;
FLOAT: [0-9].[0-9]+;
ESPACIO: [ \n\t\r]+ ->skip;