#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>
using namespace std;

class Process {
    public:
        int id;
        string pname;

        Process() {
            id = 0;
            pname = "";
        }

        friend class Election;
};

class Election {
    Process* p;
    int* flag;
    int num;

    public:
        void input() {
            cout<<"Enter the number of processes: ";
            cin>>num;

            p = new Process[num];
            flag = new int[num];

            for(int i = 0 ; i < num ; i++) {
                cout<<"Enter the process name: ";
                cin>>p[i].pname;
                cout<<"Enter the process id: ";
                cin>>p[i].id;
            }

            int pos = highest(p);

            cout<<"Inital coordinator with name "<<p[pos].pname<<" has crashed"<<endl;
        }

        int highest(Process* p) {
            int pos = 0;
            int max = 0;

            for(int i = 0 ; i < num ; i++) {
                if(p[i].id > max) {
                    max = p[i].id;
                    pos = i;
                }
            }

            return pos;
        }

        int find_pos(int id) {
            for(int i =0  ; i < num ; i++) {
                if(p[i].id == id) {
                    return i;
                    break;
                }
            }
        }

        void Ring(Process coord) {
            
            vector<int> v;
            int crashed = highest(p);
            int pos = find_pos(coord.id);

            int count = 0;
            
            int i = pos;
            while(count < num) {
                if(i != crashed) {
                    v.push_back(p[i].id);
                }
                i = (i+1) % crashed;
                count++;
            }

            int max = INT_MIN;
            cout<<"[ ";
            for(int i = 0 ; i < v.size() ; i++) {
                
                cout<<v[i]<<" ";
                if(v[i] > max) {
                    max = v[i];
                }
            }
            cout<<"]"<<endl;

            int final_coord_pos = find_pos(max);

            cout<<"Final coordinator is: "<<p[final_coord_pos].pname<<endl;
        }

        Process bully(Process coord) {

            for(int i=0;i<num;i++) {
                flag[i] = 0;
            }

            int crashed = highest(p);
            flag[crashed] = 1;

            for(int i = 0 ; i < num ; i++) {
                if(p[i].id > coord.id) {
                    cout<<"The message is sent from "<<coord.id<<" to "<<p[i].id<<endl;
                }
                else {
                    flag[i] = 1;
                }
            }

            for(int i = 0 ; i < num ; i++) {
                if(flag[i] != 1 && p[i].id > coord.id) {
                    flag[coord.id] = 1;
                    coord = p[i];
                }
            }

            for(int i = 0 ; i< num ; i++) {
                if(flag[i] == 0) {
                    coord = bully(coord);
                }
            }

            return coord;
        }
};

int main() {
    Election e;
    e.input();
    Process coord;
    Process final_coord;

    cout << "Enter the name of the process which detects that the coordinator has crashed: ";
    cin >> coord.pname;
    cout << "Enter the id of the process which detects that the coordinator has crashed: ";
    cin >> coord.id;
    int ch = 0;
    while (ch != 3)
    {
        cout << "MENU" << endl;
        cout << "1.Bully algorithm\n2.Ring algorithm\n3.Exit\n";
        cout << "Enter your choice: ";
        cin >> ch;
        switch (ch)
        {
        case 1:
            final_coord = e.bully(coord);
            cout << "The final coordinator is: " << final_coord.pname << endl;
            break;
        case 2:
            e.Ring(coord);
        }
    }

    return 0;
}