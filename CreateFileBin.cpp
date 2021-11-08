#include <bits/stdc++.h>
using namespace std;

// random number generator by current time
int random_number(int min, int max)
{
    static default_random_engine e(time(0));
    static uniform_int_distribution<int> u(min, max);
    return u(e);
}

int main()
{
    string filename = "INT15.BIN";
    ofstream ofs;
    ofs.open(filename, ios::out | ios::binary | ios::trunc);
    int data[15];
    for (int i = 0; i < 15; i++)
    {
        // randome data value
        data[i] = random_number(1, 256);
        cout << data[i] << ' ';
    }
    ofs.write((char*)data,60);
    ofs.close();
    ofstream textFile("data.txt");
        
    textFile.is_open();
    for (int i = 0; i < 15; i++)
    textFile << data[i] << ' ';
    textFile.close();
    return 0;
}