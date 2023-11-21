#include <bits/stdc++.h>
using namespace std;

class PageReplacement
{
    int hit;
    int miss;
    int size;
    string str;
    vector<char> cache;

public:
    PageReplacement()
    {
        this->hit = 0;
        this->miss = 0;

        cout << "Enter the size of the cache: ";
        cin >> size;

        for (int i = 0; i < size; i++)
        {
            cache.push_back(' ');
        }

        cout << "Enter the string: ";
        cin >> str;
    }

    void displayCache()
    {
        for (int i = 0; i < size; i++)
        {
            cout << cache[i] << " ";
        }
        cout << endl;
    }

    void FirstInFirstOut()
    {

        int index = 0;
        bool isPresent;
        for (int i = 0; i < str.size(); i++)
        {
            isPresent = false;
            for (int j = 0; j < this->size; j++)
            {
                if (cache[j] == str[i])
                {
                    hit++;
                    isPresent = true;
                    break;
                }
            }

            if (!isPresent)
            {
                cache[index] = str[i];
                index = (index + 1) % this->size;
                miss++;
            }

            displayCache();
        }

        cout << "In First In First Out page replacement algorithm for the reference string " << str << " the miss count is: " << miss << " and the hit count is: " << hit << endl;
    }

    void leastRecentlyUsed()
    {
        bool isPresent;
        int index = 0;
        unordered_map<int, int> indexes;
        for (int i = 0; i < str.size(); i++)
        {

            isPresent = false;
            for (int j = 0; j < size; j++)
            {
                if (cache[j] == str[i])
                {
                    hit++;
                    isPresent = true;
                    break;
                }
            }

            if (i < size && isPresent == false)
            {
                cache[index] = str[i];
                index = (index + 1) % size;
                miss++;
            }
            else if (isPresent == false)
            {
                int leastUsedIndex = INT_MAX;
                int cacheEntry = 0;

                for (int j = 0; j < size; j++)
                {
                    if (leastUsedIndex > indexes[cache[j]])
                    {
                        leastUsedIndex = indexes[cache[j]];
                        cacheEntry = cache[j];
                    }
                }

                for (int j = 0; j < size; j++)
                {
                    if (cache[j] == cacheEntry)
                    {
                        cache[j] = str[i];
                    }
                }

                miss++;
            }

            indexes[str[i]] = i;
            displayCache();
        }
        cout << "In least recently used page replacement algorithm for the reference string " << str << " the miss count is: " << miss << " & hit count is: " << hit << endl;
    }

    int predict(int index)
    {
        int res = -1;
        int farthest = index;

        for (int i = 0; i < size; i++)
        {
            int j;
            for (j = index; j < str.size(); j++)
            {
                if (cache[i] == str[j])
                {
                    if (farthest < j)
                    {
                        farthest = j;
                        res = i;
                    }
                    break;
                }
            }

            if (j == str.size())
            {
                return i;
            }
        }
        return (res == -1) ? 0 : res;
    }

    void OptimalReplacementAlgorithm()
    {
        int index = 0;
        bool isPresent;
        for (int i = 0; i < str.size(); i++)
        {
            isPresent = false;
            for (int j = 0; j < size; j++)
            {
                if (cache[j] == str[i])
                {
                    hit++;
                    isPresent = true;
                    break;
                }
            }

            if (i < size && isPresent == false)
            {
                cache[index] = str[i];
                index = (index + 1) % size;
                miss++;
            }
            else if (isPresent == false)
            {
                index = predict(i + 1);
                cache[index] = str[i];
                miss++;
            }
            displayCache();
        }
        cout << "In least recently used page replacement algorithm for the reference string " << str << " the miss count is: " << miss << " & hit count is: " << hit << endl;
    }
};

int main()
{
    PageReplacement page;

    int option;
    cout << "Enter any one of the option: ";
    cout << "\n1.First In First Out(FIFO)" << endl;
    cout << "\n2.Least Recently Used" << endl;
    cout << "\n3.Optimal Page Replacement algorithm" << endl;
    cin >> option;

    switch (option)
    {
    case 0:
        break;
    case 1:
        page.FirstInFirstOut();
    case 2:
        page.leastRecentlyUsed();
    case 3:
        page.OptimalReplacementAlgorithm();
    }
    return 0;
}