/* htable.h
 * Scott Krulcik 12/8/15
 *
 * Generic has table implementation.
 *
 */

struct hash_table;
typedef struct hash_table *HT;
typedef void (*free_fn)(void *);
typedef void *(*fold_fn)(void *, void *);

HT ht_init(int num_buckets, free_fn free_data);
void ht_free(HT ht);

void ht_update(HT ht, char *key, void *data, size_t dsize);
void ht_remove(HT ht, char *key);

int ht_retrieve(HT ht, char *key, void **datap, size_t *dsizep);

void *ht_fold(HT ht, fold_fn fold_data);



