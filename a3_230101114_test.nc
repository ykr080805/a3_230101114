// testing keywords
int float char double void
short long signed unsigned
if else while for do
break continue return case default
static _Bool

// some identifiers
int main(void) {
    int num = 42;
    float avg = 78.5;
    char ch = 'x';
    char *msg = "hello world";
    unsigned long big_val = 99999;
    signed short small = 3;
    double pi = 3.14;
    static _Bool done = 0;

    // arithmetic
    int sum = num + 5;
    int diff = num - 2;
    int prod = num * 3;
    int quot = num / 7;
    int rem = num % 6;

    // relational + logical
    if (num > 10 && num < 100) {
        num++;
    } else if (num == 0 || num != 42) {
        num--;
    }

    // bitwise
    int a = num & 0;
    int b = num | 1;
    int c = num ^ 3;
    int d = ~num;
    int e = num << 2;
    int f = num >> 1;

    // assignment operators
    num += 10;
    num -= 5;
    num *= 2;
    num /= 3;
    num %= 4;
    num <<= 1;
    num >>= 1;
    num &= 7;
    num ^= 3;
    num |= 1;

    // for loop
    for (int i = 1; i <= 10; i++) {
        sum = sum + i;
    }

    // while
    while (num >= 0) {
        num = num - 1;
    }

    // do while
    do {
        num = num + 1;
    } while (num < 5);

    // switch
    switch (ch) {
        case 'a':
            break;
        case 'b':
            continue;
        default:
            num = 0;
    }

    // pointer and arrow stuff
    int *ptr = &num;
    // ptr->member  (just testing punctuator)

    // ternary
    int result = (num > 0) ? num : 0;

    // various constants
    0
    1
    255
    .75
    10.
    0.001

    // char constants with escapes
    '\n'
    '\t'
    '\\'
    '\''
    '\"'

    // string with escapes
    "line1\nline2"
    "tab\there"
    "quote: \""
    "backslash: \\"
    ""

    // testing ... punctuator
    // void func(int x, ...);

    // comma and hash
    int p, q, r;
    #

    /* multi line comment
       should be ignored by the lexer
       completely */

    /* another block comment */

    return 0;
}
