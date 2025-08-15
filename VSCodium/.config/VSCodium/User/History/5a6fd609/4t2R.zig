const std = @import("std");

// A Union is a data structure that allows a variable to hold one value from a set of different types, but only one at a time.

// All Possible fields share the same memory location which means the union's size is determined by it's largest member

// Union can be of 2 types in Zig
// --> Tagged Union [It's represented by union(enum)] and
// --> Untagged Union [It's represented by union{ } ]

const number = union(enum) { small: u8, medium: u16, large: u32 };

fn getUnion() number {
    const num_union = number{ .small = 10 };
    return num_union;
}

fn showUnion() void {
    var num = number{ .small = 200 };
    std.debug.print("Number = {}\n", .{num.small});
    std.debug.print("number small is of type: {}\n", .{@TypeOf(num.small)});
    num.small -= 10;

    num = number{ .medium = 1000 };
    std.debug.print("Number = {}\n", .{num.medium});
    std.debug.print("Number Medium is of type: {}\n", .{@TypeOf(num.medium)});

    num = number{ .large = 40000 };
    std.debug.print("Number = {}\n", .{num.large});
    std.debug.print("Number Large is of type: {}\n", .{@TypeOf(num.large)});
}

// -----------------------------------------------------------------------------------------

// Enums
// Enums i.e short for Enumeration is a data type that consists of a set of named values. these values are used to represent options/categories

const directions = enum { North, South, East, West };

fn direction() void {
    const dir = directions.North;
    switch (dir) {
        directions.North => std.debug.print("Going Up\n", .{}),
        directions.South => std.debug.print("Going Down\n", .{}),
        directions.East => std.debug.print("Going Right\n", .{}),
        directions.West => std.debug.print("Going Left", .{}),
    }
}

// The Ordinal value starts from 0 meaning the first option of an enum will be zero i.e. north and so on and so forth

// We can also override the ordinal values of an enum
const nums = enum(u4) {
    one = 1,
    two = 2,
    three = 3,
};

// We can also override only some values.
const val = enum(u4) {
    a,
    b = 8,
    c,
    d = 4,
    e,
};

// We can also define methods inside enums
const suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,

    pub fn isClub(self: suit) bool {
        return self == suit.clubs;
    }
};
// To call the method inside the enum we can call it like this => suit.clubs.isClub

// Printing values of an enum from their ordinal value

fn printingEnums() void {
    std.debug.print("Printing Enums\n", .{});
    std.debug.print("Overriding Values of enums: ", .{});
    std.debug.print("{} ", .{@intFromEnum(nums.one)});
    std.debug.print("{} ", .{@intFromEnum(nums.two)});
    std.debug.print("{} ", .{@intFromEnum(nums.three)});
    std.debug.print("\nOverriding Some Ordinal Values: ", .{});
    std.debug.print("{} ", .{@intFromEnum(val.a)});
    std.debug.print("{} ", .{@intFromEnum(val.b)});
    std.debug.print("{} ", .{@intFromEnum(val.c)});
    std.debug.print("{} ", .{@intFromEnum(val.d)});
    std.debug.print("{} \n", .{@intFromEnum(val.e)});
}

// -----------------------------------------------------------------------------------------

// Structs

// A Struct is a user-defined data type that groups together different types of variables in a single type.

// It's made up of a single contiguous block of memory

const point = struct {
    x: f16,
    y: f16,
};

//declaring an instance of a struct
// const p: point = .{
//     .x = 0.14,
//     .y = 0.12,
// };

fn printingStructs() void {
    var p = point{ .x = 4.3, .y = 3.2 };
    std.debug.print("First Point Coordinates are {d},{d}\n", .{ p.x, p.y });
    p = point{ .x = 3.8, .y = 2.3 };
    std.debug.print("Second Point Coordinates are {d},{d}\n", .{ p.x + 0.3, p.y + 0.2 });
}

// Structs can also contain values by default
const config = struct {
    debug_mode: bool = false,
    max_users: u32 = 100,
};

// Structs can contain functions within itself
const rectangle = struct {
    width: f16,
    height: f16,

    pub fn area(self: rectangle) f32 { // here self is a value which is a copy of the rectangle struct
        return self.width * self.height;
    }

    // pub fn area(self: *rectangle) f32 { 
           // here self is a pointer (a variable that stores the memory address of another variable) of the rectangle struct
    //     return self.width * self.height;
    // }
};

// Structs can also be inline and anonymous usage
fn inlineStruct() void {
    const data = struct {
        name: []const u8,
        age: u8,
    }{.name = "Alice",.age=30};

    std.debug.print("Name: {s}, Age: {}\n", .{data.name, data.age});
}

// Tuples are just structs with numbered fields
fn tuples() void {
    const tuple = .{"alice", 42};
    std.debug.print("Name: {s}, Age: {}\n", .{tuple[0],tuple[1]});
}

// -----------------------------------------------------------------------------------------

pub fn main() void {
    //showUnion();
    //direction();
    //printingEnums();
    printingStructs();
    inlineStruct();
    tuples();
}
