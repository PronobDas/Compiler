%{
#include<iostream>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include "1605098_SymbolTable.h"
#define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;
FILE *fp;
FILE *log1 = fopen("log1.txt","w");;

int line_no=1;
int error_no=0;

SymbolTable *table = new SymbolTable(100);


void yyerror(char *s)
{
	//write your code
}


%}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE
%token DEFAULT CONTINUE PRINTLN  INCOP DECOP RELOP ASSIGNOP %token LOGICOP BITOPOP NOT LPAREN RPAREN LCURL RCURL RTHIRD LTHIRD COMMA 
%token SEMICOLON CONST_INT CONST_FLOAT CONST_CHAR ID

%left  ADDOP MULOP
//%right

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

//%start func_definition;
%%

start : program
	{
		//write your code in this block in all the similar blocks below
	}
	;

program : program unit {
    $$=new SymbolInfo($1->getName()+$2->getName(),"");
    //$$->setName(());
    fprintf(log1,"Line at %d rule : program-->program unit found.  ",line_no);
    fprintf(log1,"\n%s \n%s \n\n",$1->getName().c_str(),$2->getName().c_str());
    }
	| unit  {
	
	$$=new SymbolInfo($1->getName(),"");
    //$$->setName($1->getName());
    fprintf(log1,"Line at %d rule : program-->unit found.  ",line_no);
    fprintf(log1,"\n%s \n\n",$1->getName().c_str());
	
	}
	;
	
unit : var_declaration   {
      $$=new SymbolInfo($1->getName(),"");
      //$$->setName($1->getName());
      fprintf(log1,"Line at %d rule : unit-->var_declaration found.  ",line_no);
      fprintf(log1,"%s \n\n",$1->getName().c_str());


      }
      
     | func_declaration   {
      $$=new SymbolInfo($1->getName(),"");
      //$$->setName($1->getName());
      fprintf(log1,"Line at %d rule : unit-->func_declaration found.  ",line_no);
      fprintf(log1,"%s \n\n",$1->getName().c_str());
     }
     
     | func_definition   {
      $$=new SymbolInfo($1->getName(),"");
      //$$->setName($1->getName());
      fprintf(log1,"Line at %d rule : unit-->func_definition found.  ",line_no);
      fprintf(log1,"\n%s \n\n",$1->getName().c_str());
     }
     ;
     
func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON   {
          $$=new SymbolInfo($1->getName()+" "+$2->getName()+"("+$4->getName()+");", "");
         // $$->setName($1->getName()+$2->getName()+"("+$4->getName()+")"+";");
          fprintf(log1,"Line at %d rule : func_declaration-->type_specifier ID LPAREN parameter_list RPAREN SEMICOLON found.  ",line_no);
          fprintf(log1,"%s %s(%s);\n\n",$1->getName().c_str(),$2->getName().c_str(),$4->getName().c_str());


         }
		| type_specifier ID LPAREN RPAREN SEMICOLON  {
		  $$=new SymbolInfo($1->getName()+" "+$2->getName()+"();" , "");
          //$$->setName($1->getName()+$2->getName()+"("+")"+";");
          fprintf(log1,"Line at %d rule : func_declaration-->type_specifier ID LPAREN RPAREN SEMICOLON  found.  ",line_no);
          fprintf(log1,"%s %s();\n\n",$1->getName().c_str(),$2->getName().c_str());
		
		}
		;
		 
func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement    {
          $$=new SymbolInfo($1->getName()+" "+$2->getName()+"("+$4->getName()+")\n"+$6->getName(), "");
          //$$->setName($1->getName()+$2->getName()+"("+$4->getName()+")"+$6->getName());
          fprintf(log1,"Line at %d rule : func_definition-->type_specifier ID LPAREN parameter_list RPAREN compound_statement found.  ",line_no);
          fprintf(log1,"\n%s %s(%s)\n%s \n\n",$1->getName().c_str(),$2->getName().c_str(),$4->getName().c_str(),$6->getName().c_str());

        }
		| type_specifier ID LPAREN RPAREN compound_statement   {
		  $$=new SymbolInfo($1->getName()+" "+$2->getName()+"("+")"+$5->getName() , "");
         // $$->setName($1->getName()+$2->getName()+"("+")"+$5->getName());
          fprintf(log1,"Line at %d rule : func_definition-->type_specifier ID LPAREN RPAREN compound_statement  found.  ",line_no);
          fprintf(log1,"\n%s %s() \n%s \n\n",$1->getName().c_str(),$2->getName().c_str(),$5->getName().c_str());
		
		}
 		;				


