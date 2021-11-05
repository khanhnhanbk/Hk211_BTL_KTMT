#include <iostream>
#include <fstream>
#include <string>
#include <random>
using namespace std;

int main()
{
    string filename = "INT15.BIN";
    ofstream ofs;
    ofs.open(filename, ios::out | ios::binary | ios::trunc);
    int data[15];
    for (int i = 0; i < 15; i++)
    {
        // randome data value
        data[i] = rand() % 100;
    }
    ofs.write((char*)data,60);
    ofs.close();
    return 0;
}