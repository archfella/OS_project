#include "../lib/hw.h"
#include "../h/syscall_c.hpp"
#include "../h/operation_codes.hpp"

void *mem_alloc(size_t size)
{
    if (!size)
        return nullptr;
    size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
    __asm__ volatile("mv a2, %0" : : "r"(numBlocks));
    __asm__ volatile("mv a0, %0" : : "r"(MEM_ALLOC));
    __asm__ volatile("ecall");

    volatile uint64 retaddr;
    __asm__ volatile("mv %0, a0" : "=r"(retaddr));
    return (void *)retaddr;
}

int mem_free(void *addr)
{
    if (!addr)
        return -1;
    __asm__ volatile("mv a2, %0" : : "r"(addr));
    __asm__ volatile("mv a0, %0" : : "r"(MEM_FREE));
    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int thread_create(thread_t *handle, void (*start_routine)(void*), void *arg)
{

    uint64 *stack_space = (uint64 *)mem_alloc(DEFAULT_STACK_SIZE);

    if (!stack_space)
    {
        return -1;
    }

    __asm__ volatile("mv a4, %0" : : "r"(stack_space));
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_CREATE));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int thread_exit()
{
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_EXIT));

    __asm__ volatile("ecall");

    return 0;
}

void thread_dispatch()
{
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_DISPATCH));
    __asm__ volatile("ecall");
}

int time_sleep (time_t time){
    __asm__ volatile("mv a1, %0" : : "r"(time));
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_SLEEP));
    __asm__ volatile("ecall");

    return 0;
}

int sem_open(sem_t* handle, unsigned init){
    __asm__ volatile("mv a2, %0" : : "r"(init));
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_OPEN));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int sem_close(sem_t handle){
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_CLOSE));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int sem_wait(sem_t id){
    __asm__ volatile("mv a1, %0" : : "r"(id));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_WAIT));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int sem_signal (sem_t id){
    __asm__ volatile("mv a1, %0" : : "r"(id));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_SIGNAL));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int sem_trywait(sem_t id){
    __asm__ volatile("mv a1, %0" : : "r"(id));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_TRYWAIT));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

int sem_timedwait(sem_t id, time_t time) {
    __asm__ volatile("mv a2, %0" : : "r"(id));
    __asm__ volatile("mv a1, %0" : : "r"(time));
    __asm__ volatile("mv a0, %0" : : "r"(SEM_TIMEDWAIT));

    __asm__ volatile("ecall");

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    return status;
}

char getc(){
    __asm__ volatile("mv a0, %0" : : "r"(GETC));

    __asm__ volatile("ecall");

    volatile char character;

    __asm__ volatile("mv %0, a0" : "=r"(character));
    return character;
}

void putc(char c){
    __asm__ volatile("mv a1, %0" : : "r"(c));
    __asm__ volatile("mv a0, %0" : : "r"(PUTC));

    __asm__ volatile("ecall");
}

