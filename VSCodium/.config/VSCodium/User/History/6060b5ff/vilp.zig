const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const char_array =[5]u8 {'h','e','l','l','o'}; // collection of letters
    const char_slice:[]const u8 = "hello"; // slice of characters
    const inferred_array_slice = char_array[0..]; // slice of the first array
    const infered_slice = "hello"; // infered slice of u8 chars

    const char_slice_lenght_2 = char_array[0..3];

    print("\nCharacter Array = {c}{c}{c}{c}{c}", .{char_array[0], char_array[1], char_array[2], char_array[3], char_array[4]});
    print("\nCharacter Slice = {s}", .{char_slice});
    print("\nInfered Array Slice = {s}", .{inferred_array_slice});
    print("\nInfered Slice = {s}", .{infered_slice});
    print("\nInfered Array Slice with length 2 = {s}\n", .{char_slice_lenght_2});


    const num_array = [_]u8 {1,2,3,4,5,6,7,8,9,10}; // Number Array
    const num_slice = num_array[0..5];

    // For Loops

    print("Number Slices: ", .{});
    for (num_slice) |num| {
        print("{}", .{num});
    }
    print("\n", .{});

    print("Number Array: ", .{});
    for (num_array) |num| {
        print("{d}", .{num});
    }
    print(, .{})

}