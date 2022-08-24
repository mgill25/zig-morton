const std = @import("std");
const testing = std.testing;

// Takes a type and returns back another type with twice the number of bits.
fn DoubleSize(comptime inputType: type) type {
    return @Type(.{
        .Int = .{
            .signedness = @typeInfo(inputType).Int.signedness, 
            .bits = @bitSizeOf(inputType) * 2,
        },
    });
}

// Takes a type and returns back another type with half the number of bits.
fn HalfSize(comptime inputType: type) type {
    return @Type(.{
        .Int = .{
            .signedness = @typeInfo(inputType).Int.signedness, 
            .bits = @bitSizeOf(inputType) / 2,
        },
    });
}

// Interleave the bits of a and b the "obvious" way.
// Source: http://www.graphics.stanford.edu/~seander/bithacks.html#InterleaveTableObvious
pub fn morton2DEncode(comptime T: type, comptime a: T, comptime b: T) DoubleSize(T) {
    var index: HalfSize(T) = 0;
    var z_value: DoubleSize(T) = 0;
    const one: DoubleSize(T) = 1;
    while (index < @bitSizeOf(T)) : (index += 1) {
        const mask: DoubleSize(T) = one << index;
        const a_masked = a & mask;
        const b_masked = b & mask;
        const a_shifted = a_masked << index;
        const b_shifted = b_masked << (index + 1);
        z_value |= (a_shifted | b_shifted);
    }
    return z_value;
}

test "bit size of function test" {
    try testing.expect(@bitSizeOf(u8) == 8);
}

test "generic morton encode interleaving bits wikipedia example" {
    try testing.expect(morton2DEncode(u8, 19, 47) == 2479);
}

test "double the bits of any integer type" {
    try testing.expect(DoubleSize(u1) == u2);
    try testing.expect(DoubleSize(u2) == u4);
    try testing.expect(DoubleSize(u3) == u6);
    try testing.expect(DoubleSize(u6) == u12);
    try testing.expect(DoubleSize(u8) == u16);
    try testing.expect(DoubleSize(u16) == u32);
    try testing.expect(DoubleSize(u32) == u64);
    try testing.expect(DoubleSize(u64) == u128);
}

test "halve the bits of any integer type" {
    try testing.expect(HalfSize(u2) == u1);
    try testing.expect(HalfSize(u4) == u2);
    try testing.expect(HalfSize(u6) == u3);
    try testing.expect(HalfSize(u12) == u6);
    try testing.expect(HalfSize(u16) == u8);
    try testing.expect(HalfSize(u32) == u16);
    try testing.expect(HalfSize(u64) == u32);
    try testing.expect(HalfSize(u128) == u64);
}