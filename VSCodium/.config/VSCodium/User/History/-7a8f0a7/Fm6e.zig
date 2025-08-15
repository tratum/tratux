const std = @import("std");

pub fn main() void {
    arrayIndexes();
}

fn arrayIndexes (value:u8) void {
    const num_arr = [_]u8 {1,2,3,4,5,6,7,8,9,10};
    var index:usize = 0;
    for (0..num_arr.len) |i| {
        if (num_arr[i] == value) index = i;
    }
    std.debug.print("Value {} found at index {}\n", .{index, num_arr[index]});
}
