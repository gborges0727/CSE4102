#ifndef __GRAPH_H
#define __GRAPH_H

/*
 * A Directed Graph is represented with an adjacency list.
 * A Directed Graph holds an array of nodes representing the vertices.
 * Nodes carry a name (airport code) along with a list of outgoing arcs to 
 * hold the vertices directly reachable from the source vertex.
 *
 * It is up to you to pick a representation for the Graph, the nodes (and possibly the arcs)
 */
typedef struct Graph {
    struct Node**  _node_list;
    int                   _sz;
} Graph;

typedef struct Node {
    /* FILL IN! */
} Node;

Graph*	allocGraph();
Node*	allocNode();
void	destroyGraph(Graph* g);
void	destroyNode(Node* n);

void	printGraph(Graph* g);
Node*	lookupInGraph(Graph* g, char* c);
Graph*	graphInit(const char* fn);
Graph*	findMST(Graph* g);
Node*	findHub(Graph* g);

#endif
