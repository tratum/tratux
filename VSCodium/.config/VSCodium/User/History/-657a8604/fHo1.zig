const std = @import("std");
const print = std.debug.print;

const MAX_INT:i32 = 2147483647;
const MIN_INT:i32 = -2147483647;

const addingError = error {
    IntegerOverflowHigh,
    IntegerOverflowLow
};
