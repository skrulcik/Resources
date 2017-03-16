/**
 * @file arr.c
 * @brief Defines a growable array type.
 */

#include "arr.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int _resize(Arr *a, uint64_t target) {
    assert(a->count <= target);

    elem *new = (elem *)calloc(target, sizeof(elem));
    if (new == NULL) {
        return -1;
    }
    if (a->arr != NULL) {
        memcpy(new, a->arr, sizeof(elem) * a->count);
        free(a->arr);
    }
    a->arr = new;
    a->capacity = target;
    return 0;
}

void Arr_init(Arr *a) {
    memset(a, 0, sizeof(Arr));
    a->count = 0;
    a->capacity = 0;
    a->arr = NULL;
}

void Arr_deinit(Arr *a) {
    if (a->arr != NULL) {
        free(a->arr);
        a->arr = NULL;
    }
    a->count = 0;
    a->capacity = 0;
}

int Arr_add(Arr *a, elem e) {
    if (a->count >= a->capacity) {
        int res = _resize(a, a->capacity == 0 ? 2: a->capacity * 2);
        if (res < 0) {
            return res;
        }
    }
    assert(a->count < a->capacity);
    a->arr[a->count++] = e;
    return 0;
}

int Arr_remove(Arr *a, elem e) {
    for (uint64_t i = 0; i < a->count; i++) {
        if (a->arr[i] == e) {
            uint64_t n = a->count - i - 1;
            memcpy(&a->arr[i], &a->arr[i + 1], n * sizeof(elem));
            a->count--;
            if (a->count < a->capacity / 4) {
                _resize(a, a->capacity / 2);
            }
            return 1;
        }
    }
    return 0;
}

int Arr_find(Arr *a, elem e) {
    for (uint64_t i = 0; i < a->count; i++) {
        if (a->arr[i] == e) {
            return 1;
        }
    }
    return 0;
}

#define TEST_LIMIT 1024
int main() {
    Arr a;
    Arr_init(&a);
    for (int i = 0; i < TEST_LIMIT * 3; i++) {
        switch (i % 3) {
            case 2:
                Arr_remove(&a, i - 1);
                break;
            default:
                Arr_add(&a, i);
        }
    }
    assert(a.count = TEST_LIMIT);

    for (int i = 0; i < TEST_LIMIT; i++) {
        assert(Arr_find(&a, 3 * i));
        assert(!Arr_find(&a, 3 * i + 1));
        assert(!Arr_find(&a, 3 * i + 2));
    }

    for (int i = 0; i < TEST_LIMIT * 3; i++) {
        switch (i % 3) {
            case 0:
                Arr_remove(&a, i);
                break;
            case 1:
                Arr_add(&a, i);
            case 2:
                Arr_remove(&a, i - 1);
                break;
        }
    }
    assert(a.count == 0);
    Arr_deinit(&a);

    return 0;
}

