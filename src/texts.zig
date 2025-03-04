const csl = @import("consol.zig");
const sm = @import("symbols.zig");
const gi = @import("game_issue.zig");

pub fn intro() void {
    csl.Cursor.off();
    csl.clear();
    csl.wait(1);
    csl.print("\n -> Ready To Play ?", .{});

    csl.wait(2);
    csl.clear();
    csl.wait(1);
    csl.print("\n -> Choose a symbol displayed :\n", .{});
    csl.wait(1);
    csl.print("\n Write {s} or {s} or {s}\n", .{ sm.Symbols_str[0], sm.Symbols_str[1], sm.Symbols_str[2] });

    csl.wait(1);
}

pub fn computerChoice(computer_choice: *const []const u8) void {
    csl.wait(1);
    csl.print("\n Camputer chose : {s}\n", .{computer_choice.*});
}

pub fn playerChoice(player_choice: *const []const u8) void {
    const str = choiceMeaning(player_choice.*);
    csl.clear();
    csl.wait(1);
    csl.print("\n You chose {s}\n", .{str});
}

pub fn choiceMeaning(player_input: []const u8) []const u8 {
    const first_char: u8 = player_input[0];

    switch (first_char) {
        'R' => return "ROCK",
        'S' => return "SCISSORS",
        'P' => return "PAPER",
        'r' => return "ROCK",
        's' => return "SCISSORS",
        'p' => return "PAPER",
        else => unreachable,
    }
}

pub fn charToUpper(c: *u8) void {
    c.* = if (c.* >= 'a' and c.* <= 'z') c.* - ('a' - 'A') else c.*;
}

pub fn invalidSymbol() void {
    csl.print("\n   Symbol incorrect \n", .{});
}

pub fn gameResults(gameIssue: gi.GameIssue) void {
    csl.wait(2);
    switch (gameIssue) {
        gi.GameIssue.DRAW => csl.print("\n It's a Draw ! \n", .{}),
        gi.GameIssue.LOSE => csl.print("\n Sorry, You LOSE ! \n", .{}),
        gi.GameIssue.WIN => csl.print("\n Congratulations ! You WON ! \n", .{}),
    }
}
