const std = @import("std");

pub fn main() void {
    arrayIndexes(5);
}

fn arrayIndexes (value:u8) void {
    const num_arr = [_]u8 {5,10,15,20,25,30};
    var index:usize = 0;
    for (0..num_arr.len) |i| {
        if (num_arr[i] == value) index = i;
    }
    std.debug.print("Value {} found at index {} in the array {any}\n", .{value, index, num_arr});
}
