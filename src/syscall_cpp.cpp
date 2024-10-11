#include "../h/syscall_cpp.hpp"

Thread::Thread(void (*body)(void*), void* arg) {
    myHandle = nullptr;
    this->body = body;
    this->arg = arg;
}

int Thread::start() {
    if(myHandle != nullptr)
        return -1;

    return thread_create(&myHandle, runWrapper, this);
}

void Thread::dispatch() {
    thread_dispatch();
}

Thread::~Thread() {
    delete myHandle;
}

Thread::Thread() {
    myHandle = nullptr;
    arg = nullptr;
    body = nullptr;
}

int Thread::sleep(time_t time) {
    time_sleep(time);
    return 0;
}

PeriodicThread::PeriodicThread(time_t period) {
    this->period = period;
}

void PeriodicThread::run() {
    while(period) {
        periodicActivation();
        time_sleep(period);
    }
}

void PeriodicThread::terminate() {
    period = 0;
}


Semaphore::Semaphore(unsigned int init) {
    myHandle = nullptr;
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::tryWait() {
    return sem_trywait(myHandle);
}

int Semaphore::timedWait(time_t time) {
    return sem_timedwait(myHandle, time);
}


char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    return ::putc(c);
}




