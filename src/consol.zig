pub const std = @import("std");
const sleep = std.time.sleep;

pub const print = std.debug.print;

pub const Cursor = struct {
    pub fn on() void {
        stdout.writeAll("\x1b[?25h") catch {};
    }

    pub fn off() void {
        stdout.writeAll("\x1b[?25l") catch {};
    }
};

pub fn clear() void {
    stdout.writeAll("\x1b[2J\x1b[H") catch {};
}

pub fn wait(time: f64) void {
    sleep(@as(u64, @intFromFloat(time * 1_000_000_000.0)));
}

const stdin = std.io.getStdIn().reader();
pub const stdout = std.io.getStdOut().writer();

pub fn reader(allocator: std.mem.Allocator) ![]const u8 {
    Cursor.on();

    print("\n Write a symbol:  ", .{});

    var buffer: [20]u8 = undefined;
    const input = try stdin.readUntilDelimiterOrEof(&buffer, '\n') orelse return "";

    Cursor.off();

    return try allocator.dupe(u8, input);
}
