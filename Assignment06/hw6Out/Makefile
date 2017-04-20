OFILES = main.o graph.o pqueue.o
GCC = /usr/bin/gcc
CFLAGS = -g

all: mst

mst: $(OFILES)
	$(GCC) $(CFLAGS) -o $@ $(OFILES)

%.o : %.c
	$(GCC) -c $(CFLAGS) $<

clean:
	rm -rf $(OFILES) mst
