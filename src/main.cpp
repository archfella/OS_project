#include "../h/tcb.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_cpp.hpp"


extern void userMain();

void userWrapper(void*){
    userMain();
}

int main()
{
    MemoryAllocator::initialize();
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);

    //1 - user main


    TCB* mainThread;
    thread_create(&mainThread, nullptr, nullptr);
    TCB* userThread;
    thread_create(&userThread, userWrapper, nullptr);
    while(!userThread->isFinished()){
        thread_dispatch();
    }


    
    return 0;
}
