const std = @import("std");

pub fn main() !void {
    std.debug.print("8 + 2 = {d}\n", .{lib.add(8, 2)});
    lib.multiply(8, 10);

    // Different types of Data Types

    // Signed Bit Integer represents both Positive and Negative value whereas the unsigned integer can only represent non-negative values

    // For an i2 Signed Integers the range is from -2 to +1
    // For an u2 Unsigned Integer the range is from 0 to 3

    const num:i2 = -1; // for Signed Integer Data Types the bits can range from anwhere between 1-128
    const unsigned_num:u2 = 2; // For Unsigned integer data types also the bits can range from 1-128
    const istrue:bool = true; // boolean data type
    const letter:u8 = 'a'; 
    const wordArray = [5]u8 {'h','e','l','l','o'}; // Array Data Type
    const word: []const u8 = "Hello"; // Slice Data Type

    const float:f16 = 1.256; //Floating Integers can only be f16, f32, f64, f128

    _ = num;
    _ = unsigned_num;
    _ = istrue;
    _ = letter;
    _ = wordArray;
    _ = word;
    _ = float;

    func(10);
    printhw();
}

fn printhw() void {
    const num:i8 = -10;
    const unum:u8 = 10;
    const word = "Hello";
    const letter:u8 = 'a';
    std.debug.print("{d}\n", .{num});
    std.debug.print("{d}\n", .{unum});
    std.debug.print("{s}\n", .{word});
    std.debug.print("{d}\n", .{letter});
}

fn func (a:i8) void {
    //a+= 10; // The Parameters of a function are constant by default
    var mutable:i8 = a;
    mutable+=10;
}

