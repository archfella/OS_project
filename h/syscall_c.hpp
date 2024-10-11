#ifndef PROJECT_BASE_SYSCALL_C_HPP
#define PROJECT_BASE_SYSCALL_C_HPP
#include "../lib/hw.h"
#include "../h/tcb.hpp"
#include "../h/mySem.hpp"

/*---------- MEMORY -------------*/
void* mem_alloc(size_t size);

int mem_free(void* addr);

/*---------- THREAD -------------*/
typedef TCB* thread_t;

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);

int thread_exit();

void thread_dispatch();

typedef unsigned long time_t;

int time_sleep (time_t);

/*---------- SEMAPHORE -------------*/
typedef mySem* sem_t;

int sem_open(sem_t* handle, unsigned init);

int sem_close (sem_t handle);

int sem_wait(sem_t id);

int sem_signal (sem_t id);

int sem_trywait(sem_t id);

int sem_timedwait(sem_t id, time_t time);
/*---------- I/O -------------*/
const int EOF = -1;

char getc();

void putc(char);


#endif //PROJECT_BASE_SYSCALL_C_HPP
