#include <iostream>
using namespace std;

int main() {
    int no_of_frames;
    int window_size;
    int no_tr = 0;

    cout<<"Enter the number of frames: ";
    cin>>no_of_frames;

    cout<<"Enter the window size: ";
    cin>>window_size;

    int i=1;
    while(i <= no_of_frames) {
        int x=0;
        for(int j = i ; j<i+window_size && j <= no_of_frames;j++) {
            cout<<"Sent Frame: "<<j<<endl;
            no_tr++;
        }

        for(int j=i;j < i+window_size && j <= no_of_frames;j++) {
            int flag = rand()%2;
            if(!flag) {
                cout<<"Acknowledgement For Frame "<<j<<endl;
                x++;
            }
            else {
                cout<<"Frame "<<j<<" Not Received"<<endl;
                cout<<"Retransmitting Window"<<endl;
                break;
            }
        }
        cout<<endl;
        i += x;
    }

    cout<<"Total number of transmissions: "<<no_tr<<endl;
    return 0;
}