const std = @import("std");

pub fn main() void {
    add(10, 12);

}

fn add(a:i32, b:i32) i32 {
    const res = a+b;
    return res;
}