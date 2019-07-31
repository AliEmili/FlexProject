%{
#include<stdio.h>
#include<string.h>
#include<conio.h>
#include<stdlib.h>
char c;
void toUpper(char k[])
	{
	int i;
	for(i=0;i<=strlen(k);++i)
	if(k[i]<='z'&&k[i]>='a')
	k[i]-=32;
	}
	
int is_keyword(char id[])
	{
	char keyword[40][20]={"AND", "ARRAY", "BEGIN", "CASE", "CONST","DIV", "DO", "DOWNTO", "ELSE", "END", "EXTERNAL", "EXTERN", "FILE", "FOR", "FORWARD", "FUNCTION", "GOTO", "IF","IF","IN","LABEL","MOD","NIL","NOT","OF","OR","OTHERWISE", "PROCEDURE","PROGRAM","RECORD", "REPEAT", "THEN", "TO", "TYPE", "UNTIL", "VAR", "WHILE", "WITH"};
	int i;
	for(i=0;i<40;i++)
		if(strcmp(id, keyword[i])==0)return i;
	return -1;
	}
%}
%option noyywrap
NQUOTE ['^']
%%
[a-zA-Z]([a-zA-Z0-9])*	{
							toUpper(yytext);
							if(is_keyword(yytext)!=-1)
								printf("KEYWORD=%s\n",yytext);
							else
								printf("ID\n");	
						}

":="				printf("ASSIGNMENT\n");
"'({NQUOTE})+'"	printf("CHARACTER_STRING\n");
":"					printf("COLON\n");
","					printf("COMMA\n");
[0-9]+				printf("DIGSEQ\n");
"."					printf("DOT\n");
".."				printf("DOTDOT\n");	
"="					printf("EQUAL\n");
">="				printf("GE\n");
">"					printf("GT\n");
"["					printf("LBRAC\n");
"<="				printf("LE\n");
"("					printf("LPAREN\n");
"<"					printf("LT\n");
"-"					printf("MINUS\n");
"<>"				printf("NOTEQUAL\n");
"+"					printf("PLUS\n");
"]"					printf("RBRAC\n");
[0-9]="."[0-9]+		printf("REALNUMBER\n");
")"					printf("RPAREN\n");
";"					printf("SEMICOLON\n");
"/"					printf("SLASH\n");
"*"					printf("STAR\n");
"**"				printf("STARSTAR\n");
"^"					printf("UPARROW\n");
" "					printf("SPACE\n");
"(*"				do{
						c=input();
						if(c=='*'){
							c=input();
							if(c==')')
							break;
							else unput(c);
						}
					}while(1);
"{"					while((c=input())!='}');
[\n\t]				;
.					printf("Error: ILLEGAL\n");
%%
int main(){
	yylex();
	return 0;
}
