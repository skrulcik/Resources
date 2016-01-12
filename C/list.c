/** list.c - Linked List
 *
 * Generic Linked List Implementation
 *
 * Goal is to provide completely generic linked list implementation that
 * allows you to set copy vs. no-copy, and a free function at initialization.
 *
 * There are two options for list style (specified at creation):
 *  
 *  COPY:   When a pointer is added to the list, its contents are copied into
 *          a new area of memory. The newly allocated memory will be managed
 *          entirely by the list as long as the proper list functions are called.
 *  
 *  NOCOPY: When a pointer is added to the list, its value is copied, so the
 *          user is entirely responsible for managing the data pointed to. The
 *          list will never modify or attempt to free data at the pointer's 
 *          destination.
 *
 * ALL functions (other than `list_init`) have a list parameter `l` which is 
 * _always_ assumed to be non-NULL. 
 *
 */
#include <assert.h>
#include <inttypes.h>
#include <stdint.h>
#include <string.h>
#include "csapp.h"
#include "list.h"


typedef struct node {
    void *data;
    struct node *next;
} node;

struct list {
    /* List data */
    node *start;
    node *end;
    int length;
    /* Settings */
    list_style copy_style;
    size_t elem_size;
    free_func_type *elem_free;
};

/* Private Functions */
int should_copy(list *l);
node *node_for_list(list *l, void *elem);
node *list_nth_node(list *l, int n);


/* Initialize empty list with the given options
 * 
 * Note that the "settings" pointer is not stored, so a pointer to a local
 * variable is suitable. A common use would look like this:
 * 
 * ```
 * list_settings ls;
 * ls.copy_style = NOCOPY;
 * list *l1 = list_init(&ls);
 * ```
 *
 * If settings is NULL, default settings is NOCOPY.
 */
list *list_init(list_settings *settings) {
    list *l = (list *)Malloc(sizeof(list));
    l->start = NULL;
    l->end = NULL;
    l->length = 0;
    if (!settings || settings->copy_style == NOCOPY) {
        l->copy_style = NOCOPY;
        l->elem_size = 0;
        l->elem_free = NULL;
    } else {
        l->copy_style = settings->copy_style;
        l->elem_size = settings->elem_size;
        l->elem_free = settings->elem_free;
    }
    return l;
}

/* list_free
 *
 * Free list object itself, and remaining data
 *
 * For COPY lists, the copied data will be freed automatically. For NOCOPY
 * lists, if the user wants data to be freed, they must iterated throught the 
 * list to manually free it first. This is to ensure the invariant that NOCOPY
 * lists never mutate data.
 */
void list_free(list *l) {
    if (should_copy(l)) {
        node *n = l->start;
        while (n != NULL) {
            l->elem_free(n->data);
            n = n->next;
        }
    }
    Free(l);
}

/* list_length
 *
 * Returns the number of elements currently in the list
 */
int list_length(list *l) {
    return l->length;
}


/* list_append
 *
 * Add data to end of list, O(1) time. `list_append` is preferred over
 * `list_insert` when applicable.
 */
void list_append(list *l, void *elem) {
    node *new_node = node_for_list(l, elem);
    new_node->next = NULL;
    l->end->next = new_node;
    l->end = new_node;
    l->length += 1;
}
/* list_prepend
 *
 * Add data to beginning of list, O(1) time. `list_prepend` is preferred over
 * `list_insert` when applicable.
 */
void list_prepend(list *l, void *elem) {
    node *new_node = node_for_list(l, elem);
    new_node->next = l->start;
    l->start = new_node;
    l->length += 1;
}
/* list_insert
 *
 * Add data to list in nth position. Takes O(n) time.
 *
 * Requires: 0 <= index <= list_length(l)
 */
void list_insert(list *l, int index, void *elem) {
    assert(0 <= index && index <= list_length(l));
    if (index == 0) {
        list_prepend(l, elem);
    } else if (index >= l->length) {
        list_append(l, elem);
    } else {
        node *new_node = node_for_list(l, elem);
        node *preceding = list_nth_node(l, index - 1);
        new_node->next = preceding->next;
        preceding->next = new_node;
        l->length += 1;
    }
}

/* list_remove_nth
 *
 * Remove the nth element of the list. Runs in O(n) time, where 'n' is the 
 * parameter, not length of list.
 *
 * Requires: 0 <= n < list_length(l)
 */
void list_remove_nth(list *l, int n) {
    assert(0 <= n && n < list_length(l));
    node *old_node;
    if (n == 0) {
        old_node = l->start;
        l->start = old_node->next;
    } else {
        node *old_preceding = list_nth_node(l, n - 1);
        old_node = old_preceding->next;
        old_preceding->next = old_node->next;
        if (n == (list_length(l) - 1)) {
            l->end = old_preceding;
        }
    }
    if (should_copy(l)) {
        l->elem_free(old_node->data);
    }
    l->length -= 1;
    Free(old_node);
}
/* list_nth
 *
 * Retrieves the nth element of the list. Runs in O(n) time where 'n' is the
 * parameter, not length of list.
 *
 * Requires: 0 <= n < list_length(l)
 */
void *list_nth(list *l, int n) {
    assert(0 <= n && n < list_length(l));
    node *node = list_nth_node(l, n);
    return node->data; 
}

/* print_list
 *
 * Prints a visual representation of the list to the terminal
 */
void list_print(list *l) {
    printf("|->");
    node *n = l->start;
    int i = 0;
    while (n != NULL) {
        printf("%016"PRIxPTR"->", (uintptr_t)n->data);
        n = n->next;
        if (i % 4 == 3) {
            // 4 is chosen because each object takes 18 chars, so we have at
            // most 4 elements per terminal line.
            printf("\n    ");
        }
        i++;
    }
    printf("END\n");

}


/* Private function implementations */
int should_copy(list *l) {
    return l->copy_style == COPY;
}

node *node_for_list(list *l, void *elem) {
    node *new_node = (node *)Malloc(sizeof(node));
    if (should_copy(l)) {
        // COPY
        new_node->data = Malloc(l->elem_size);
        memcpy(new_node->data, elem, l->elem_size);
    } else {
        // NOCOPY
        new_node->data = elem;
    }
    new_node->next = NULL;
    return new_node;
}

/* Runs in O(n)
 *
 * Requires 0 <= n < list_length(l)
 */
node *list_nth_node(list *l, int n) {
    assert(0 <= n && n < list_length(l));
    node *iter = l->start;
    int i = 0;
    while (i < n) {
        iter = iter->next;
        i++;
    }
    return iter;
}

