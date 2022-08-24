# Zig-Morton

A Tiny library for doing encoding/decoding of Morton Codes (also known as Z-Order Curves).

**Definition** A Morton Code or a Z-Order Value is the value produced by doing bitwise interleaving of the input values.

Morton Code and Z-Order Value is used interchangeably throughout the codebase and documentation. They both mean the same thing.

## TODO

- [ ] Add a Decoder
- [ ] Support for encoding/interleaving 3 (and maybe more) input values
- [ ] Support for adding, subtracting and incrementing the Z-values
- [ ] Support for Ordering data by the Z-values (aka Z-Ordering)

## References

[1] https://en.wikipedia.org/wiki/Z-order_curve

[2] https://github.com/cryptocode/bithacks#InterleaveTableObvious