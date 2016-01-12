#include <stdlib.h>
#include <stdio.h>
#include "list.h"

void test(int expression, int *success, int *count, int lineno) {
    if (expression) {
        *success = *success + 1;
    } else {
        printf("Failed test on line %d\n", lineno);
    }
    *count = *count + 1;
}

void test_list() {
    int wins = 0, trials = 0;
    printf("LIST TESTS:\n");

    list_settings nc_settings;
    nc_settings.copy_style = NOCOPY;

    list *l1 = list_init(&nc_settings);
   
   
    printf("Testing successful init...\n"); 
    test(l1 != NULL, &wins, &trials, __LINE__);
    test(list_length(l1) == 0, &wins, &trials, __LINE__);

    printf("Testing insert...\n");
    list_insert(l1, 0, (void *)2);
    test(list_length(l1) == 1, &wins, &trials, __LINE__);
    list_insert(l1, 1, (void *)3);
    test(list_length(l1) == 2, &wins, &trials, __LINE__);
    list_insert(l1, 0, (void *)0);
    test(list_length(l1) == 3, &wins, &trials, __LINE__);
    list_insert(l1, 1, (void *)1);
    test(list_length(l1) == 4, &wins, &trials, __LINE__);

    printf("Testing nth...\n");
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 3) == 3, &wins, &trials, __LINE__);

    printf("Testing remove nth...\n");
    list_remove_nth(l1, 3);
    test(list_length(l1) == 3, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 2, &wins, &trials, __LINE__);
    list_remove_nth(l1, 1);
    test(list_length(l1) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 2, &wins, &trials, __LINE__);
    list_remove_nth(l1, 0);
    test(list_length(l1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 2, &wins, &trials, __LINE__);
    list_remove_nth(l1, 0);
    test(list_length(l1) == 0, &wins, &trials, __LINE__);

    printf("Testing append...\n");
    list_append(l1, (void *)0);
    test(list_length(l1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    list_append(l1, (void *)1);
    test(list_length(l1) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    list_append(l1, (void *)2);
    test(list_length(l1) == 3, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 2, &wins, &trials, __LINE__);
    list_append(l1, (void *)3);
    test(list_length(l1) == 4, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 3) == 3, &wins, &trials, __LINE__);
    
    for (int i = 0; i < 4; i++) {
        list_remove_nth(l1, 0);
    }

    printf("Testing prepend...\n");
    list_prepend(l1, (void *)3);
    test(list_length(l1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 3, &wins, &trials, __LINE__);
    list_prepend(l1, (void *)2);
    test(list_length(l1) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 3, &wins, &trials, __LINE__);
    list_prepend(l1, (void *)1);
    test(list_length(l1) == 3, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 3, &wins, &trials, __LINE__);
    list_prepend(l1, (void *)0);
    test(list_length(l1) == 4, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 0) == 0, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 1) == 1, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 2) == 2, &wins, &trials, __LINE__);
    test((long)list_nth(l1, 3) == 3, &wins, &trials, __LINE__);


    printf("List tests complete: %d/%d\n", wins, trials);
    if (wins == trials) {
        printf("PASSED!");
    } else {
        printf("FAILED");
    }
    printf("\n\n");
}

int main(int argc, char *argv[]) {
    printf("Beginning tests...\n");
    test_list();
    printf("All tests completed.\n");
}


