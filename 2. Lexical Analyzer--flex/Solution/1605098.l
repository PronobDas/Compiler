%option noyywrap

%{
//#include<stdio.h>
//#include<fstream>
//#include<cstdlib>
//#include<iostream>

#include<stdio.h>
#include<stdlib.h>

#include "1605098_SymbolTable.h"

int line_no=1;
int error_no=0;
//extern "C" int yylex();
//ofstream tokenout;
//ofstream logout;
//tokenout.open ("1605098_token.txt");
//logout.open ("1605098_log.txt");
FILE * tokenout ;
FILE * logout ;

//SymbolTable st(40, logout);


%}

WHITESPACE [ \t\f\r\v]+ 
LETTER [a-zA-Z]
DIGIT [0-9]
NEWLINE \n
CHAR [ -~]{-}['\\]

%%
{WHITESPACE}   {}

{NEWLINE}  { line_no++; }


"if"	{
printf("IF");
			fprintf(tokenout , "<IF>");
			fprintf(logout , "Line no  %d : TOKEN <IF> Lexeme  %s  found.\n",line_no,yytext);
		}
		
"else"	{
			fprintf(tokenout , "<ELSE>");
			fprintf(logout , "Line no  %d : TOKEN <ELSE> Lexeme  %s  found.\n",line_no,yytext);
		}
		
"for"	{
			fprintf(tokenout , "<FOR>");
			fprintf(logout , "Line no %d: TOKEN <FOR> Lexeme %s found.\n",line_no,yytext);
		}
		
"while"	{
			fprintf(tokenout , "<WHILE>");
			fprintf(logout , "Line no %d: TOKEN <WHILE> Lexeme %s found.\n",line_no,yytext);
		}
		
"do"	{
			fprintf(tokenout , "<DO>");
			fprintf(logout , "Line no %d: TOKEN <DO> Lexeme %s found.\n",line_no,yytext);
		}
		
"break"	{
			fprintf(tokenout , "<BREAK>");
			fprintf(logout , "Line no %d: TOKEN <BREAK> Lexeme %s found.\n",line_no,yytext);
		}
		
"int"	{
           // ofstream tmpfile;
            //tmpfile.open ("1605098_log.txt");
            //tmpfile << "Writing this to a file.\n";
			fprintf(tokenout , "<INT>");
			fprintf(logout , "Line no %d: TOKEN <INT> Lexeme %s found.\n",line_no,yytext);
		}
		
"char"	{
			fprintf(tokenout , "<CHAR>");
			fprintf(logout , "Line no %d: TOKEN <CHAR> Lexeme %s found.\n",line_no,yytext);
		}		
		
"float"	{
			fprintf(tokenout , "<FLOAT>");
			fprintf(logout , "Line no %d: TOKEN <FLOAT> Lexeme %s found.\n",line_no,yytext);
		}
		
"double"	{
			fprintf(tokenout , "<DOUBLE>");
			fprintf(logout , "Line no %d: TOKEN <DOUBLE> Lexeme %s found.\n",line_no,yytext);
		}
		
"void"	{
			fprintf(tokenout , "<VOID>");
			fprintf(logout , "Line no %d: TOKEN <VOID> Lexeme %s found.\n",line_no,yytext);
		}		
		
"return"	{
			fprintf(tokenout , "<RETURN>");
			fprintf(logout , "Line no %d: TOKEN <RETURN> Lexeme %s found.\n",line_no,yytext);
		}
		
"switch"	{
			fprintf(tokenout , "<SWITCH>");
			fprintf(logout , "Line no %d: TOKEN <SWITCH> Lexeme %s found.\n",line_no,yytext);
		}		
		
"case"	{
			fprintf(tokenout , "<CASE>");
			fprintf(logout , "Line no %d: TOKEN <CASE> Lexeme %s found.\n",line_no,yytext);
		}
		
"default"	{
			fprintf(tokenout , "<DEFAULT>");
			fprintf(logout, "Line no %d: TOKEN <DEFAULT> Lexeme %s found.\n",line_no,yytext);
		}		
		
"continue"	{
			fprintf(tokenout , "<CONTINUE>");
			fprintf(logout , "Line no %d: TOKEN <CONTINUE> Lexeme %s found.\n",line_no,yytext);
		}
		


"+"|"-"	{
			fprintf(tokenout,"<ADDOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"ADDOP");
		    }

"*"|"/"|"%"  {
            fprintf(tokenout,"<MULOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"MULOP");
         }
         
"++"|"--" {
            fprintf(tokenout,"<INCOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"INCOP");
         
         }
         
"<"|"<="|">"|">="|"=="|"!="  {
            fprintf(tokenout,"<RELOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RELOP");
         }
				
"="      {
            fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"ASSIGNOP");
         }		
		
"&&"|"||"  {
            fprintf(tokenout,"<LOGICOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found.\n",line_no,yytext);
			//st.insert(yytext,"LOGICOP");
         }		

"&"|"|"|"^"|"<<"|">>"  {
            fprintf(tokenout,"<BITOPOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <BITOPOP> Lexeme %s found.\n",line_no,yytext); 
			//st.insert(yytext,"BITOPOP");
         }
         
"!"      {
            fprintf(tokenout,"<NOT,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <NOT> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"NOT");
         }
         
"("      {
            fprintf(tokenout,"<LPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LPAREN> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LPAREN");
         }  
         
")"      {
            fprintf(tokenout,"<RPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RPAREN> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RPAREN");
         }           

"{"      {
            fprintf(tokenout,"<LCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LCURL> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LCURL");
         } 
         
"}"      {
            fprintf(tokenout,"<RCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RCURL> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RCURL");
         }
         
"["      {
            fprintf(tokenout,"<LTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LTHIRD> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"LTHIRD");
         }

"]"      {
            fprintf(tokenout,"<RTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RTHIRD> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"RTHIRD");
         }
         
","      {
            fprintf(tokenout,"<COMMA,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"COMMA");
         }
         
";"      {
            fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found.\n",line_no,yytext);
            //st.insert(yytext,"SEMICOLON");
         }   


{DIGIT}+ 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found.\n",line_no,yytext);
				//st.insert(yytext,"CONST_INT");
			}

{DIGIT}*\.{DIGIT}*([eE]?[-+]?{DIGIT}+)$ 	{
				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found.\n",line_no,yytext);				
				//st.insert(yytext,"CONST_FLOAT");
				
			}
			
\'({CHAR}|\\['"?\\abfnrtv])\'			{
							fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
							fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found.\n",line_no,yytext);
							//st.insert(yytext,"CONST_CHAR");			
            }
			
			
({LETTER}|[_])({LETTER}|{DIGIT}|[_])* {
                fprintf(tokenout,"<ID,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found.\n",line_no,yytext);
				//st.insert(yytext,"ID");
			}
			
{DIGIT}+({DIGIT}|{LETTER}|[_])* {
                 fprintf(logout,"Error at Line no %d: INVALID IDENTIFIER %s found.\n",line_no,yytext);
                 error_no++;
                 }

\"([^\"\n]|{NEWLINE}*)*\"  {
                fprintf(logout,"String at Line no %d: %s found.\n",line_no,yytext);
                fprintf(tokenout,"<STRING,%s>",yytext);
                }
                 
\"([^\"\n]|(\\{NEWLINE}))*  {
                fprintf(logout,"Error at Line no %d: Unfinished string: %s found.\n", line_no, yytext);
                error_no++;
               }                 
                                  
"//"{CHAR}+$  {
               fprintf(logout,"Single Line Comment at Line no %d: %s found.\n",line_no,yytext);
              }
 "/*"([^*]|("*"[^/]))*"*/"
 "/*"([^*]|("*"[^/]))*[^"*/"]
"/*"([^*]|\*+[^*/])*\*+"/"  {
                  fprintf(logout,"Multiple Line Comment at Line no %d: %s found.\n",line_no,yytext);
           
//"/*"([^*]|\*+[^*/])*[^\*+"/"]  {  }          

}

\'({CHAR}|[\\])*[^'\n]?				{
						
							fprintf(logout,"Error at Line No.%d: Unfinished Character Sequence found %s \n",line_no,yytext);
							error_no++;
						}
           
           
           
.          {
             fprintf(logout,"Error at Line no %d: Unrecogniged character %s .\n", line_no, yytext);
             error_no++;
          }




			
			
         
         
%%

int main(int argc,char *argv[]){
	
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
	logout= fopen("1605098_log.txt","w");
	tokenout= fopen("1605098_token.txt","w");

	yyin= fin;
	yylex();
	fprintf(logout,"\nTotal Lines : %d.\nTotal Errors : %d.\n",line_no,error_no);
	fclose(yyin);
	//tokenout.close();
	//logout.close();
	fclose(tokenout);
	fclose(logout);
	return 0;
}
