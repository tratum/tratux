const std = @import("std");
const print = std.debug.print;
pub fn main() void {
    print("Understanding Loops\n", .{});
    forLoops();
}

fn forLoops() void {
    print("For Loops\n", .{});
    for (0..11) |i| {
        print("{}, ", .{i});
    }
    print("\n", .{});

    // If we don't use the i variable in our program then we'll get an error or we can discard the error with the wildcard placeholder
    print("Not Using the For Loop Variable\n", .{});
    for (0..6) |i| {
        _ = i;
    }

    // There is also  a way to not even initialize a variable in the first place
    print("Empty For Loop\n", .{});
    for(0..6) |_| {

    }

    // For a For Loop when we intialize a pointer variable it can only be of bit‑width which is exactly equal to the size of the pointer on the target platform

    //  var index: i32 = 0;
    //  for (0..4) |i| {
    //     index = i;
    //  }
    // The above program will give an error because 64 bits can't fit into 32 bits

    var index:u64 = 0;
    for(0..6) |i| {
        index = i;
    }
    print("u64 Index is {}\n", .{index});

    // The above program will also give an error because unsigned 32-bit int cannot represent all possible unsigned 64-bit values


    // There is no built-in functionality to Print the for loop in reverse but we can use while loops to do so
    // Here is the For Loop way to do it:

    index = 10;
    for(0..index+1) |_| {
        print("{}, ", .{index});
        if (index==0) break;
        index -=1;
    }
    print("\n", .{});


    // Inline For Loops
    // There is a small overhead for using inline for loop as every time we cycle through the loop there will be a check to see if the condition has been met

    const arrSize = 10;
    var temp:i32 = 0;
    var values = [_]i32 {0,0,0,0,0,0,0,0,0,0};

    inline for(0..arrSize) |i| {
        values[i] = temp;
        temp +=1;
    }

    // To break from loops we use the keyword 'break'

    var tempindex:i32 = 0;
    for (0..10) |_| {
        tempindex +=10;
        if(tempindex > 50) {
            print("Index is over 50, break loop\n", .{});
            break;
        }
        print("temp index is {}\n", .{tempindex});
    }

    // the 'continue' keyword does the same but it will immediately stop the current iteration, skipping any code that follows it in the body and continue to the loop's next iteration.

    var tempIndex:i32 = 0;
    for (0..10) |_| {
        tempIndex += 10;
        if (tempIndex == 20) {
            continue;
        }
        if (tempIndex > 50) {
            break;
        }
        print("Temp Index is {}\n", .{tempIndex});
    }

    // We can Nest Loops like this

    const multidimensionalArray = [3][2]i16{
        [_]i16{1,2},
        [_]i16{3,4},
        [_]i16{5,6}
    };
    for (0..3) |x| {
        for (0..2) |y| {
            const number:i16 = multidimensionalArray[x][y];
            print("number [{},{}] = {}\n", .{x,y,number});
        }
    }
    print("\n", .{});

    // We Can also label loops. If sometimes you may want to break out of an outer loop entirely and not just the inner one.

    xaxis: for (0..3) |x| {  // this labels this loop as xaxis
        yaxis: for (0..2) |y| {
            const traverser = multidimensionalArray[x][y];
            print("The Numbers are [{},{}] = {}\n", args: anytype)

        }
    } 
}