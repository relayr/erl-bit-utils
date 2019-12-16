# bit_utils

[![Build Status](https://travis-ci.org/relayr/erl-bit-utils.svg?branch=master)](https://travis-ci.org/relayr/erl-bit-utils) [![Coverage Status](https://coveralls.io/repos/github/relayr/erl-bit-utils/badge.svg?branch=master)](https://coveralls.io/github/relayr/erl-bit-utils?branch=master)

Erlang functions operating on bits. Indexes of bits in byte numbers start at position 0.

## Examples

#### set_bits/2
Create integer of given size that has specific bits set when represented in binary.
```
1> bit_utils:set_bits([0,3,5,7], 8).
{ok,149}
2> 2#10010101.
149
```

#### bits_set/2
Return indexes of set bits in integer of given size.
```
1> N = 2#00100110.
38
2> bit_utils:bits_set(N, 8).
{ok,[2,5,6]}
```

#### lowest_bit_set/1
Return index of lowest bit set (or atom `undefined` if none is set).
```
1> bit_utils:lowest_bit_set(5).
0
2> bit_utils:lowest_bit_set(4).
2
3> bit_utils:lowest_bit_set(0).
undefined
```

#### bytes_to_bits/1, bits_to_bytes/1
Count number of bits in bytes and number of bytes that are needed for set of bits.
```
1> bit_utils:bytes_to_bits(6).
48
2> bit_utils:bits_to_bytes(12).
2
```

#### rest_of_byte_size_alignment/1
Get rest number of bits when aligned to a byte i.e. how many additional bits are needed to align to the byte.
```
1> bit_utils:rest_of_byte_size_alignment(8).
0
2> bit_utils:rest_of_byte_size_alignment(5).
3
```
