const std = @import("std");
const print = std.debug.print;

// This zig programs shows/tries the conversion of Signed and Unsigned Integers

pub fn main() void {
    //conversion1();
    conversion2();
}

fn conversion1() void {
// When converting similar type integers it will not give an err
    const num1:i8 = 10;
    const num2:u8 = num1;
    const num3:i8 = num2;

    print("num 1: {}\n", .{num1});
    print("num2: {}\n", .{num2});
    print("num3: {}\n", .{num3});
}

fn conversion2() void {

    // This Function will give an err and it will not be able to convert a singed integer to an unsigned integer
    const num1:i8 = -10;
    const num2:u8 = num1;
    const num3:i8 = num2;

    print("num 1: {}\n", .{num1});
    print("num2: {}\n", .{num2});
    print("num3: {}\n", .{num3});
}

fn valueFitsinU8() void {
    const max = std. 
}