parameter_list  : parameter_list COMMA type_specifier ID  {
         $$ = new SymbolInfo($1->getName()+","+$3->getName()+" "+$4->getName() , "");
        // $$->setName($1->getName()+","+$3->getName()+$4->getName());
         fprintf(log1,"Line at %d rule : parameter_list-->parameter_list COMMA type_specifier ID  found.  ",line_no);
         fprintf(log1,"%s,%s %s \n\n",$1->getName().c_str(),$3->getName().c_str(),$4->getName().c_str());

        }
		| parameter_list COMMA type_specifier  {
		 $$ = new SymbolInfo($1->getName()+","+$3->getName(), "");
         //$$->setName($1->getName()+","+$3->getName());
         fprintf(log1,"Line at %d rule : parameter_list-->parameter_list COMMA type_specifier  found.  ",line_no);
         fprintf(log1,"%s,%s \n\n",$1->getName().c_str(),$3->getName().c_str());
		
		}
 		| type_specifier ID   {
 		 $$ = new SymbolInfo($1->getName()+" "+$2->getName(), "");
         //$$->setName($1->getName()+$2->getName());
         fprintf(log1,"Line at %d rule : parameter_list-->type_specifier ID  found.  ",line_no);
         fprintf(log1,"%s %s \n\n",$1->getName().c_str(),$2->getName().c_str());
 		
 		}
		| type_specifier   {
		 $$ = new SymbolInfo($1->getName()+" ", "");
         //$$->setName($1->getName());
         fprintf(log1,"Line at %d rule : parameter_list-->type_specifier  found.  ",line_no);
         fprintf(log1,"%s \n\n",$1->getName().c_str());
		
		}
 		;

 		
compound_statement : LCURL statements RCURL  {
         $$ = new SymbolInfo("{\n"+$2->getName()+"\n}" , "");
         //$$->setName("{"+$2->getName()+"}");
         fprintf(log1,"Line at %d rule : compound_statement-->LCURL statements RCURL  found.  ",line_no);
         fprintf(log1,"\n{\n%s\n} \n\n",$2->getName().c_str());
         }
 		    | LCURL RCURL   {
 		    $$ = new SymbolInfo("{}", "");
            //$$->setName("{}");
            fprintf(log1,"Line at %d rule : compound_statement-->LCURL RCURL  found.  ",line_no);
            fprintf(log1,"{} \n\n");
 		    }
 		    ;
 		    
var_declaration : type_specifier declaration_list SEMICOLON
         {
         $$ = new SymbolInfo($1->getName()+" "+$2->getName()+";","");
         fprintf(log1,"Line at %d rule : var_declaration-->type_specifier declaration_list SEMICOLON   found.  ",line_no);
         fprintf(log1,"%s %s; \n\n", $1->getName().c_str(),$2->getName().c_str());
         }
 		 ;
 		 
type_specifier	: INT  {
         $$ = new SymbolInfo("int","");
         fprintf(log1,"Line at %d rule : type_specifier-->INT   found.  ",line_no);
         fprintf(log1,"%s \n\n", $1->getName().c_str());
        } 
        
 		| FLOAT  {
         $$ = new SymbolInfo("float","");
         fprintf(log1,"Line at %d rule : type_specifier-->FLOAT   found.  ",line_no);
         fprintf(log1,"%s \n\n", $1->getName().c_str());
        }
        
 		| VOID   {
         $$ = new SymbolInfo("void","");
         fprintf(log1,"Line at %d rule : type_specifier-->VOID   found.  ",line_no);
         fprintf(log1,"%s \n\n", $1->getName().c_str());
        }
 		;
 		
