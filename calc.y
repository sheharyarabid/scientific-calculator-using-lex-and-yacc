%{
#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<alloca.h>
#include<stddef.h>
int yylex(void);
int flag=0,m=0,count=0;
void yyerror(char *s) {      
           flag=1;
}
%}
%union { 
double p;
}
%token L_BRACKET R_BRACKET
%token<p>num 
%token ADD SUB MUL DIV PI SQRT POW
%token SIN COS TAN QUIT_CMD
%left SUB ADD		
%left MUL DIV        
%left POW SQRT 
%left L_BRACKET R_BRACKET
%left LOG
%type<p>exp        
%type<p>constant 
%%
ss: exp {
	if(flag==0) 
       printf("Result = %g\n",$1);
       }                            
exp :  exp ADD exp {
	$$=$1+$3;
	}
       |exp SUB exp { 
       $$=$1-$3;
       }
       |exp MUL exp { 
       $$=$1*$3;
       }
       |exp DIV exp {
       $$=$1/$3;
       } 
       |SUB exp {
       $$=-$2;
       }
       |exp POW exp {
       $$=pow($1,$3);
       }
       |LOG L_BRACKET exp R_BRACKET {
       $$=log10($3);
       }
       |SQRT L_BRACKET exp R_BRACKET {
       $$=sqrt($3);
       }
       |SIN L_BRACKET exp  R_BRACKET {
       $$= m==1 ? sin($3*3.14159/180): sin($3);
       }
       |COS L_BRACKET exp  R_BRACKET {
       $$= m==1 ? cos($3*3.14159/180): cos($3);
       }
       |TAN L_BRACKET exp  R_BRACKET {
       $$= m==1 ? tan($3*3.14159/180): tan($3);
       }
       |L_BRACKET exp R_BRACKET {
       $$=$2;
       }
       |num {
       $$=$1;
       } 
       |QUIT_CMD {
       printf("Program successfully terminated.\n");
       exit(EXIT_SUCCESS);}
       |constant;
       constant:PI {
       $$=3.14159;
       };
%%
void main()
{
       printf("Welcome to your Scientific Calculator based on Lex and Yacc!\n");
       printf("Note: \n-Supported Operations: add,sub,mul,div,sin,cos,tan,log,sqrt,power\n");
       printf("-To exit the program input 'quit'\n\n");    
	do {   
	char ch;
	flag=0,count=0;
	printf("Input a Valid Expression: ");
        yyparse();
        if(flag==-1) {
        flag=0;
        yyparse();
        }	
	}while(1);
}
