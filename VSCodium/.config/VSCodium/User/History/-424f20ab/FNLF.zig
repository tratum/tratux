const std = @import("std");
const lib = @import("basics_lib");

pub fn main() !void {
    lib.printhw();
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
    const wordArray = [5]u8 {'h','e','l','l','o'};
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

}

fn func (a:i8) void {
    a+= 10; // The 
}

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }

// test "use other module" {
//     try std.testing.expectEqual(@as(i32, 150), lib.add(100, 50));
// }

// test "fuzz example" {
//     const Context = struct {
//         fn testOne(context: @This(), input: []const u8) anyerror!void {
//             _ = context;
//             // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
//             try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
//         }
//     };
//     try std.testing.fuzz(Context{}, Context.testOne, .{});
// }