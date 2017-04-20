#ifndef __PQUEUE_H
#define __PQUEUE_H

struct Node;

typedef struct PQueue {
	struct Arc**	_arc_list;
	int     	      _sz;
} PQueue;

typedef struct Arc {
	struct Node*	 _u;
	struct Node*     _v;
	int		_wt;
} Arc;

PQueue*	allocPQueue();
Arc*	allocArc();
void	destroyPQueue(PQueue* pq);
void	destroyArc(Arc* a);

void			insert(PQueue* pq, Arc* a);
Arc*			extractMin(PQueue* pq);

#endif
