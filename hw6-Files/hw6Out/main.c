#include <stdio.h>
#include <stdlib.h>
#include "graph.h"


int main(int argc, const char* argv[])
{

    if (argc < 2) {
        printf("Usage: %s {data file}\n",argv[0]);
        exit(EXIT_FAILURE);
    }

    // Build & print graph
    // Graph* g = graphInit(argv[1]);
    // printf("[Graph]\n");
    // printGraph(g);

    // Build & print MST
    // Graph* mst = findMST(g);
    // printf("\n[MST]\n");
    // printGraph(mst);

    // Find optimal hub node
    // Node* hub = findHub(mst);
	
    // printf("\n[Hub] ... %s\n",hub->_code);
    // printf("[Weight] ... %d\n",mst->_wt);

    // Clean up
    // destroyGraph(g);
    // destroyGraph(mst);

    return 0;
}