declaration_list : declaration_list COMMA ID
           {
           $$ = new SymbolInfo($1->getName()+","+$3->getName(), "");
           fprintf(log1,"Line at %d rule : declaration_list-->declaration_list COMMA ID   found.  ",line_no);
           fprintf(log1,"%s,%s \n\n", $1->getName().c_str(),$3->getName().c_str());
           }
           
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
 		  {
 		  $$ = new SymbolInfo($1->getName()+","+$3->getName()+"["+$5->getName()+"]", "");
          fprintf(log1,"Line at %d rule : declaration_list-->declaration_list COMMA ID LTHIRD CONST_INT RTHIRD   found.  ",line_no);
          fprintf(log1,"%s,%s[%s] \n\n", $1->getName().c_str(),$3->getName().c_str(),$5->getName().c_str());
 		  }
 		  
 		  | ID
 		  {
 		  $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : declaration_list-->ID   found.  ",line_no);
          fprintf(log1,"%s; \n\n", $1->getName().c_str());
 		  }
 		  
 		  | ID LTHIRD CONST_INT RTHIRD
 		  {
 		  $$ = new SymbolInfo($1->getName()+"["+$3->getName()+"]", "");
          fprintf(log1,"Line at %d rule : declaration_list-->ID LTHIRD CONST_INT RTHIRD   found.  ",line_no);
          fprintf(log1,"%s[%s]; \n\n", $1->getName().c_str(),$3->getName().c_str());
 		  }
 		  ;
 		  
statements : statement
          {
          $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : statements-->statement   found.  ",line_no);
          fprintf(log1,"%s \n\n", $1->getName().c_str());
          
          }
          
	   | statements statement
	    {
	      $$ = new SymbolInfo($1->getName()+"\n"+$2->getName(), "");
          fprintf(log1,"Line at %d rule : statements-->statements statement   found.  ",line_no);
          fprintf(log1,"%s %s \n\n", $1->getName().c_str(),$2->getName().c_str());
	    }
	   ;
	   
