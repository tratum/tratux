const std = @import("std");

pub fn main() void {

}

fn arrayIndexes () void {
    const num_arr = []u8 {1,2,3,4,5,6,7,8,9,10};
    const value = 5;
    var index:usize = 0;
    for (0..num_arr.len) |i| {
        if (num_arr[i] == value) index = i;
    }
    std.debug.print("index found: {}\n", .{index});
    std.debug.print("value at index: {}", .{});
}
