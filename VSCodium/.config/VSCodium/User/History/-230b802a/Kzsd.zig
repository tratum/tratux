const std = @import("std");
const print = std.debug.print;

// This zig programs shows/tries the conversion of Signed and Unsigned Integers

pub fn main() void {
    //conversion1();
    //conversion2();
    //conversion3();
    convertingSimilarTypes();
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

fn valueFitsinU8(value:i8) bool {
    const max:u8 = std.math.maxInt(u8);
    if (value <= max) {
        if (value >= 0) return true;
    }
    return false; 
}

fn valueFitsinI8(value:u8) bool {
    const max:i8 = std.math.maxInt(i8);
    if (value <= max) {
        if (value >= 0) return true;
    }
    return false;
}

fn convertToU8(input:i8) u8 {
    if (valueFitsinU8(input) == true) return @intCast(input);
    print("err: the input {} doesn't fit in a u8\n", .{input});
    return 0;
}

fn convertToI8(input:u8) i8 {
    if (valueFitsinI8(input)) return @intCast(input);
    print("err: the input {} doesn't fit in a i8\n", .{input});
    return 0;
}

fn conversion3() void {
    const num1:i8 = -10;
    const num2:u8 = convertToU8(num1);
    print("num 1: {}\n", .{num1});
    print("num2: {}\n", .{num2});
}

fn convertingSimilarTypes() void {
    // const num1:i32 = 100000000;
    // const num2:i16 = num1;

    // print("Num1: {}", .{num1});
    // print("Num2: {}", .{num2});

    // This will not run as an i32 value can't fit inside a i16 value and zig will not let us do this but there is a way to bypass it

    const num1:u32 = 100000000;
    const num2:u16 = @truncate(num1);

    print("Num1: {}\n", .{num1});
    print("Num2: {}\n", .{num2});

    // WHat happened was that we removed the extra bits from the num1 to fit it into num2

    print("Binary Representation: {b}\n", .{num1});
    print("Binary Representation: {b}\n", .{num2});

}
