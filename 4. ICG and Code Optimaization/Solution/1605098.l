%option noyywrap

%{
//#include<stdio.h>
//#include<fstream>
//#include<cstdlib>
//#include<iostream>
#include<iostream>
#include<stdlib.h>
#include<string.h>

#include "1605098_SymbolTable.h"
#define YYSTYPE SymbolInfo*
#include "y.tab.h"

using namespace std;

extern YYSTYPE yylval;
extern SymbolTable *table;
void yyerror(char *);

extern int line_no;
extern int error_no;
//extern "C" int yylex();
//ofstream tokenout;
//ofstream logout;
//tokenout.open ("1605098_token.txt");
//logout.open ("1605098_log.txt");
//FILE * tokenout ;
//FILE * logout ;
//SymbolTable st(40, logout);

%}

WHITESPACE [ \t\f\r\v]+ 
DIGIT [0-9]
LETTER [a-zA-Z]
NEWLINE \n
CHAR [ -~]{-}['\\]

%%
{WHITESPACE}+   {}

{NEWLINE}  { line_no++; }


"if"	{
             return IF;
			//fprintf(tokenout , "<IF>");
			//fprintf(logout , "Line no  %d : TOKEN <IF> Lexeme  %s  found.\n",line_no,yytext);
		}
		
"else"	{
			return ELSE;
			//fprintf(tokenout , "<ELSE>");
			//fprintf(logout , "Line no  %d : TOKEN <ELSE> Lexeme  %s  found.\n",line_no,yytext);
		}
		
"for"	{
            return FOR;
			//fprintf(tokenout , "<FOR>");
			//fprintf(logout , "Line no %d: TOKEN <FOR> Lexeme %s found.\n",line_no,yytext);
		}
		
"while"	{
            return WHILE;
			//fprintf(tokenout , "<WHILE>");
			//fprintf(logout , "Line no %d: TOKEN <WHILE> Lexeme %s found.\n",line_no,yytext);
		}
		
"do"	{
			return DO;
			//fprintf(tokenout , "<DO>");
			//fprintf(logout , "Line no %d: TOKEN <DO> Lexeme %s found.\n",line_no,yytext);
		}
		
"break"	{
			return BREAK;
			//fprintf(tokenout , "<BREAK>");
			//fprintf(logout , "Line no %d: TOKEN <BREAK> Lexeme %s found.\n",line_no,yytext);
		}
		
"int"	{
            SymbolInfo *s=new SymbolInfo(yytext,"INT");
            yylval=(YYSTYPE)s;
           return INT;
           // ofstream tmpfile;
            //tmpfile.open ("1605098_log.txt");
            //tmpfile << "Writing this to a file.\n";
			//fprintf(tokenout , "<INT>");
			//fprintf(logout , "Line no %d: TOKEN <INT> Lexeme %s found.\n",line_no,yytext);
		}
		
"char"	{
			return CHAR;
			//fprintf(tokenout , "<CHAR>");
			//fprintf(logout , "Line no %d: TOKEN <CHAR> Lexeme %s found.\n",line_no,yytext);
		}		
		
"float"	{
            SymbolInfo *s=new SymbolInfo(yytext,"FLOAT");
            yylval=(YYSTYPE)s;
			return FLOAT;
			//fprintf(tokenout , "<FLOAT>");
			//fprintf(logout , "Line no %d: TOKEN <FLOAT> Lexeme %s found.\n",line_no,yytext);
		}
		
"double" {
			return DOUBLE;
			//fprintf(tokenout , "<DOUBLE>");
			//fprintf(logout , "Line no %d: TOKEN <DOUBLE> Lexeme %s found.\n",line_no,yytext);
		}
		
"void"	{
            SymbolInfo *s=new SymbolInfo(yytext,"VOID");
            yylval=(YYSTYPE)s;
			return VOID;
			//fprintf(tokenout , "<VOID>");
			//fprintf(logout , "Line no %d: TOKEN <VOID> Lexeme %s found.\n",line_no,yytext);
		}		
		
"return" {
			return RETURN;
			//fprintf(tokenout , "<RETURN>");
			//fprintf(logout , "Line no %d: TOKEN <RETURN> Lexeme %s found.\n",line_no,yytext);
		}
		
"switch" {
			return SWITCH;
			//fprintf(tokenout , "<SWITCH>");
			//fprintf(logout , "Line no %d: TOKEN <SWITCH> Lexeme %s found.\n",line_no,yytext);
		}		
		
"case"	{
			return CASE;
			//fprintf(tokenout , "<CASE>");
			//fprintf(logout , "Line no %d: TOKEN <CASE> Lexeme %s found.\n",line_no,yytext);
		}
		
"default" {
			return DEFAULT;
			//fprintf(tokenout , "<DEFAULT>");
			//fprintf(logout, "Line no %d: TOKEN <DEFAULT> Lexeme %s found.\n",line_no,yytext);
		}		
		
"continue" {
			return CONTINUE;
			//fprintf(tokenout , "<CONTINUE>");
			//fprintf(logout , "Line no %d: TOKEN <CONTINUE> Lexeme %s found.\n",line_no,yytext);
		}
		
"println" {return PRINTLN;}
		


"+"|"-"	{
            SymbolInfo *s= new  SymbolInfo(yytext, (char *)"ADDOP");
			yylval = (YYSTYPE)s;
			return ADDOP;
			//fprintf(tokenout,"<ADDOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"ADDOP");
		    }

"*"|"/"|"%"  {
            SymbolInfo *s= new  SymbolInfo(yytext, (char *)"MULOP");
			yylval = (YYSTYPE)s;
			return MULOP;
			//fprintf(tokenout,"<MULOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"MULOP");
         }
         
"++"    {
            return INCOP;
            //fprintf(tokenout,"<INCOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"INCOP");         
         }
"--"    {return DECOP; }
         
"<"|"<="|">"|">="|"=="|"!="  {
            SymbolInfo *s= new  SymbolInfo(yytext, (char *)"RELOP");
		    yylval = (YYSTYPE)s;
		    return RELOP;
		    //fprintf(tokenout,"<RELOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RELOP");
         }
				
"="      {
            return ASSIGNOP;
            //fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"ASSIGNOP");
         }		
		
"&&"|"||"  {
            SymbolInfo *s= new  SymbolInfo(yytext, (char *)"LOGICOP");
			yylval = (YYSTYPE)s;
			return LOGICOP;
			//fprintf(tokenout,"<LOGICOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"LOGICOP");
         }		

"&"|"|"|"^"|"<<"|">>"  {
            SymbolInfo *s= new  SymbolInfo(yytext, (char *)"BITOPOP");
			yylval = (YYSTYPE)s;
			return BITOPOP;
			//fprintf(tokenout,"<BITOPOP,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <BITOPOP> Lexeme %s found.\n",line_no,yytext); 
			//st.insert(yytext,"BITOPOP");
         }
         
"!"      {
            return NOT;
            //fprintf(tokenout,"<NOT,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <NOT> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"NOT");
         }
         
"("      {
            return LPAREN;
            //fprintf(tokenout,"<LPAREN,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <LPAREN> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LPAREN");
         }  
         
")"      {
            return RPAREN;
            //fprintf(tokenout,"<RPAREN,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <RPAREN> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RPAREN");
         }           

"{"      {
            return LCURL;
            //fprintf(tokenout,"<LCURL,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <LCURL> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LCURL");
         } 
         
"}"      {
            return RCURL;
            //fprintf(tokenout,"<RCURL,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <RCURL> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RCURL");
         }
         
"["      {
            return LTHIRD;
            //fprintf(tokenout,"<LTHIRD,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <LTHIRD> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LTHIRD");
         }

"]"      {
            return RTHIRD;
            //fprintf(tokenout,"<RTHIRD,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <RTHIRD> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RTHIRD");
         }
         
","      {
            return COMMA;
            //fprintf(tokenout,"<COMMA,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"COMMA");
         }
         
";"      {
            return SEMICOLON;
            //fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			//fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"SEMICOLON");
         }   


{DIGIT}+ 	{
				SymbolInfo *s= new  SymbolInfo(yytext, (char *)"CONST_INT");
				yylval = (YYSTYPE)s;
				return CONST_INT;
				//fprintf(tokenout,"<CONST_INT,%s>",yytext);
				//fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found.\n",line_no,yytext);
				//st.insert(yytext,"CONST_INT");
			}
			
{DIGIT}*(\.{DIGIT}*)([Ee][+-]?{DIGIT}*)? {
				SymbolInfo *s= new  SymbolInfo(yytext, (char *)"CONST_FLOAT");
				yylval = (YYSTYPE)s;
				return CONST_FLOAT; 
				//fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				//fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found.\n",line_no,yytext);				
				//st.insert(yytext,"CONST_FLOAT");
				
			}

{DIGIT}*([\.]+{DIGIT}*)+(E[\.]*[+-]?[\.]*{DIGIT}*)?[\.]*{DIGIT}*	{
										//fprintf(logout,"Error at Line No.%d:  Too many decimal point %s \n",line_no,yytext);
										error_no++;

									}
                            
({DIGIT}+|{DIGIT}*\.{DIGIT}+([eE][-+]?{DIGIT}+)?|{DIGIT}+([eE][-+]?{DIGIT}+)?)[E]*({DIGIT}+|{DIGIT}*\.{DIGIT}+([eE][-+]?{DIGIT}+)?|{DIGIT}+([eE][-+]?{DIGIT}+)?)* {
            //fprintf(logout,"Error at Line No.%d:  Ill formated number  %s \n.",line_no,yytext);
            error_no++;
            }

			
\'({CHAR}|\\['"?\\abfnrtv])\'		{
                SymbolInfo *s= new  SymbolInfo(yytext, (char *)"CONST_INT");
				yylval = (YYSTYPE)s;
				return CONST_CHAR;
							//fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
							//fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found.\n",line_no,yytext);
							//st.insert(yytext,"CONST_CHAR");			
            }
            
