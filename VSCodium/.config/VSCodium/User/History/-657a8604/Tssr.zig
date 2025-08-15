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
    if (temp > MAX_INT) {
        return addingError.IntegerOverflowHigh;
    }
    if (temp < MIN_INT) {
        return addingError.IntegerOverflowLow;
    }
    return a+b;
}

fn run(a:i32, b:i32) void {
    const res = add(a, b);
    if (res) |value| print("{} + {} = {}\n", .{a, b, value}) // It says that if this is not an error then store the value in the 'value' variable
    else |err| print("Add Error: {} + {} resulted in {}\n", .{a,b,err});  // It says that if it is an error store the error in the 'err' variable
}

pub fn main() !void{
    run(MAX_INT, 1);
    run(MIN_INT, -1);
    run(10, 10);
}