statement : var_declaration {
          $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->var_declaration   found.  ",line_no);
          fprintf(log1,"%s \n\n", $1->getName().c_str());
      }
      
	  | expression_statement {
	      $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->expression_statement   found.  ",line_no);
          fprintf(log1,"%s \n\n", $1->getName().c_str());
	  
	  }
	  
	  | compound_statement {
    	  $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->compound_statement   found.  ",line_no);
          fprintf(log1,"%s \n\n", $1->getName().c_str());
	  
	  }
	  
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement {
	      $$ = new SymbolInfo("for("+$3->getName()+$4->getName()+$5->getName()+")\n"+$6->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->FOR LPAREN expression_statement expression_statement expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"for(%s %s %s) %s \n\n", $3->getName().c_str(),$4->getName().c_str(),$5->getName().c_str(),$6->getName().c_str());
	  }
	  
	  | IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
	  {
	      $$ = new SymbolInfo("if("+$3->getName()+")\n"+$5->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->IF LPAREN expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"if(%s) %s \n\n", $3->getName().c_str(),$5->getName().c_str());
	  
	  }
	  
	  | IF LPAREN expression RPAREN statement ELSE statement
	  {
	      $$ = new SymbolInfo("if("+$3->getName()+")\n"+$5->getName()+"else\n"+$7->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->IF LPAREN expression RPAREN statement  ELSE statement   found.  ",line_no);
          fprintf(log1,"if(%s) %s else %s \n\n", $3->getName().c_str(),$5->getName().c_str(),$7->getName().c_str());
	  
	  }
	  
	  | WHILE LPAREN expression RPAREN statement
	  {
	      $$ = new SymbolInfo("while("+$3->getName()+")\n"+$5->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->WHILE LPAREN expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"while(%s) %s \n\n", $3->getName().c_str(),$5->getName().c_str());
	  }
	  
	  | PRINTLN LPAREN ID RPAREN SEMICOLON
	  {
	      $$ = new SymbolInfo("\n("+$3->getName()+");", "");
          fprintf(log1,"Line at %d rule : statement-->PRINTLN LPAREN ID RPAREN SEMICOLON   found.  ",line_no);
          fprintf(log1,"\n(%s); \n\n", $3->getName().c_str());
	  }
	  
	  | RETURN expression SEMICOLON
	  {
	      $$ = new SymbolInfo("return "+$2->getName()+";", "");
          fprintf(log1,"Line at %d rule : statement-->RETURN expression SEMICOLON   found.  ",line_no);
          fprintf(log1,"return %s; \n\n", $2->getName().c_str());
	  }
	  ;
	  
expression_statement 	: SEMICOLON	
            {
            $$ = new SymbolInfo(";", "");
            fprintf(log1,"Line at %d rule : expression_statement-->SEMICOLON   found.  ",line_no);
            fprintf(log1,"; \n\n");
            }
            
			| expression SEMICOLON 
			{
			$$ = new SymbolInfo($1->getName()+";", "");
            fprintf(log1,"Line at %d rule : expression_statement-->expression SEMICOLON   found.  ",line_no);
            fprintf(log1,"%s; \n\n", $1->getName().c_str());
			}
			;
	  
variable : ID  {
                $$=new SymbolInfo($1->getName(),"");
                //$$->setName($1->getName());
                fprintf(log1,"Line at %d rule : variable-->ID  found.   ",line_no);
                fprintf(log1,"%s \n\n",$1->getName().c_str());
               }
	 | ID LTHIRD expression RTHIRD 
	           {
	            $$=new SymbolInfo($1->getName()+"["+$3->getName()+"]","");
                //$$->setName($1->getName());
                fprintf(log1,"Line at %d rule : variable-->ID LTHIRD expression RTHIRD  found.   ",line_no);
                fprintf(log1,"%s[%s] \n\n",$1->getName().c_str(),$3->getName().c_str());
	           
	           }
	 ;
	 
 expression : logic_expression	
               {
                $$=new SymbolInfo($1->getName() ,"");
                fprintf(log1,"Line at %d rule :  expression-->logic_expression  found.   ",line_no);
                fprintf(log1,"%s \n\n",$1->getName().c_str());
               
               }
	   | variable ASSIGNOP logic_expression  
	   {
	    $$=new SymbolInfo($1->getName() +"="+$3->getName() ,"");
        fprintf(log1,"Line at %d rule :  expression-->variable ASSIGNOP logic_expression  found.   ",line_no);
        fprintf(log1,"%s = %s \n\n",$1->getName().c_str(),$3->getName().c_str());
	   
	   
	   }	
	   ;
			
logic_expression : rel_expression 
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  logic_expression-->rel_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          }
          
		 | rel_expression LOGICOP rel_expression 
		 {
		 $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
         fprintf(log1,"Line at %d rule :  logic_expression-->rel_expression LOGICOP rel_expression  found.   ",line_no);
         fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
		 }
		 ;
			
rel_expression	: simple_expression 
        {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  rel_expression-->simple_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
        }
        
		| simple_expression RELOP simple_expression	
		{
         $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
         fprintf(log1,"Line at %d rule : rel_expression-->simple_expression RELOP simple_expression  found.   ",line_no);
         fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
		}
		;
				
simple_expression : term 
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  simple_expression-->term  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          }
          
		  | simple_expression ADDOP term
		  {
		  $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
          fprintf(log1,"Line at %d rule : simple_expression-->simple_expression ADDOP term  found.   ",line_no);
          fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
		  }
		  ;
					
term :	unary_expression
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  term-->unary_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          }
          
     |  term MULOP unary_expression
        {
          $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
          fprintf(log1,"Line at %d rule : term-->term MULOP unary_expression  found.   ",line_no);
          fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
        }
     ;

