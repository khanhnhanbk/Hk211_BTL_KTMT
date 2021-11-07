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
    int data[15] = {1,3,5,2,4,6,100,2,4,6,8,14,20,30,40};
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