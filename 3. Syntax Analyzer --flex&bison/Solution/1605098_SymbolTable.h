#include<iostream>
#include <cstring>
#include <math.h>
//#include <fstream>
//#include <bits/stdc++.h>
#include<cstdlib>

using namespace std;


class SymbolInfo
{
    string name;
    string type;

    SymbolInfo * next;

public:
    SymbolInfo()
    {
        next = 0;
    }
    SymbolInfo(string name, string type)
    {
        this->name = name;
        this->type = type;
        next = 0;
    }

    void setName(string s)
    {
        this->name = s;
    }

    void setType(string s)
    {
        this->type = s;
    }
    void setNext(SymbolInfo * p)
    {
        this->next = p;
    }

    string getName()
    {
        return this->name;
    }

    string getType()
    {
        return this->type;
    }
    SymbolInfo * getNext()
    {
        return this->next;
    }

    ~SymbolInfo();

};




class ScopeTable
{
    int nBuckets, uid;

    SymbolInfo **arraySInfo;
    ScopeTable * parentScope;
    FILE *flog;

public:

    ScopeTable(int uid, int nBuckets, ScopeTable * parent, FILE *f)
    {

        this->uid = uid;
        this->nBuckets = nBuckets;
        this->parentScope = parent;
        arraySInfo = new SymbolInfo * [nBuckets];

        for(int i=0; i<nBuckets ; i++)
        {
            arraySInfo[i] = 0;
        }
        this->flog = f;
    }

    ScopeTable * getParentScope()
    {
        return this->parentScope;
    }

    int hashFunc(string s)
    {
        long long int d = 0;
        char char_array[s.length()];
        strcpy(char_array, s.c_str());

        for(int i = 0; i<s.length(); i++)
            d= d*11 + pow(10, i) * char_array[i];

        return  (d% this->nBuckets) ;
    }


    bool insert(string name, string type)
    {
        if(lookup(name))
        {
            //cout << name << " Already Exists...."<< endl<<endl;
            return false;
        }

        int p = 0;

        int hashVal = hashFunc(name);
        SymbolInfo * temp = arraySInfo[hashVal];

        SymbolInfo * newSymbol = new SymbolInfo(name, type);
    
        if(temp == 0)
        {
            arraySInfo[hashVal] = newSymbol;

            // cout << "Inserted in scope table #" << this->uid << " at ("<< hashVal<<", //"<< p <<")  position."<< endl<<endl;
            printScopeTable();
            return true;
        }
        while (temp->getNext() != 0)
        {
            temp = temp->getNext();
        }

        temp->setNext(newSymbol);
        //cout << "Inserted in scope table #" << this->uid << " at ("<< hashVal<<", "<< p //<<")  position."<< endl<<endl;
        p++;
        printScopeTable();
        return true;

    }
    
    
    SymbolInfo * lookup(string s)
    {
        int hashValue = hashFunc(s);
        int p =0;

        SymbolInfo * temp = new SymbolInfo();
        temp = arraySInfo[hashValue];

        while( temp != 0)
        {
            if(temp->getName() == s)
            {
                // cout << "Found in scope table #" << this->uid << "at ("<< hashValue<<", //"<< p <<")  position."<< endl<<endl;
                return temp ;
            }
            temp = temp->getNext();
            p++;
        }
        //cout << "Not Found"<< endl<<endl;
        return temp;
    }
    
    bool deleteEntry(string s)
    {
        if(lookup(s) == 0)
        {
            //cout << s<< " Doesn't Exist...."<< endl<<endl;
            return false;
        }
        int p=0;
        int hashVal = hashFunc(s);
        SymbolInfo * temp = arraySInfo[hashVal];

        if(temp->getName() == s)
        {
            arraySInfo[hashVal] = temp->getNext();
            //cout << "Deleted entry at ("<< hashVal<<"," << p <<") from the current //scope."<<endl<<endl;
            return true;
        }
        // seeeeeee
        SymbolInfo * prev = new SymbolInfo();

        while(temp->getName() != s)
        {
            prev = temp;
            temp = temp->getNext();
            p++;
        }
        prev->setNext( temp->getNext() );
        //cout << "Deleted entry at ("<< hashVal<<"," << p <<") from the current scope."<<endl<<endl;
        return true;

    }

    void printScopeTable()
    {
        //cout << "ScopeTable# " << this->uid << endl;
        fprintf(flog, "ScopeTable# %d \n", this->uid);
    
        SymbolInfo * temp;
        for(int i = 0; i< nBuckets; i++)
        {
            temp = arraySInfo[i];
            //cout << i<< " -->  ";
            fprintf(flog, "%d -->", i);

            while(temp)
            {
                //cout << "<" << temp->getName() << " : " << temp->getType() << ">   ";
                fprintf(flog, "< %s : %s >",temp->getName().c_str(), temp->getType().c_str());
                temp = temp->getNext();
            }
            //cout << endl;
            fprintf(flog,"\n");
        }

    }  

    ~ScopeTable()
    {
        for(int i = 0; i< nBuckets; i++)
            delete(arraySInfo[i]);
        delete(parentScope);
    }
};

class SymbolTable
{
    int nBuckets , c_id;
    ScopeTable * current;
    
    FILE * flog;

public:
    SymbolTable(int nBuckets)
    {
        this->c_id = 0;
        this->nBuckets = nBuckets;
        this->current = 0;
        this->flog = 0;
    }
    SymbolTable(int nBuckets, FILE * f)
    {
        this->c_id = 0;
        this->nBuckets = nBuckets;
        this->current = 0;
        this->flog = f;
    }

    void enterScope()
    {
        this->c_id++;
        ScopeTable * newSTable;
        newSTable = new ScopeTable(this->c_id, this->nBuckets, this->current, this->flog);
        this->current = newSTable;
        //cout << "New scope table with id"<<this->c_id <<" created."<< endl<<endl;

    }

    void exitScope()
    {
        if(this->c_id == 0)
        {
            // cout << "No scope table found " << endl<<endl;
            return;
        }
        this->current = current->getParentScope();

        //cout << "Scope table with id"<<this->c_id <<" removed."<< endl<<endl;
        this->c_id--;

    }
    
    bool insert(string name, string type)
    {
        fprintf(flog,"Hello");
        if(current != 0)
        {
            return current->insert(name, type);
        }
        else if(current == 0)
        {
            enterScope();
            return current->insert(name, type);
        }
    }
    
    bool remove(string name)
    {
        if(current == 0)
        {
            //cout << "No scope found to remove."<< endl<<endl;
            return false;
        }
        else
        {
            return current->deleteEntry(name);
        }

    }
    
    SymbolInfo *lookup(string s)
    {
        ScopeTable * temp = current;
        for(int i =0; i< this->c_id ; i++)
        {
            temp->lookup(s);
            temp = temp->getParentScope();
        }
    }
    
   void printCurrentScope()
    {
        current->printScopeTable();
    }
    
    void printAllScope()
    {
        ScopeTable * temp = current;
        for(int i =0; i< this->c_id ; i++)
        {
            temp->printScopeTable();
            temp = temp->getParentScope();
        }
    }
    ~SymbolTable();

};
