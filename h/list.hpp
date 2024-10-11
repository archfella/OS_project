#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP

#include "../h/MemoryAllocator.hpp"


template <typename T>
class List
{
private:
    struct Elem
    {
        T *data;
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}
    };

    Elem *head, *tail;
    
    Elem* pointer;
    
public:
    List() : head(0), tail(0), pointer(0) {}

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

 
    int setPointer(){
        if(!head) return -1;
        pointer = head;
        return 0;
    } 

    int movePointer(){
        if(!pointer) return -1;
        pointer = pointer->next;
        if(!pointer) return -1;
        return 0;
    }

    T* getData(){
        return pointer->data;
    }

    T* removeElem(){
        if(pointer == head) removeFirst();
        else if(pointer == tail) removeLast();
        else{
            Elem* last = nullptr;
            Elem* curr = head;
            while(curr != pointer){ last = curr; curr = curr->next; }
            last->next = pointer->next;
        }

        return pointer->data;
    }
    void addFirst(T *data)
    {
        // Elem *elem = new Elem(data, head);
        size_t size = sizeof(Elem);
        size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
        elem->data = data;
        elem->next = head;
        head = elem;
        if (!tail)
        {
            tail = head;
        }
    }

    void addLast(T *data)
    {
        // Elem *elem = new Elem(data, 0);
        size_t size = sizeof(Elem);
        size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
        elem->data = data;
        elem->next = 0;
        if (tail)
        {
            tail->next = elem;
            tail = elem;
        }
        else
        {
            head = tail = elem;
        }
        
    }

    T *removeFirst()
    {
        if (!head)
        {
            return 0;
        }

        Elem *elem = head;
        head = head->next;
        if (!head)
        {
            tail = 0;
        }


        T *ret = elem->data;
        // delete elem;
        MemoryAllocator::mem_free(elem);
        return ret;
    }

    T *peekFirst()
    {
        if (!head)
        {
            return 0;
        }
        return head->data;
    }

    T *removeLast()
    {
        if (!head)
        {
            return 0;
        }

        Elem *prev = 0;
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
        {
            prev = curr;
        }

        Elem *elem = tail;
        if (prev)
        {
            prev->next = 0;
        }
        else
        {
            head = 0;
        }
        tail = prev;
        
      
        T *ret = elem->data;
        // delete elem;
        MemoryAllocator::mem_free(elem);
        return ret;
    }

    T *peekLast()
    {
        if (!tail)
        {
            return 0;
        }
        return tail->data;
    }

  
};

#endif // OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP
