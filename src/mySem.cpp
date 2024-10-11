#include "../h/mySem.hpp"

List<TCB> mySem::sleepingOnSem;

List<mySem> mySem::allTimedSems;

void mySem::close() {
    TCB* thread;
    while((thread = blocked.removeFirst()) != nullptr){
        Scheduler::put(thread);
    }
    closed = true;
}

void mySem::block() {
    TCB* old = TCB::running;
    blocked.addLast(old);
    TCB::running = Scheduler::get();
    TCB::contextSwitch(&old->context, &TCB::running->context);
}

void mySem::wait() {
    if(--val < 0){
        block();
    }
}

void mySem::deblock() {
    TCB* thread = blocked.removeFirst();
    Scheduler::put(thread);
}

void mySem::signal() {
    if (val++<0)
        deblock();
}

int mySem::trywait() {
    if (val > 0){
        val--;
        return 1;
    }
    return 0;
}

void mySem::addToWaitingList(time_t period) {
    if(!flagAdded) {
        allTimedSems.addLast(this);
        flagAdded = true;
    }
    TCB::running->sleepTime = period;
    sleepingOnSem.addLast(TCB::running);

    //context switch
    TCB* old = TCB::running;
    TCB::running = Scheduler::get();
    TCB::contextSwitch(&old->context, &TCB::running->context);
}

void mySem::checkWaitingList() {
    if(sleepingOnSem.setPointer() == 0) {
        while(1){
            TCB* thread = sleepingOnSem.getData();
            thread->sleepTime--;
            if(thread->sleepTime == 0){
                sleepingOnSem.removeElem();
                Scheduler::put(thread);
            }
            if(sleepingOnSem.movePointer() == -1) break;
        }
    }
}

void mySem::checkAllTimedSems() {
    if(allTimedSems.setPointer() == 0) {
        while(1){
            mySem* sem = allTimedSems.getData();
            if(sem) sem->checkWaitingList();
            if(allTimedSems.movePointer() == -1) break;
        }
    }
}

