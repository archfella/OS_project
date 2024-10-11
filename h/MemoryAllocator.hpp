#ifndef PROJECT_BASE_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

struct FreeMem{
    FreeMem* next;
    FreeMem* prev;
    size_t size;
};

class MemoryAllocator{
public:
    //Interface
    static void* mem_alloc(size_t);
    static int mem_free(void*);
    static int tryToJoin(FreeMem*);
    static void initialize();
private:
    MemoryAllocator();
    static FreeMem* fmem_head;
};
#endif //PROJECT_BASE_MEMORYALLOCATOR_HPP
