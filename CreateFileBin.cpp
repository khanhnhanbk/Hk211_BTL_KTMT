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
    int data[15] = {24,17,59,12,64,195,206,275,187,269,179,255,829,163,27};
    // for (int i = 0; i < 15; i++)
    // {
    //     // randome data value
    //     data[i] = rand() % 100;
    //     cout << data[i] << ' ';
    // }
    ofs.write((char*)data,60);
    ofs.close();
    ofstream textFile("data.txt");
        
    textFile.is_open();
    for (int i = 0; i < 15; i++)
    textFile << data[i] << ' ';
    textFile.close();
    return 0;
}