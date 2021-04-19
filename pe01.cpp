#include <iostream>

using namespace std;

int main() {
    int one;
    int two;
    int three;
    int total;

    cout << "Input an int ";
    cin >> one;
    cout << "Input an int ";
    cin >> two;
    cout << "Input an int ";
    cin >> three;

    if ((one > two) || (one > three)) {
        if (one > two) {
            total = one + three;
        }
        else {
            total = two + one; 
        }
    }
    else {
        total = two + three;
    }

    cout << endl;
    cout << total;
}