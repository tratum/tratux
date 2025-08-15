const std = @import("std");

pub fn main() void {
    hw();
    add(10, 12);
}

fn hw() void {
    std.debug.print("Hello World\n", .{});
}

fn add(a:i32, b:i32) void {
    const res: i32 = a+b;
    std.debug.print("{d}\n", .{res});
}

fn multiply(a:u32, b:u32) void {
    const res: u32 = a*b;
    
}