# Day 1: Number Pair Processing

This solution implements a program that processes pairs of numbers from an input file and calculates their differences.

## Problem Description

The program reads a file containing pairs of numbers separated by spaces. For each pair, it:

1. Parses the numbers into separate lists
2. Sorts both lists
3. Calculates the absolute difference between corresponding numbers
4. Sums up all differences to produce a final result

## Implementation Details

### Key Components

- **File Processing**: Uses Zig's standard library for file operations
- **Data Structures**: Implements `ArrayList` for dynamic number storage
- **Memory Management**: Proper allocation and deallocation using page allocator
- **Error Handling**: Robust error checking and propagation

### Core Functions

```zig
fn main() !void              // Main program entry point
fn read_input() ![]const u8  // Handles file reading
fn compare_lists() !i32      // Processes and compares number lists
```

## Building and Running

To build and run the solution:

```bash
zig build
./zig-out/bin/day_1
```

## Input Format

The input file (`input.txt`) should contain pairs of numbers, one pair per line:

```bash
number1   number2
number1   number2
...
```

## Output

The program outputs the sum of absolute differences between corresponding numbers in the sorted lists.

## Technical Learnings

- File handling in Zig
- Memory management with proper cleanup
- Dynamic array handling using `ArrayList`
- String parsing and conversion
- Error handling patterns in Zig
- Sorting algorithms implementation
