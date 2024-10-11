#ifndef PROJECT_BASE_1_SYSCALL_CPP_HPP
#define PROJECT_BASE_1_SYSCALL_CPP_HPP

#include "syscall_c.hpp"

void *operator new(size_t n);
void operator delete(void *p) noexcept;

class Thread{
public:
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();

    int start ();

    static void dispatch ();
    static int sleep(time_t);
protected:
    Thread();
    virtual void run () {}

private:
    thread_t myHandle;
    void (*body)(void*);
    void* arg;

    static void runWrapper(void* thread) {
        if(thread != nullptr) {
            ((Thread*)thread)->run();
        }
    }
};

class PeriodicThread : public Thread {
public:
    void terminate();
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation() {}
    virtual void run() override;
private:
    time_t period;
};

class Semaphore {
public:

    Semaphore (unsigned init = 1);
    virtual ~Semaphore ();

    int wait ();
    int signal ();
    int timedWait(time_t);
    int tryWait();

private:
    sem_t myHandle;
};

class Console {
public:
    static char getc();
    static void putc(char);
};



#endif //PROJECT_BASE_1_SYSCALL_CPP_HPP
