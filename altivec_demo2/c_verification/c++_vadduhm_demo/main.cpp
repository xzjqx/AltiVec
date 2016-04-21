#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include "ppc_altivec.h"

using namespace std;

int main(){
    ppc_avr_t avr[32];

    ifstream infile1("vector_gpr.txt");

    while(!infile1.eof()){
        for(int i=0; i<32; i++){
            infile1.ignore(3);
            infile1>>hex>>avr[i].u32[0]>>avr[i].u32[1]>>avr[i].u32[2]>>avr[i].u32[3];
        }
    }

    string ins;
    int vra,vrb,vrt;

    ifstream infile2("instruction.txt");

    while(!infile2.eof()){
        infile2>>ins>>vrt>>vra>>vrb;
        if(ins == "vadduhm")
                vadduhm(avr[vrt], avr[vra], avr[vrb]);
    }
    ofstream outfile("vector_gpr.txt");
    for(int i=0; i<32; i++)
        	outfile<<setw(2)<<dec<<setfill('0')<<i<<" "
                 <<setw(8)<<hex<<setfill('0')<<avr[i].u32[0]<<" "
                 <<setw(8)<<hex<<setfill('0')<<avr[i].u32[1]<<" "
                 <<setw(8)<<hex<<setfill('0')<<avr[i].u32[2]<<" "
                 <<setw(8)<<hex<<setfill('0')<<avr[i].u32[3]<<endl;
}