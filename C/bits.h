/*
 * Useful bit-manipulation functions.
 */

#define GET_BYTE(i,p)       ((((*(p))&(0xFF<<((i)*8)))>>((i)*8))&0xFF)
#define SET_BYTE(i,p,x)     (*(p)=(((*(p))&(~(0xFF<<((i)*8))))|(((x)&0xFF)<<((i)*8))))

#define GET_BIT(i,p)       ((((*(p))&(0x1<<(i)))>>(i))&0x1)
#define SET_BIT(i,p,x)     (*(p)=(((*(p))&(~(0x1<<(i))))|(((x)&0x1)<<(i))))

