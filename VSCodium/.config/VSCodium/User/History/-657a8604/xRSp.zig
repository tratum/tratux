const std = @import("std");
const print = std.debug.print;


const addingError = error {
    IntegerOverflowHigh,
    IntegerOverflowLow
};