\'({CHAR}|[\\])*[^'\n]?		{
						
							//fprintf(logout,"Error at Line No.%d: Unfinished Character Sequence found %s \n",line_no,yytext);
							error_no++;
						}

\'({CHAR}|[\\])*\'			{
						
						//fprintf(logout,"Error at Line No.%d: Invalid Character Sequence found %s \n",line_no,yytext);
						error_no++;
					}	
			
			
({LETTER}|[_])({LETTER}|{DIGIT}|[_])* {
                SymbolInfo *s= new SymbolInfo(yytext,"ID");
                yylval=(YYSTYPE)s;
				return ID;
                //fprintf(tokenout,"<ID,%s>",yytext);
				//fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found.\n",line_no,yytext);
				//st.insert(yytext,"ID");
			}
			
{DIGIT}+({DIGIT}|{LETTER}|[_])* {
                 //fprintf(logout,"Error at Line no %d: INVALID IDENTIFIER %s found.\n",line_no,yytext);
                 error_no++;
                 }

\"([^\"\n]|{NEWLINE}*)*\"  {
                //fprintf(logout,"String at Line no %d: %s found.\n",line_no,yytext);
                //fprintf(tokenout,"<STRING,%s>",yytext);
                }
                 
\"([^\"\n]|(\\{NEWLINE}))*  {
                //fprintf(logout,"Error at Line no %d: Unfinished string: %s found.\n", line_no, yytext);
                error_no++;
               }                 
                                  
