parser grammar StlParser ;

options {
	tokenVocab = StlLexer ;
}

stlfile
	: stlSpecification EOF ;

stlSpecification
    : ( spec )? ( modimport )* ( declaration | annotation )* assertion ;
	
spec
	: Specification Identifier #Specification ;

modimport :
        From Identifier Import Identifier #modImport ;

assertion 
	: Identifier EQUAL expression ;

declaration 
	: variableDeclaration                                         #declVariable ;

annotation
        : '@' annotation_type ;

annotation_type
        : ROS_Topic LPAREN Identifier COMMA Identifier RPAREN #rosTopic;

variableDeclaration
	: Constant? ioType? domainType identifier assignment?  ;

assignment
	: EQUAL literal 				#AsgnLiteral
	| EQUAL expression 				#AsgnExpr ;

domainType
	: DomainTypeFloat
	| DomainTypeInt
    | DomainTypeLong
    | DomainTypeComplex
    | Identifier ;

ioType
	: Input
	| Output ;

interval
	: LBRACK intervalTime COLON intervalTime RBRACK ;

intervalTime
	: IntegerLiteral ( unit )?      #intervalTimeLiteral ;

unit
    : SEC | MSEC | USEC | NSEC | PSEC ;

 

// -- O -- O -- O -- O -- O -- O -- O -- O -- O -- O -- O -- O -- O  expression

expression
	: 

    real_expression                                             #ExprReal
    | expression comparisonOp literal                             #IdCompInt
//    | idComp                                                    #ExprIdComp
	
	| LPAREN expression RPAREN                                  #ExprParen
	| NotOperator expression                                    #ExprNot

    | expression OrOperator expression                          #ExprOrExpr
    | expression AndOperator expression                         #ExprAndExpr
    | expression ImpliesOperator expression                     #ExprImpliesExpr
    | expression IffOperator expression                         #ExprIffExpr
    | expression XorOperator expression                         #ExprXorExpr

	| AlwaysOperator ( interval )? expression                   #ExprAlwaysExpr
    | EventuallyOperator ( interval )? expression               #ExprEvExpr
    | expression UntilOperator interval expression              #ExprUntilExpr
    | HistoricallyOperator ( interval )? expression             #ExprHistExpr
    | OnceOperator ( interval )? expression                     #ExpreOnceExpr
    | expression SinceOperator ( interval )? expression         #ExprSinceExpr
	;

//idComp
//	: real_expression comparisonOp literal    #IdCompInt
//	;

real_expression:
    Identifier                                                  #ExprId
    | real_expression PLUS real_expression                      #ExprAddition
	| real_expression MINUS real_expression                     #ExprSubtraction
	| real_expression TIMES real_expression                     #ExprMultiplication
	| real_expression DIVIDE real_expression                    #ExprDivision

	| ABS LPAREN real_expression RPAREN                         #ExprAbs
	;


comparisonOp
	: LesserOrEqualOperator                                     #CmpOpLs
	| GreaterOrEqualOperator 				    #CmpOpGte
	| LesserOperator                                            #CmpOpLse
	| GreaterOperator                                           #CmpOpGt 
    | EqualOperator                                             #CmpOpEq
    | NotEqualOperator                                          #ComOpNeq
	;
	
literal
	: IntegerLiteral		
	| RealLiteral			
	;

identifier
	: Identifier											 #Id ;

