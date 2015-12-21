/* htable.c
 * Scott Krulcik 12/8/15
 *
 * Hash table will store pointers and size information about generic data 
 * it is given. It *will* free the data when needed if a free function is given.
 *
 */
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "csapp.h"
#include "hasher.h"

typedef struct hash_item {
    char *key;
    void *data;
    size_t dsize;
    struct hash_item *next;
} hash_item;

struct hash_table {
    int N;
    free_fn free_data;
    hash_item *table[];  
};

/* Private Functions */
int hash(const char *key);
int hash_index(HT ht, const char *key);
void hash_item_free(HT ht, hash_item *item);
hash_item *ht_existing(HT ht, const char *key);

/* Hashing */
/* hash31 from 15-122 */
int hash(const char *key) {
    int length = strlen(key);
    if (length == 0)
        return 0;
    if (length == 1)
        return key[0];
    return (hash(key+1)*31 + (int)key[0])&0x7FFFFFFF;
}
/* hash_index - returns always valid table index for a given key */
int hash_index(HT ht, const char *key) {
    return (hash(key) % (ht->N));
}


/* ht_init - allocate hash table object
 *      Requies num_buckets > 0 
 *      If free_data is NULL, it works, but will have memory leaks unless
 *          you want to free the data you put in yourself (not recommended)
 */
HT ht_init(int N, free_fn free_data) {
    assert(N > 0);
    HT ht = Malloc(sizeof(struct hash_table) + N * sizeof(hash_item *));
    ht->N = N;
    ht->free_data = free_data;
    return ht;
}
/* hash_item_free - free the information inside of a hash table element, 
 *      and the element itself. Only frees data inside if ht->free_data
 *      is defined. */
void hash_item_free(HT ht, hash_item *item) {
    Free(item->key);
    if (ht->free_data != NULL) {
        ht->free_data(item->data);
    }
    Free(item);
}

/* ht_free - free entire hashtable. Also frees data inside of it if
 *      ht->free_data != NULL */
void ht_free(HT ht) {
    int i;
    for (i=0; i < ht->N; i++) {
        hash_item *node = ht->table[i];
        while (node != NULL) {
            hash_item *old_node = node;
            node = node->next;
            hash_item_free(ht, old_node);
        }
    }
    Free(ht);
}

/* ht_update - Adds (key, data) to hash table, assuming data is dsize bytes.
 *      If the key is already in the table, the data for the key will be
 *      replaced */
void ht_update(HT ht, char *key, void *data, size_t dsize) {
    hash_item *new_node = ht_existing(ht, key);
    int create_new = (new_node == NULL);
    create_new = create_new;
    if (create_new) {
        new_node = (hash_item *)Malloc(sizeof(hash_item));
        new_node->key = (char *)Malloc(strlen(key) + 1);
        memset(new_node->key, 0, strlen(key) + 1);
        strcpy(new_node->key, key);
    } else {
        if (ht->free_data != NULL)
            ht->free_data(new_node->data);
    }
    new_node->data = data;
    new_node->dsize = dsize;

    if (create_new) {
        // Insert new node into list
        int hidx = hash_index(ht, key);
        new_node->next = ht->table[hidx];
        ht->table[hidx] = new_node;
    }
}

/* ht_remove - If key is in ht, deletes corresponding entry. Otherwise does
 *      nothing at all */
void ht_remove(HT ht, char *key) {
    int hidx = hash_index(ht, key);
    hash_item *node = ht->table[hidx];
    if (node == NULL)
        return;
    else if (strcmp(node->key, key)) {
        ht->table[hidx] = node->next;
        hash_item_free(ht, node);
        return;
    }
    while (node->next != NULL) {
        if (strcmp(node->next->key, key) == 0) {
            hash_item *match = node->next;
            node->next = match->next;
            hash_item_free(ht, match);
        }
        node = node->next;
    }
}

/* ht_existing - returns hash item for a given key if it exists, else NULL */
hash_item *ht_existing(HT ht, const char *key) {
    hash_item *node = ht->table[hash_index(ht, key)];
    while (node != NULL) {
        if (strcmp(node->key, key) == 0)
            return node;
        node = node->next;
    }
    return NULL;
}

/* ht_retrieve - If key is in table, puts pointer to data into *datap,
 *      puts length in bytes of data into *dsizep, and returns 1.
 *      If key is not in table, doesn't modify datap or dsizep, and returns 0.
 */
int ht_retrieve(HT ht, char *key, void **datap, size_t *dsizep) {
    hash_item *node = ht_existing(ht, key);
    if (node != NULL) {
        if (datap != NULL)
            *datap = node->data;
        if (dsizep != NULL)
            *dsizep = node->dsize;
        return 1;
    }
    return 0; // Not found
}


/* ht_fold - Given an associative function (which must accept NULL arguments)
 *      merge all data in the table according to the `fold_data`, and return the
 *      final void * creating by merging all data together.
 *
 *      Had to do this because I wasn't considering looking for the LRU when I
 *      decided to do a hash table instead of just a list.
 */
void *ht_fold(HT ht, fold_fn fold_data) {
    hash_item *node;
    void *res = NULL;
    int i;
    for (i = 0; i < ht->N; i++) {
        if (node == NULL) {
            node = ht->table[i];
            res = fold_data(node->data, NULL);
        }
        while (node != NULL && node->next != NULL) {
            res = fold_data(node->data, node->next->data);
        }
    }
    return res;
}






