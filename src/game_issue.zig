const csl = @import("consol.zig");
const sm = @import("symbols.zig");
const txt = @import("texts.zig");

pub const GameIssue = enum { LOSE, WIN, DRAW };

pub fn gameIssueChecker(player_choice: []const u8, computer_choice: []const u8) GameIssue {
    csl.print("THE FINAL PLAYER CHOICE {s} \n", .{player_choice});

    const player_symbol: sm.Symbols = StringToSymbolType(player_choice);
    const computer_symbol: sm.Symbols = StringToSymbolType(computer_choice);

    if (player_symbol == computer_symbol) {
        return GameIssue.DRAW;
    }

    if (computer_symbol == sm.GameRules.getOutcome(player_symbol)[0]) {
        return GameIssue.WIN;
    }

    return GameIssue.LOSE;
}

pub fn isValidSymbol(player_input: []const u8) bool {
    for (sm.Symbols_str) |symbol| {
        if (csl.std.mem.eql(u8, player_input, symbol)) {
            return true;
        }
    }
    return false;
}

pub fn StringToSymbolType(str_symbol: []const u8) sm.Symbols {
    switch (str_symbol[0]) {
        'R' => return sm.Symbols.ROCK,
        'S' => return sm.Symbols.SCISSORS,
        'P' => return sm.Symbols.PAPER,
        else => unreachable,
    }
}

pub fn symbolResent(player_input: *[]const u8) !void {
    while (!isValidSymbol(player_input.*)) {
        txt.invalidSymbol();
        player_input.* = try csl.reader();
    }

    //csl.clear();
}
