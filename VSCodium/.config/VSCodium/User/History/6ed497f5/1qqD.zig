const std = @import("std");

pub fn main() void {
    hw();
    add(10, 12);
}

fn hw() void {
    std.debug.print("Hello World\n", .{});
}

fn add(a:i32, b:i32) i32 {
    const res: i32 = a+b;
    return res;
}