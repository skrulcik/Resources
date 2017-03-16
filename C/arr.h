/**
 * @file arr.h
 * @brief Declares a growable array type.
 */

#ifndef ARR_H
#define ARR_H

#include <stdint.h>

typedef int64_t elem;

typedef struct {
    elem *arr;
    uint64_t count;
    uint64_t capacity;
} Arr;

void Arr_init(Arr *a);
void Arr_deinit(Arr *a);

int Arr_add(Arr *a, elem e);
int Arr_remove(Arr *a, elem e);

int Arr_find(Arr *a, elem e);

#endif /* ifndef ARR_H */

