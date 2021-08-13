%{
#include<iostream>
#include<cstdlib>
#include<cstring>
#include<vector>
#include<sstream>
#include<cmath>
#include<cstdio>
#include<fstream>
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

vector<string> varDec;
vector<pair<string,string>> arrayDec;

int labelCount=0;
int tempCount=0;

string IntToString (int s)
{
    ostringstream t;
    t<<s;
    return t.str();
}

char *newLabel()
{
	char *lb= new char[4];
	strcpy(lb,"L");
	char b[3];
	sprintf(b,"%d", labelCount);
	labelCount++;
	strcat(lb,b);
	return lb;
}

char *newTemp()
{
	char *t= new char[4];
	strcpy(t,"t");
	char b[3];
	sprintf(b,"%d", tempCount);
	tempCount++;
	strcat(t,b);
	return t;
}

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
//%start factor
%%

start : compound_statement //program
	{
	ofstream fout;
	fout.open("code.asm");
	fout << $1->getCode(); 
		
	}
	;

/*program : program unit {
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
*/
 		
compound_statement : LCURL statements RCURL  {
         $$ = new SymbolInfo("{\n"+$2->getName()+"\n}" , "");
         //$$->setName("{"+$2->getName()+"}");
         fprintf(log1,"Line at %d rule : compound_statement-->LCURL statements RCURL  found.  ",line_no);
         fprintf(log1,"\n{\n%s\n} \n\n",$2->getName().c_str());
         
         $$->setCode($2->getCode());
         $$->setId($2->getId());
         
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
          
          $$->setCode($1->getCode());
          
          }
          
	   | statements statement
	    {
	      $$ = new SymbolInfo($1->getName()+"\n"+$2->getName(), "");
          fprintf(log1,"Line at %d rule : statements-->statements statement   found.  ",line_no);
          fprintf(log1,"%s %s \n\n", $1->getName().c_str(),$2->getName().c_str());
          
          $$->setCode($1->getCode()+$2->getCode());
          
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
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
	  
	  }
	  
	  | compound_statement {
    	  $$ = new SymbolInfo($1->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->compound_statement   found.  ",line_no);
          fprintf(log1,"%s \n\n", $1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
	  
	  }
	  
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement {
	      $$ = new SymbolInfo("for("+$3->getName()+$4->getName()+$5->getName()+")\n"+$6->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->FOR LPAREN expression_statement expression_statement expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"for(%s %s %s) %s \n\n", $3->getName().c_str(),$4->getName().c_str(),$5->getName().c_str(),$6->getName().c_str());
          
          
          string c =$3->getCode();
		  char *label1=newLabel();
		  char *label2=newLabel();
		  c +=string(label1)+":\n";
		  c +=$4->getCode();
		  c +="\tMOV AX,"+$4->getId()+"\n";
		  c +="\tCMP AX,0\n";
		  c +="\tJE "+string(label2)+"\n";
		  c +=$7->getCode();
		  c +=$5->getCode();
		  c +="\tJMP "+string(label1)+"\n";
		  c +=string(label2)+":\n";
		  $$->setCode(c);
          
	  }
	  
	  | IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
	  {
	      $$ = new SymbolInfo("if("+$3->getName()+")\n"+$5->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->IF LPAREN expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"if(%s) %s \n\n", $3->getName().c_str(),$5->getName().c_str());
          
          string c =$3->getCode();
		  char *label1=newLabel();
		  c +="\tMOV AX,"+$3->getId()+"\n";
          c +="\tCMP AX,0\n";
		  c +="\tJE "+string(label1)+"\n";
		  c +=$5->getCode();
		  c +=string(label1)+":\n";
		  $$->setCode(c);
	  
	  }
	  
	  | IF LPAREN expression RPAREN statement ELSE statement
	  {
	      $$ = new SymbolInfo("if("+$3->getName()+")\n"+$5->getName()+"else\n"+$7->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->IF LPAREN expression RPAREN statement  ELSE statement   found.  ",line_no);
          fprintf(log1,"if(%s) %s else %s \n\n", $3->getName().c_str(),$5->getName().c_str(),$7->getName().c_str());
          
          string c =$3->getCode();
		  char *label1=newLabel();
		  char *label2=newLabel();
		  c +="\tMOV AX,"+$3->getId()+"\n";
		  c +="\tCMP AX,0\n";
		  c +="\tJE "+string(label1)+"\n";
		  c +=$5->getCode();
		  c +="\tJMP "+string(label2)+"\n";
		  c +=string(label1)+":\n";
		  c +=$7->getCode();
		  c +=string(label2)+":\n";
		  $$->setCode(c);
	  
	  }
	  
	  | WHILE LPAREN expression RPAREN statement
	  {
	      $$ = new SymbolInfo("while("+$3->getName()+")\n"+$5->getName(), "");
          fprintf(log1,"Line at %d rule : statement-->WHILE LPAREN expression RPAREN statement   found.  ",line_no);
          fprintf(log1,"while(%s) %s \n\n", $3->getName().c_str(),$5->getName().c_str());
          
          string c ="";
		  char *label1=newLabel();
		  char *label2=newLabel();
		  c +=string(label1)+":\n";
		  c +=$3->getCode();
		  c +="\tMOV AX,"+$3->getId()+"\n";
		  c +="\tCMP AX,0\n";
		  c +="\tJE "+string(label2)+"\n";
		  c +=$5->getCode();
		  c +="\tJMP "+string(label1)+"\n";
		  c +=string(label2)+":\n";
          
          $$->setCode(c);
	  }
	  
	  | PRINTLN LPAREN ID RPAREN SEMICOLON
	  {
	      $$ = new SymbolInfo("\n("+$3->getName()+");", "");
          fprintf(log1,"Line at %d rule : statement-->PRINTLN LPAREN ID RPAREN SEMICOLON   found.  ",line_no);
          fprintf(log1,"\n(%s); \n\n", $3->getName().c_str());
          
          string c ="\tMOV AX,"+$3->getName(); // +IntToString(table->lookupscopeid($3->getName()));
          //c +="\n\tCALL OUTDEC\n";
          
          $$->setCode(c);
          
	  }
	  
	  | RETURN expression SEMICOLON
	  {
	      $$ = new SymbolInfo("return "+$2->getName()+";", "");
          fprintf(log1,"Line at %d rule : statement-->RETURN expression SEMICOLON   found.  ",line_no);
          fprintf(log1,"return %s; \n\n", $2->getName().c_str());
          
          string c = $2->getCode();
		  c +="\tMOV AX,"+$2->getId()+"\n";
          //c +="\tMOV "+"_return,AX\n";
         // c +="\tJMP LReturn"+"\n";
          $$->setCode(c);
	  }
	  ;
	  
expression_statement 	: SEMICOLON	
            {
            $$ = new SymbolInfo(";", "");
            fprintf(log1,"Line at %d rule : expression_statement-->SEMICOLON   found.  ",line_no);
            fprintf(log1,"; \n\n");
            
            $$->setCode("");
            }
            
			| expression SEMICOLON 
			{
			$$ = new SymbolInfo($1->getName()+";", "");
            fprintf(log1,"Line at %d rule : expression_statement-->expression SEMICOLON   found.  ",line_no);
            fprintf(log1,"%s; \n\n", $1->getName().c_str());
            
            $$->setCode($1->getCode());
            $$->setId($1->getId());
			}
			;
	  
variable : ID  {
                $$=new SymbolInfo($1->getName(),"notarray");
                
                fprintf(log1,"Line at %d rule : variable-->ID  found.   ",line_no);
                fprintf(log1,"%s \n\n",$1->getName().c_str());
                
                $$->setCode("");
                //$$->setId($1->getName()+IntToString(table->lookupscopeid($1->getName())));
                
               }
	 | ID LTHIRD expression RTHIRD 
	           {
	            $$=new SymbolInfo($1->getName()+"["+$3->getName()+"]","array");
                //$$->setName($1->getName());
                fprintf(log1,"Line at %d rule : variable-->ID LTHIRD expression RTHIRD  found.   ",line_no);
                fprintf(log1,"%s[%s] \n\n",$1->getName().c_str(),$3->getName().c_str());
                
                //$$= new SymbolInfo($1);
				//$$->setType("array");
				$$->setCode($3->getCode()+"MOV BX, " +$3->getId() +"\nADD BX, BX\n");
	           
	           }
	 ;
	 
 expression : logic_expression	
               {
                $$=new SymbolInfo($1->getName() ,"");
                fprintf(log1,"Line at %d rule :  expression-->logic_expression  found.   ",line_no);
                fprintf(log1,"%s \n\n",$1->getName().c_str());
                
                $$->setCode($1->getCode());
                $$->setId($1->getId());
               
               }
	   | variable ASSIGNOP logic_expression  
	   {
	    $$=new SymbolInfo($1->getName() +"="+$3->getName() ,"");
        fprintf(log1,"Line at %d rule :  expression-->variable ASSIGNOP logic_expression  found.   ",line_no);
        fprintf(log1,"%s = %s \n\n",$1->getName().c_str(),$3->getName().c_str());
	   
	   
	   string c= $1->getCode();
       c +=$3->getCode();
	   c +="\tMOV AX,"+$3->getId()+"\n";
	   
	   if($1->getType()=="notarray"){
       c +="\tMOV "+$1->getId()+",AX\n";
       }
       else{
       c +="\tMOV "+$1->getId()+"[BX],AX\n";
       }
       $$->setCode(c);
       $$->setId($1->getId());	   
	   }	
	   ;
			
logic_expression : rel_expression 
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  logic_expression-->rel_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
          }
          
		 | rel_expression LOGICOP rel_expression 
		 {
		 $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
         fprintf(log1,"Line at %d rule :  logic_expression-->rel_expression LOGICOP rel_expression  found.   ",line_no);
         fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
         
         
         string c =$1->getCode();
		 c +=$3->getCode();
		 char *label1=newLabel();
		 char *label2=newLabel();
         char *label3=newLabel();
		 char *temp=newTemp();
		 
		 if($2->getName()=="||"){
		 c +="\tMOV AX,"+$1->getId()+"\n";
		 c +="\tCMP AX,0\n";
		 c +="\tJNE "+string(label2)+"\n";
         c +="\tMOV AX,"+$3->getId()+"\n";
		 c +="\tCMP AX,0\n";
		 c +="\tJNE "+string(label2)+"\n";
         c +=string(label1)+":\n";
		 c +="\tMOV "+string(temp)+",0\n";
		 c +="\tJMP "+string(label3)+"\n";
		 c +=string(label2)+":\n";
		 c +="\tMOV "+string(temp)+",1\n";
		 c +=string(label3)+":\n";
         }
         
         else{
         c +="\tMOV AX,"+$1->getId()+"\n";
		 c +="\tCMP AX,0\n";
		 c +="\tJE "+string(label2)+"\n";
		 c +="\tMOV AX,"+$3->getId()+"\n";
		 c +="\tCMP AX,0\n";
		 c +="\tJE "+string(label2)+"\n";
		 c +=string(label1)+":\n";
         c +="\tMOV "+string(temp)+",1\n";
         c +="\tJMP "+string(label3)+"\n";
         c +=string(label2)+":\n";
		 c +="\tMOV "+string(temp)+",0\n";
		 c +=string(label3)+":\n";
         
         }
         $$->setCode(c);
		 $$->setId(temp);
		 varDec.push_back(temp);         
		 }
		 ;
			
rel_expression	: simple_expression 
        {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  rel_expression-->simple_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
        }
        
		| simple_expression RELOP simple_expression	
		{
         $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
         fprintf(log1,"Line at %d rule : rel_expression-->simple_expression RELOP simple_expression  found.   ",line_no);
         fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
         
         string c=$1->getCode();
         c += $3->getCode();
         char *temp=newTemp();
		 char *label1=newLabel();
		 char *label2=newLabel();
		 c +="\tMOV AX,"+$1->getId()+"\n";
         c +="\tCMP AX,"+$3->getId()+"\n";
         
         if($2->getName()=="<"){
         c +="\tJL "+string(label1)+"\n";
         }
		 else if($2->getName()==">"){
         c +="\tJG "+string(label1)+"\n";
         }
		 else if($2->getName()=="<="){
         c +="\tJLE "+string(label1)+"\n";
         }
		 else if($2->getName()==">="){
         c +="\tJGE "+string(label1)+"\n";
         }
		 else if($2->getName()=="=="){
         c +="\tJE "+string(label1)+"\n";
    	 }
	     else if($2->getName()=="!="){
		 c +="\tJNE "+string(label1)+"\n";
         }
         
		 c +="\tMOV "+string(temp)+",0\n";
		 c +="\tJMP "+string(label2)+"\n";
		 c +=string(label1)+":\n";
		 c +="\tMOV "+string(temp)+",1\n";
		 c +=string(label2)+":\n";
		 
		 $$->setCode(c);
         $$->setId(temp);
         varDec.push_back(temp);
         
		}
		;
				
simple_expression : term 
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  simple_expression-->term  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
          }
          
		  | simple_expression ADDOP term
		  {
		  $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
          fprintf(log1,"Line at %d rule : simple_expression-->simple_expression ADDOP term  found.   ",line_no);
          fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
          
          string c=$1->getCode()+$3->getCode();

          c += "\tMOV AX,"+$1->getId()+"\n";
          char *temp=newTemp();
		  
		  if($2->getName()=="+"){
		  c +="\tADD AX,"+$3->getId()+"\n";
          }
          else{
          c +="\tSUB AX,"+$3->getId()+"\n";
          }
		  c +="\tMOV "+string(temp)+",AX\n";
          
          $$->setCode(c);
		  $$->setId(temp);
		  varDec.push_back(temp);
		  }
		  ;
					
term :	unary_expression
          {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  term-->unary_expression  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
          }
          
     |  term MULOP unary_expression
        {
          $$=new SymbolInfo($1->getName() +$2->getName()+$3->getName() ,"");
          fprintf(log1,"Line at %d rule : term-->term MULOP unary_expression  found.   ",line_no);
          fprintf(log1,"%s %s %s \n\n",$1->getName().c_str(),$2->getName().c_str(),$3->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->code += $3->code;
          $$->code += "\tMOV AX, "+ $1->getId()+"\n";
		  $$->code += "\tMOV BX, "+ $3->getId() +"\n";
		  char *temp=newTemp();
		  
		  if($2->getName() =="*"){
		  $$->code += "\tMUL BX\n";
          $$->code += "\tMOV "+ string(temp) + ", AX\n";
          
          varDec.push_back(temp);
		  }
		  
		  else if($2->getName() == "/"){
		  
		  string c=$1->getCode()+$3->getCode();
          char *temp=newTemp();
          
		  c +="\tMOV AX,"+$1->getId()+"\n";
		  c +="\tMOV BX,"+$3->getId()+"\n";
		  c +="\tDIV BX\n";
		  c +="\tMOV "+string(temp)+", AX\n";
		  $$->setCode(c);
		  $$->setId(temp);
		  varDec.push_back(temp);
		  }
		  
        }
     ;

unary_expression : ADDOP unary_expression  
         {
          $$=new SymbolInfo($1->getName()+$2->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->ADDOP unary_expression  found.   ",line_no);
          fprintf(log1,"%s %s\n\n",$1->getName().c_str(),$2->getName().c_str());
          
          string c= $2->getCode();
          if($1->getName()=="-"){
          c += "\tMOV AX,"+$2->getId()+"\n";
          c += "\tNEG AX\n";
          c += "\tMOV "+$2->getId()+",AX\n";
          }
          $$->setCode(c);
          $$->setId($2->getId());
         }
         
		 | NOT unary_expression
		 {
		  $$=new SymbolInfo("!"+$2->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->NOT unary_expression  found.   ",line_no);
          fprintf(log1,"!%s \n\n",$2->getName().c_str());
          
          string c= $2->getCode();
		  c +="MOV AX," + $2->getId() + "\n";
		  c += "NOT AX\n";
		  c += "MOV "+$2->getId() +",AX\n";
		  $$->setCode(c);
		  $$->setId($2->getId());
		 }
		 
		 | factor 
		 {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  unary_expression-->factor  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          $$->setCode($1->getCode());
          $$->setId($1->getId());
		 }
		 ;
	
factor	: variable 
         {
          $$=new SymbolInfo($1->getName() ,"");
          fprintf(log1,"Line at %d rule :  factor-->variable  found.   ",line_no);
          fprintf(log1,"%s \n\n",$1->getName().c_str());
          
          string c = $1->getCode();
          
          if($1->getType()=="array"){
          char *temp= newTemp();
          c +="\tMOV AX,"+$1->getId()+"[BX]\n";
          c+= "\tMOV "+string(temp)+",AX\n";
          varDec.push_back(temp);
          $$->setId(temp);
          
          }
          else{
          $$->setId($1->getId());
          
          }
          $$->setCode(c);
          
         }
     //undone     
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
       
       $$->setCode($2->getCode());
       $$->setId($2->getId());
	  }
	
	| CONST_INT 
     {
     $$=new SymbolInfo($1->getName() ,"int");
     fprintf(log1,"Line at %d rule :  factor-->CONST_INT  found.   ",line_no);
     fprintf(log1,"%s \n\n",$1->getName().c_str());
     
     char *temp = newTemp();
     string c = "\tMOV "+string(temp)+","+$1->getName()+"\n";
     $$->setCode(c);
     $$->setId(string(temp));
     varDec.push_back(temp);
     }
     
	| CONST_FLOAT
	{
     $$=new SymbolInfo($1->getName() ,"float");
     fprintf(log1,"Line at %d rule :  factor-->CONST_FLOAT  found.   ",line_no);
     fprintf(log1,"%s \n\n",$1->getName().c_str());
     
     char *temp = newTemp();
     string c = "\tMOV "+string(temp)+","+$1->getName()+"\n";
     $$->setCode(c);
     $$->setId(string(temp));
     varDec.push_back(temp);
     }
     
	| variable INCOP 
	{
	 $$=new SymbolInfo($1->getName()+"++" ,"");
     fprintf(log1,"Line at %d rule :  factor-->variable INCOP  found.   ",line_no);
     fprintf(log1,"%s++ \n\n",$1->getName().c_str());
     
     char *temp = newTemp();
     string c= "";
     if($1->getType()=="array"){
     c += "\tMOV AX,"+$1->getId()+"[BX]\n";
     }
     else{
     c += "\tMOV AX,"+$1->getId()+"\n";
     }
     c+="\tMOV \n"+string(temp)+",AX\n";
     
     if($1->getType() == "array"){
     c += "\tMOV AX,"+$1->getId()+"[BX]\n";
     c += "\tINC AX\n";
     c += "\tMOV "+$1->getId()+"[BX],AX\n";
     }
     else{
     c += "\tINC "+$1->getId()+"\n";
     }
     varDec.push_back(temp);
     
     $$->setCode(c);
     $$->setId(temp);
     
	}
	
	| variable DECOP
	{
	 $$=new SymbolInfo($1->getName()+"--" ,"");
     fprintf(log1,"Line at %d rule :  factor-->variable DECOP  found.   ",line_no);
     fprintf(log1,"%s-- \n\n",$1->getName().c_str());
     
     char *temp = newTemp();
     string c= "";
     if($1->getType()=="array"){
     c += "\tMOV AX,"+$1->getId()+"[BX]\n";
     }
     else{
     c += "\tMOV AX,"+$1->getId()+"\n";
     }
     c+="\tMOV \n"+string(temp)+",AX\n";
     
     if($1->getType() == "array"){
     c += "\tMOV AX,"+$1->getId()+"[BX]\n";
     c += "\tDEC AX\n";
     c += "\tMOV "+$1->getId()+"[BX],AX\n";
     }
     else{
     c += "\tDEC "+$1->getId()+"\n";
     }
     varDec.push_back(temp);
     
     $$->setCode(c);
     $$->setId(temp);
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

 
