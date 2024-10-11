#ifndef PROJECT_BASE_1_MYSEM_HPP
#define PROJECT_BASE_1_MYSEM_HPP

#include "tcb.hpp"

class mySem{
public:
    void *operator new(size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }
    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p);}

    mySem (int initValue=1) : val(initValue) {}
    void close();
    void wait();
    void block();
    void signal();
    void deblock();
    int trywait();
    void addToWaitingList(time_t period);
    void checkWaitingList();
    bool isClosed(){return closed;}
    static mySem* createSemaphore(int init){
        return new mySem(init);
    }
    static void checkAllTimedSems();
protected:
    int val;
private:
    bool closed = false;
    List<TCB> blocked;
    static List<TCB> sleepingOnSem;
    static List<mySem> allTimedSems;
    bool flagAdded = false;
};
#endif //PROJECT_BASE_1_MYSEM_HPP