unary_expression : ADDOP unary_expression  
         {
          $$=new SymbolInfo($1->getName()+$2->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->ADDOP unary_expression  found.   ",line_no);
          fprintf(log1,"%s %s\n\n",$1->getName().c_str(),$2->getName().c_str());
         }
         
		 | NOT unary_expression
		 {
		  $$=new SymbolInfo("!"+$2->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->NOT unary_expression  found.   ",line_no);
          fprintf(log1,"!%s \n\n",$2->getName().c_str());
		 }
		 
		 | factor 
		 {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->factor  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
		 }
		 ;
	
factor	: variable 
         {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  factor-->variable  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
         }
         
	| ID LPAREN argument_list RPAREN
	  {
       $$=new SymbolInfo($1->getName()+"("+$3->getName()+")" ,"");
       fprintf(log1,"Line at %d rule :  factor-->ID LPAREN argument_list RPAREN  found.   ",line_no);
       fprintf(log1,"%s (%s) \n\n",$1->getName().c_str(),$3->getName().c_str());	  
	  }
	  
	| LPAREN expression RPAREN
	  {
       $$=new SymbolInfo("("+$2->getName()+")" ,"");
       fprintf(log1,"Line at %d rule :  factor-->LPAREN expression RPAREN  found.   ",line_no);
       fprintf(log1,"(%s) \n\n",$2->getName().c_str());
	  }
	
	| CONST_INT 
     {
     $$=new SymbolInfo($1->getName() ,"");
     fprintf(log1,"Line at %d rule :  factor-->CONST_INT  found.   ",line_no);
     fprintf(log1,"%s \n\n",$1->getName().c_str());
     }
     
	| CONST_FLOAT
	{
     $$=new SymbolInfo($1->getName() ,"");
     fprintf(log1,"Line at %d rule :  factor-->CONST_FLOAT  found.   ",line_no);
     fprintf(log1,"%s \n\n",$1->getName().c_str());
     }
     
	| variable INCOP 
	{
	 $$=new SymbolInfo($1->getName()+"++" ,"");
     fprintf(log1,"Line at %d rule :  factor-->variable INCOP  found.   ",line_no);
     fprintf(log1,"%s++ \n\n",$1->getName().c_str());
	}
	
	| variable DECOP
	{
	 $$=new SymbolInfo($1->getName()+"--" ,"");
     fprintf(log1,"Line at %d rule :  factor-->variable DECOP  found.   ",line_no);
     fprintf(log1,"%s-- \n\n",$1->getName().c_str());
	}
	;
	
argument_list : arguments 
       {
       $$=new SymbolInfo($1->getName() ,"");
       fprintf(log1,"Line at %d rule :  argument_list-->arguments  found.   ",line_no);
       fprintf(log1,"%s \n\n",$1->getName().c_str());
       }
       
			  |
			  {
			  $$=new SymbolInfo("","");
              fprintf(log1,"Line at %d rule :  argument_list-->  found.   \n\n",line_no);
			  }
			  ;
	
arguments : arguments COMMA logic_expression 
            {
            $$=new SymbolInfo($1->getName()+","+$3->getName() ,"");
            fprintf(log1,"Line at %d rule :  arguments-->arguments COMMA logic_expression  found.   ",line_no);
            fprintf(log1,"%s,%s \n\n",$1->getName().c_str(),$3->getName().c_str());
            }
            
	      | logic_expression
	        {
            $$=new SymbolInfo($1->getName() ,"");
            fprintf(log1,"Line at %d rule :  arguments-->logic_expression  found.   ",line_no);
            fprintf(log1,"%s \n\n",$1->getName().c_str());
	        }
	      ;
 

%%
int main(int argc,char *argv[])
{
	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	//log1 =  fopen(argv[2],"w");
	
	/*fp2= fopen(argv[2],"w");
	fclose(fp2);
	fp3= fopen(argv[3],"w");
	fclose(fp3);
	
	fp2= fopen(argv[2],"a");
	fp3= fopen(argv[3],"a");
	*/

	yyin=fp;
	yyparse();
	fclose(log1);

	//fclose(fp2);
	//fclose(fp3);
	
	return 0;
}

 
