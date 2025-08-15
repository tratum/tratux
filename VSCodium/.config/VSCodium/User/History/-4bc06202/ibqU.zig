//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

export fn printhw() void {
    std.debug.print("Hello World\n", .{});
}

pub fn multiply(a:u8, b:u8) void {
    const res: u8 = a*b;
    std.debug.print("{d} * {d} = {d}\n",.{a,b,res});
}

test "basic add functionality" {
    try std.testing.expect(add(3, 7) == 10);
}
