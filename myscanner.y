%{
    #include <stdio.h>

	int whileLableCounter = 1;
	int forLableCounter = 1;
	int ifLableCounter = 1;
	int tempVar = 1;
	int elseLableCounter =1;
    char strBuffer[16];


%}

%start Program

// for each type we need it in union
%union{
    char relo[200];
	int labelCounter;
	char id[200];
	char num[200];
	char nont[200];
}



%token <num> NUM
%token <id> ID
%token <labelCounter> IF ELSE WHILE FOR
%token <relo> RELOP
%token INT FLOAT DOUBLE CHAR


%type <nont> IDs optexpr expr rel add term factor
//priorities

%right '='
%left RELOP
%left '-' '+'
%left '*' '/' 

%%

Program:    
    block   {;}
    ;

block:      
    '{' {printf("{\n");} stmts '}' {printf("\n}\n");}
    ;



stmts:       
    stmts stmt  {;}
    |%empty     {;}
    ;

stmt:       
    decl ';'	{printf(";\n");}
	|expr ';'	{printf("");}

    |IF
    {   
        printf("IF_BEGIN_%d:\n", $1=ifLableCounter++); 
        printf("{\n");
    } 
    '('
    {   
        printf("IF_CONDITION_%d:\n", $1); 
        printf("{\n");
    } 
    expr ')' 
    {
        printf("if (%s==0) goto ELSE_CODE_%d;\n", $5, $1); 
        printf("goto IF_CODE_%d;\n", $1); 
        printf("}\n");
    }
    {
        printf("IF_CODE_%d:\n", $1);
    }
    stmt 
    {
        //"IF" Ran then jump to end of "ELSE"

        printf("goto ELSE_END_%d;\n", $1);
	}
    ELSE 
    {
        //"IF" didnt run and "ELSE" run
        printf("ELSE_CODE_%d:\n", $1);
    } 
    stmt
    {
        //"ELSE" ran jump to end of "ELSE"
		printf("ELSE_END_%d:\n", $1);
        printf("}\n");
	}

    |WHILE
    {
		printf("WHILE_BEGIN_%d:\n", $1=whileLableCounter++);
		printf("{\n");
	} 
    '(' 
    {
		printf("WHILE_CONDITION_%d:\n", $1);
		printf("{\n");
	}
    expr ')'
    {
		printf("if (%s==0) goto WHILE_END_%d;\n", $5, $1);
		printf("goto WHILE_CODE_%d;\n", $1);
		printf("}\n");
		printf("WHILE_CODE_%d:\n", $1);
	} 
    stmt
    {
		printf("goto WHILE_CONDITION_%d;\n", $1);
		printf("}\n");
		printf("WHILE_END_%d:\n", $1);
	}

    |FOR
    {
		printf("FOR_BEGIN_%d:\n", $1=forLableCounter++);
		printf("{\n");
	} '(' optexpr ';' 
    {
		printf("FOR_CONDITION_%d:\n", $1);
		printf("{\n");
	}
    optexpr 
    {
		printf("if(%s==0) goto FOR_END_%d;\n", $7, $1);
		printf("goto FOR_CODE_%d;\n", $1);
		printf("}\n");
	}
    ';' 
    {
		printf("FOR_STEP_%d:\n", $1);
		printf("{\n");
	}optexpr
    {
		printf("goto FOR_CONDITION_%d;\n", $1);
		printf("}\n");
	} 
    ')' 
    {
		printf("FOR_CODE_%d:\n", $1);
	}
    stmt
    {
		printf("goto FOR_STEP_%d;\n", $1);
		printf("}\n");
		printf("FOR_END_%d:\n", $1);
	}

    |block  {;}
    ;

decl:
	INT IDs			{printf("int %s", $2);}
	|DOUBLE IDs		{printf("double %s", $2);}
    |FLOAT IDs		{printf("float %s", $2);}
    |CHAR IDs		{printf("char %s", $2);}
	;

IDs:    
	IDs ',' ID				{sprintf($$, "%s, %s", $1, $3);} 
	|IDs ',' ID '=' expr	{sprintf($$, "%s, %s = %s", $1, $3, $5);}
	|ID						{sprintf($$, "%s",$1);}
	|ID '=' expr			{sprintf($$, "%s = %s", $1, $3);}
	;

optexpr:    
    expr            {strcpy($$, $1);}
    |%empty         {;}
    ;

expr:       
    ID '=' expr     {strcpy($$, $3); printf("%s = %s;\n", $1, $3);}
    |rel            {strcpy($$, $1);}
    ;

rel:        
    rel RELOP add       {sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
    |add                {strcpy($$, $1);}
    ;

add:        
    add '+' term        {sprintf($$, "t%d", tempVar++); printf("int %s = %s + %s;\n", $$, $1, $3);}
    |add '-' term       {sprintf($$, "t%d", tempVar++); printf("int %s = %s - %s;\n", $$, $1, $3);}
    |term               {strcpy($$, $1);}
    ;

term:       
    term '*' factor     {sprintf($$, "t%d", tempVar++); printf("int %s = %s * %s;\n", $$, $1, $3);}
    |term '/' factor    {sprintf($$, "t%d", tempVar++); printf("int %s = %s / %s;\n", $$, $1, $3);}
    |factor             {strcpy($$, $1);}
    ;

factor:     
    '(' expr ')'        {strcpy($$, $2);}
    |NUM                {strcpy($$, $1);}
    |ID                 {strcpy($$, $1);}
    ;

%%

void yyerror (char const *s) {
		
	
}

int yywrap(){
	return 1;
}

int main(){
	yyparse();
}