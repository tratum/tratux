const std = @import("std");
const print = std.debug.print;

const MAX_INT:i32 = 2147483647;
const MIN_INT:i32 = -2147483647;

const addingError = error {
    IntegerOverflowHigh,
    IntegerOverflowLow
};

fn add(a:i32, b:i32) addingError!i32 {
    var temp:i64 = a;
    temp += b;
}
