#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"

FreeMem *MemoryAllocator::fmem_head = nullptr;
const size_t HEADER_SIZE = MEM_BLOCK_SIZE;

void MemoryAllocator::initialize()
{
    fmem_head = (FreeMem *)((size_t)HEAP_START_ADDR + MEM_BLOCK_SIZE - (size_t)HEAP_START_ADDR % MEM_BLOCK_SIZE);
    fmem_head->next = nullptr;
    fmem_head->prev = nullptr;
    fmem_head->size = (size_t)HEAP_END_ADDR - (size_t)fmem_head - HEADER_SIZE;
}

void *MemoryAllocator::mem_alloc(size_t sz)
{

    size_t size = sz * MEM_BLOCK_SIZE;
    if (size <= 0)
        return nullptr;

    FreeMem *curr = fmem_head;

    for (curr = fmem_head; curr && curr->size < size; curr = curr->next)
        ; // search for the block big enough

    if (!curr)
        return nullptr; // not enough free memory

    if (curr->size == size)
    {
        // No fragment left, remove from list
        if (curr != fmem_head)
            curr->prev->next = curr->next;
        else
            fmem_head = curr->next; // nullptr - !!!
        if (curr->next)
            curr->next->prev = curr->prev;
    }
    else
    {
        // Make a new free segment
        FreeMem *free = (FreeMem *)((char *)curr + size + HEADER_SIZE);
        free->next = curr->next;
        free->prev = curr->prev;
        free->size = curr->size - size - MEM_BLOCK_SIZE;

        // Update the free list - remove curr
        if (curr == fmem_head)
            fmem_head = free;
        else
            curr->prev->next = free;
        if (curr->next)
            curr->next->prev = free;
    }
    curr->prev = nullptr;
    curr->next = nullptr;
    curr->size = size;
	
    return (void *)((char *)curr + MEM_BLOCK_SIZE);
}

int MemoryAllocator::tryToJoin(FreeMem *curr)
{
    if (!curr)
        return 0;
    if (curr->next && (char *)curr + curr->size + HEADER_SIZE == (char *)curr->next)
    {
        curr->size += curr->next->size + HEADER_SIZE;
        curr->next = curr->next->next;
        if (curr->next)
            curr->next->prev = curr;
        return 1;
    }
    else
        return 0;
}

int MemoryAllocator::mem_free(void *addr)
{
    if (addr < HEAP_START_ADDR || addr >= HEAP_END_ADDR || addr == nullptr)
        return -1;
    FreeMem *curr = nullptr;
    if (!fmem_head || addr < (char *)fmem_head)
        curr = nullptr;
    else
        for (curr = fmem_head; curr->next != nullptr && addr > (char *)(curr->next); curr = curr->next)
            ;

    FreeMem *newSeg = (FreeMem *)((char *)addr - MEM_BLOCK_SIZE);
    newSeg->prev = curr;
    if (curr)
        newSeg->next = curr->next;
    else
        newSeg->next = fmem_head;
    if (newSeg->next)
        newSeg->next->prev = newSeg;
    if (curr)
        curr->next = newSeg;
    else
        fmem_head = newSeg;

    tryToJoin(newSeg);
    tryToJoin(curr);
    return 0;
}
