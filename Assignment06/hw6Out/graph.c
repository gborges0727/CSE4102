#include "graph.h"
#include <stdlib.h>
#include <stdio.h>

Graph* allocGraph()
{
    // TO DO
    return NULL;
}

Node* allocNode()
{
    // TO DO
    return NULL;
}

void destroyGraph(Graph* g)
{
    // TO DO
}

void destroyNode(Node* n)
{
    // TO DO
}

void printGraph(Graph* g)
{
    // TO DO
}

Node* lookupInGraph(Graph* g, char* c)
{
    // TO DO
    return NULL;
}

Graph* graphInit(const char* fn)
{
    // TO DO!!!!
    // Reads the file from a file named "fn"
    // Use fscanf to read the file!
    FILE* f = fopen(fn,"r+");
    char u[16], v[16];
    int w, sz;
    fscanf(f,"%d\n",&sz);
    Graph* g = allocGraph();
    // ADD ANY OTHER ALLOCATIONS YOU NEED
    while ( fscanf(f,"%s %s %d\n",u,v,&w) != EOF ) {
        // ADD the arcs u->v  and v->u  (both with weight w) to the graph
    }
    fclose(f);
    return g;
}

Graph* findMST(Graph* g)
{
    // TO DO
    return NULL;
}

Node* findHub(Graph* g)
{
    // TO DO
    return NULL;
}
