#ifndef PROJECT_BASE_TCB_HPP
#define PROJECT_BASE_TCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"

// Thread Control Block
class TCB
{
public:
    void *operator new(size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }
    void *operator new[](size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }

    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p); }
    void operator delete[](void *p) noexcept { MemoryAllocator::mem_free(p); }

    ~TCB() { delete[] stack; }

    bool isFinished() const { return finished; }

    void setFinished(bool value) { finished = value; }

    uint64 getTimeSlice() const { return timeSlice; }

    using Body = void (*)(void*);

    static TCB *createThread(Body body, uint64 *stack, void *arg);

    static void yield();

    static TCB *running;

    friend class mySem;
    
    static void addToSleepingList(TCB* thread, int time);

    static void checkSleepingList();

private:
    TCB(Body body, uint64 *stack, void *arg, uint64 timeSlice) : body(body), arg(arg),
                                                                 stack(body != nullptr ? stack : nullptr),
                                                                 context({(uint64)&threadWrapper,
                                                                          stack != nullptr ? (uint64)&stack[STACK_SIZE] : 0}),
                                                                 timeSlice(timeSlice),
                                                                 finished(false), sleepTime(0)
    {
        if (body != nullptr)
        {
            Scheduler::put(this);
        }
        if (running == nullptr) // should only set the main() thread
        {
            TCB::running = this;
        }
    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    Body body;
    void *arg;
    uint64 *stack;
    Context context;
    uint64 timeSlice;
    bool finished;
    int sleepTime;
    
    static List<TCB> sleepingThreads;

    friend class Riscv;

    static void threadWrapper();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    static void dispatch();

    static uint64 timeSliceCounter;

    static uint64 constexpr STACK_SIZE = DEFAULT_STACK_SIZE / sizeof(uint64);
    static uint64 constexpr TIME_SLICE = DEFAULT_TIME_SLICE;
};

#endif // PROJECT_BASE_TCB_HPP
