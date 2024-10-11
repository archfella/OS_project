#ifndef PROJECT_BASE_OPERATION_CODES_HPP
#define PROJECT_BASE_OPERATION_CODES_HPP

#include "../lib/hw.h"

const uint64 MEM_ALLOC = 0x01;
const uint64 MEM_FREE = 0x02;
const uint64 THREAD_CREATE = 0x11;
const uint64 THREAD_EXIT = 0x12;
const uint64 THREAD_DISPATCH = 0x13;
const uint64 THREAD_SLEEP = 0x14;
const uint64 SEM_OPEN = 0x21;
const uint64 SEM_CLOSE = 0x22;
const uint64 SEM_WAIT = 0x23;
const uint64 SEM_SIGNAL = 0x24;
const uint64 SEM_TIMEDWAIT = 0x25;
const uint64 SEM_TRYWAIT = 0x26;
const uint64 GETC = 0x41;
const uint64 PUTC = 0x42;

#endif //PROJECT_BASE_OPERATION_CODES_HPP
