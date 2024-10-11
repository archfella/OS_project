#include "../h/tcb.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../h/operation_codes.hpp"
#include "../test/printing.hpp"

TCB *TCB::running = nullptr;

uint64 TCB::timeSliceCounter = 0;

List<TCB> TCB::sleepingThreads;

TCB *TCB::createThread(Body body, uint64 *stack, void *arg)
{
    return new TCB(body, stack, arg, TIME_SLICE);
}

void TCB::yield()
{
    __asm__ volatile("ecall");
}

void TCB::dispatch()
{
    TCB *old = running;
    if (!old->isFinished())
    {
        Scheduler::put(old);
    }
    running = Scheduler::get();

    contextSwitch(&old->context, &running->context);
}


void TCB::threadWrapper()
{
    Riscv::popSppSpie();
    running->body(running->arg);
    thread_exit();
}

void TCB::addToSleepingList(TCB* thread, int time)
{
    thread->sleepTime = time;
    sleepingThreads.addLast(thread);
    
    //context switch
    TCB* old = running;
    running = Scheduler::get();
    contextSwitch(&old->context, &TCB::running->context);
}

void TCB::checkSleepingList(){
    if(sleepingThreads.setPointer() == 0) {
        while(1){
            TCB* thread = sleepingThreads.getData();
            thread->sleepTime--;
            if(thread->sleepTime <= 0){
                sleepingThreads.removeElem();
                Scheduler::put(thread);
            }
            if(sleepingThreads.movePointer() == -1) break;
        }
    }
}