"//".*  {
               //fprintf(logout,"Single Line Comment at Line no %d: %s found.\n",line_no,yytext);
              }

"/*"([^*]|\*+[^*/])*\*+"/"  {
                  //fprintf(logout,"Multiple Line Comment at Line no %d: %s found.\n",line_no,yytext);
                  

}
"/*"([^*]|("*"[^/]))*[^"*/"]   {
								//pair<string,int> modify=ModifyString(yytext,line_count);
								//fprintf(logout,"Error at Line No.%d:  Unfinished Comment %s \n",line_no,yytext);
								//line_count=modify.second;
								error_no++;

					}

           
.          {
             //fprintf(logout,"Error at Line no %d: Unrecogniged character %s .\n", line_no, yytext);
             error_no++;
          }


%%

/*int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	//tokenout.open ("1605098_token.txt");
    //logout.open ("1605098_log.txt");
	//logout= fopen("1605098_log.txt","w");
	//tokenout= fopen("1605098_token.txt","w");

	yyin= fin;
	yylex();
	//fprintf(logout,"\nTotal Lines : %d.\nTotal Errors : %d.\n",line_no,error_no);
	fclose(yyin);
	//tokenout.close();
	//logout.close();
	//fclose(tokenout);
	//fclose(logout);
	return 0;
}
*/
