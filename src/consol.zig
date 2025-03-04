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

pub fn wait(time: u32) void {
    sleep(time * 1_000_000_000);
}

const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

pub fn reader() ![]const u8 {
    Cursor.on();

    print("\n Write a symbol:  ", .{});

    var buffer: [20]u8 = undefined;
    const input = try stdin.readUntilDelimiterOrEof(&buffer, '\n') orelse return "";

    Cursor.off();

    return input;
}
