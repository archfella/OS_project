#include "../lib/console.h"
#include "../h/operation_codes.hpp"
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../h/syscall_c.hpp"

const uint64 ECALL_USER = 0x0000000000000008UL;
const uint64 ECALL_SUPER = 0x0000000000000009UL;

void Riscv::popSppSpie()
{
    mc_sstatus(Riscv::SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();

    if (scause == ECALL_USER || scause == ECALL_SUPER)
    {
        uint64 volatile new_sepc = r_sepc() + 4;
        uint64 volatile sstatus = r_sstatus();
        uint64 a0;
        __asm__ volatile("ld %0, 10*8(s0)" : "=r"(a0)); // read a0

        if (a0 == MEM_ALLOC)
        {
            size_t size;
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(size)); // read a2
            void *returnVal = MemoryAllocator::mem_alloc(size);
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(returnVal)); // store return value in a0
        }
        else if (a0 == MEM_FREE)
        {
            void *addr;
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(addr)); // read a2
            int status = MemoryAllocator::mem_free(addr);
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status)); // store status in a0
        }
        else if (a0 == THREAD_CREATE)
        {
            thread_t *handle;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
            void (*start_routine)(void *);
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(start_routine));
            void *arg;
            __asm__ volatile("ld %0, 13*8(s0)" : "=r"(arg));
            uint64 *stack;
            __asm__ volatile("ld %0, 14*8(s0)" : "=r"(stack));
            *handle = TCB::createThread((TCB::Body)start_routine, stack, arg);

            uint64 status = 0;
            if (*handle == nullptr)
                status = -1;
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if(a0 == THREAD_DISPATCH)
        {
            TCB::dispatch();
        }
        else if(a0 == THREAD_EXIT)
        {
            TCB::running->setFinished(true);
            TCB::dispatch();
        }
        else if (a0 == THREAD_SLEEP) {
            time_t time;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(time));
            TCB::addToSleepingList(TCB::running, time);
        }
        else if(a0 == SEM_OPEN)
        {
            sem_t *handle;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
            unsigned init;
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(init));
            *handle = mySem::createSemaphore((int)init);
            uint64 status = 0;
            if (*handle == nullptr)
                status = -1;
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if(a0 == SEM_WAIT){
            sem_t id;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(id));

            uint64 status = 0;

            if(id->isClosed()){
                status = -1;
            }
            else{
                id->wait();
            }
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if(a0 == SEM_CLOSE){
            sem_t handle;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));

            uint64 status = 0;

            if(handle->isClosed())
                status = -1;
            else{
                handle->close();
            }
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if (a0 == SEM_SIGNAL){
            sem_t handle;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));

            uint64 status = 0;

            if(handle->isClosed()){
                status = -1;
            }
            else{
                handle->signal();
            }
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if(a0 == SEM_TIMEDWAIT) {
            sem_t id;
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(id));
            time_t time;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(time));

            uint64 status = 0;

            if(id->isClosed())
                status = -1;
            else{
                id->addToWaitingList(time);
            }
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));

        }
        else if (a0 == SEM_TRYWAIT){
            sem_t handle;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));

            uint64 status = 0;

            if(handle->isClosed()){
                status = -1;
            }
            else{
                status = handle->trywait();
            }
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
        }
        else if(a0 == GETC){
            char character = __getc();
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(character));
        }
        else if(a0 == PUTC){
            char character;
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(character));
            __putc(character);
        }
        w_sstatus(sstatus);
        w_sepc(new_sepc);
    }
    else if (scause == 0x8000000000000001UL)
    {
        // ASYNCHRONOUS CONTEXT SWITCH - TIMER
        //  interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        mc_sip(SIP_SSIP); // clear software interrupt pending
        TCB::timeSliceCounter++;
        TCB::checkSleepingList(); //wakes up sleeping threads if sleep time exceeded
        mySem::checkAllTimedSems(); //wakes up timed-waiting threads waitinng on semaphores
        if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
        {
            uint64 volatile sepc = r_sepc(); // dispatch will change the context
            uint64 volatile sstatus = r_sstatus();
            TCB::timeSliceCounter = 0;
            TCB::dispatch();
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    }
    else if (scause == 0x8000000000000009UL)
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }
    else
    {
        // unexpected trap cause
    }
}
