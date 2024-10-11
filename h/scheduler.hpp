#ifndef PROJECT_BASE__SCHEDULER_HPP
#define PROJECT_BASE__SCHEDULER_HPP

#include "list.hpp"

class TCB;

class Scheduler
{
private:
    static List<TCB> readyThreadQueue;

public:
    static TCB *get();
    static void put(TCB *ccb);
};

#endif //PROJECT_BASE_SCHEDULER_HPP
