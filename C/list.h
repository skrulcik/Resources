/** list.h - Linked List
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

struct list;
typedef struct list list;
typedef void (free_func_type)(void *); /* To free data elements if needed */


/* list_style
 *
 * See list style description in file header.
 */
typedef enum {
    COPY,
    NOCOPY
} list_style;

/* list_settings
 *
 * Defines the settings options available for this linked list implementation.
 *
 * Note that if `copy_style` is set to `NOCOPY` then `elem_size` and 
 * `elem_free` are ignored. Otherwise, they must be explicitly set.
 */
typedef struct list_settings {
    list_style copy_style;
    size_t elem_size;
    free_func_type *elem_free;
} list_settings;


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
list *list_init(list_settings *settings);

/* list_free
 *
 * Free list object itself, and remaining data
 *
 * For COPY lists, the copied data will be freed automatically. For NOCOPY
 * lists, if the user wants data to be freed, they must iterated throught the 
 * list to manually free it first. This is to ensure the invariant that NOCOPY
 * lists never mutate data.
 */
void list_free(list *l);

/* list_length
 *
 * Returns the number of elements currently in the list
 */
int list_length(list *l);

/* list_append
 *
 * Add data to end of list, O(1) time. `list_append` is preferred over
 * `list_insert` when applicable.
 */
void list_append(list *l, void *elem);
/* list_prepend
 *
 * Add data to beginning of list, O(1) time.
 */
void list_prepend(list *l, void *elem);
/* list_insert
 *
 * Add data to list in nth position. Takes O(n) time. `list_prepend` is preferred 
 * over `list_insert` when applicable.
 *
 * Requires: 0 <= index <= list_length(l)
 *
 */
void list_insert(list *l, int index, void *elem);

/* list_remove_nth
 *
 * Remove the nth element of the list. Runs in O(n) time, where 'n' is the 
 * parameter, not length of list.
 *
 * Requires: n < list_length(l)
 */
void list_remove_nth(list *l, int n);
/* list_nth
 *
 * Retrieves the nth element of the list. Runs in O(n) time where 'n' is the
 * parameter, not length of list.
 *
 * Requires: n < list_length(l)
 */
void *list_nth(list *l, int n);

/* print_list
 *
 * Prints a visual representation of the list to the terminal
 */
void list_print(list *l);


