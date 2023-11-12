#include <iostream>
#include <vector>
#include <climits>
#include <iomanip>

using namespace std;

const int INF = INT_MAX;

void printDistanceVector(const vector<int>& distance) {
    cout << "Distance Vector: ";
    for (int dist : distance) {
        if (dist == INF) {
            cout << "INF ";
        } else {
            cout << dist << " ";
        }
    }
    cout << endl;
}

void dijkstra(int numNodes, vector<vector<int>>& graph, int source) {
    vector<int> distance(numNodes, INF);
    vector<bool> visited(numNodes, false);
    vector<int> parent(numNodes, -1);

    distance[source] = 0;

    for (int count = 0; count < numNodes - 1; count++) {
        int u = -1;
        for (int i = 0; i < numNodes; i++) {
            if (!visited[i] && (u == -1 || distance[i] < distance[u]))
                u = i;
        }

        visited[u] = true;

        for (int v = 0; v < numNodes; v++) {
            if (!visited[v] && graph[u][v] != -1 && distance[u] != INF &&
                distance[u] + graph[u][v] < distance[v]) {
                distance[v] = distance[u] + graph[u][v];
                parent[v] = u;
            }
        }

        cout << "Iteration " << count + 1 << ":" << endl;
        printDistanceVector(distance);
    }

    cout << "Optimal path from node " << source << " to every other node:" << endl;
    cout << "Node\tDistance\tPath" << endl;
    for (int i = 0; i < numNodes; i++) {
        cout << i << "\t";
        if (distance[i] == INF)
            cout << "INF";
        else
            cout << distance[i];
        cout << "\t\t";

        int node = i;
        vector<int> path;
        while (node != -1) {
            path.insert(path.begin(), node);
            node = parent[node];
        }

        for (int j = 0; j < path.size(); j++) {
            cout << path[j];
            if (j < path.size() - 1)
                cout << " -> ";
        }
        cout << endl;
    }
}

int main() 
{
    int numNodes;
    cout << "Enter the number of nodes in the network: ";
    cin >> numNodes;

    vector<vector<int>> graph(numNodes, vector<int>(numNodes, -1));

    for (int i = 0; i < numNodes; i++) {
        for (int j = 0; j < numNodes; j++) {
            if (i != j) {
                int distance;
                cout << "Enter the distance between node " << i << " and node " << j << ": ";
                cin >> distance;
                graph[i][j] = distance;
            }
        }
    }

    for (int source = 0; source < numNodes; source++) {
        cout << "Starting from node " << source << ":" << endl;
        dijkstra(numNodes, graph, source);
    }

    return 0;
}