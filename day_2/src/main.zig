const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var safe_reports: u16 = 0;
    var report = std.ArrayList(u8).init(arena.allocator());

    var lines = std.mem.tokenizeAny(u8, input, &.{ '\r', '\n' });
    // Process each line from input
    while (lines.next()) |line| {
        // Extract all numbers from the current line
        var levels = std.mem.tokenizeScalar(u8, line, ' ');
        while (levels.next()) |level| {
            try report.append(try std.fmt.parseInt(u8, level, 10));
        }

        if (isSafeReport(report.items)) {
            safe_reports += 1;
        }

        report.clearRetainingCapacity();
    }

    std.debug.print("safe reports: {d}\n", .{safe_reports});
}

/// Checks if a sequence of numbers is considered safe.
/// A sequence is safe when:
/// 1. All numbers are either strictly increasing or strictly decreasing
/// 2. The difference between adjacent numbers is not greater than 3
fn isSafeReport(numbers: []const u8) bool {
    // If less than 2 numbers present, sequence is safe by default
    if (numbers.len < 2) return true;

    // Determine the direction using first two numbers
    const first_number = numbers[0];
    const second_number = numbers[1];

    // Check if sequence should be increasing or decreasing
    const is_ascending = second_number > first_number;

    // Check each pair of numbers in the sequence
    var previous_number = first_number;
    for (numbers[1..]) |current_number| {
        // 1. Verify direction consistency
        const current_is_ascending = current_number > previous_number;
        const current_is_same = current_number == previous_number;

        if (current_is_same) return false; // Equal numbers not allowed
        if (current_is_ascending != is_ascending) return false; // Direction change not allowed

        // 2. Check if difference is within allowed range
        const difference = if (current_number > previous_number)
            current_number - previous_number
        else
            previous_number - current_number;

        if (difference > 3) return false; // Difference too large

        previous_number = current_number;
    }

    return true; // All checks passed
}
