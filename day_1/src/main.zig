//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");

pub fn main() !void {
    const input = try read_input();
    var lines = std.mem.splitSequence(u8, input, "\n");

    var left_list = std.ArrayList(i32).init(std.heap.page_allocator);
    var right_list = std.ArrayList(i32).init(std.heap.page_allocator);
    defer left_list.deinit();
    defer right_list.deinit();

    // Iterate through each line
    while (lines.next()) |line| {
        var parts = std.mem.splitSequence(u8, line, "   ");
        const left = parts.next() orelse return error.InvalidFormat;
        const right = parts.next() orelse return error.InvalidFormat;

        const left_num = try std.fmt.parseInt(i32, left, 10);
        const right_num = try std.fmt.parseInt(i32, right, 10);
        try left_list.append(left_num);
        try right_list.append(right_num);
    }

    // sort the lists
    std.mem.sort(i32, left_list.items, {}, std.sort.asc(i32));
    std.mem.sort(i32, right_list.items, {}, std.sort.asc(i32));

    const sum = try compare_lists(left_list, right_list);
    std.debug.print("sum: {}\n", .{sum});
}

fn read_input() ![]const u8 {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const file_contents = try file.readToEndAlloc(std.heap.page_allocator, 1024 * 1024);
    return file_contents;
}

fn compare_lists(left_list: std.ArrayList(i32), right_list: std.ArrayList(i32)) !i32 {
    var sum: i32 = 0;

    // check if the lists are the same length
    if (left_list.items.len != right_list.items.len) {
        return error.ListsNotSameLength;
    }

    // get each item of the list and compare the difference between the two
    for (right_list.items, 0..) |right, i| {
        const left = left_list.items[i];
        const diff = if (left > right)
            left - right
        else if (left < right)
            right - left
        else
            0;
        sum += diff;
    }

    // return the sum
    return sum;
}
