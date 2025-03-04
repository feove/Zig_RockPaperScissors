const csl = @import("consol.zig");
const sm = @import("symbols.zig");
const txt = @import("texts.zig");

pub const GameIssue = enum { LOSE, WIN, DRAW };

pub fn gameIssueChecker(player_choice: []const u8, computer_choice: []const u8) GameIssue {
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

const expect = csl.std.testing.expect;

pub fn isValidSymbol(player_input: []const u8) bool {
    var first_char: u8 = player_input[0];

    txt.charToUpper(&first_char);

    const playerInputIsValid: bool = switch (first_char) {
        'R' => true,
        'S' => true,
        'P' => true,
        'r' => true,
        's' => true,
        'p' => true,
        else => false,
    };

    return playerInputIsValid;
}

pub fn StringToSymbolType(str_symbol: []const u8) sm.Symbols {
    switch (str_symbol[0]) {
        'R' => return sm.Symbols.ROCK,
        'S' => return sm.Symbols.SCISSORS,
        'P' => return sm.Symbols.PAPER,
        'r' => return sm.Symbols.ROCK,
        's' => return sm.Symbols.SCISSORS,
        'p' => return sm.Symbols.PAPER,
        else => unreachable,
    }
}

pub fn symbolResent(player_input: *[]const u8, allocator: csl.std.mem.Allocator) !void {
    while (!isValidSymbol(player_input.*)) {
        txt.invalidSymbol();

        allocator.free(player_input.*);

        player_input.* = try csl.reader(allocator);
    }
}
