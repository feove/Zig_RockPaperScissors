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

fn setMarginText() void {
    csl.print("\n ", .{});
}

fn arrowAnimation(arrowLength: u8) void {
    var i: u8 = 0;

    setMarginText();
    while (i < arrowLength) : (i += 1) {
        csl.print("━", .{});
        csl.wait(0.1);
    }
    csl.print(">", .{});
    csl.wait(0.3);
}

fn lineAnimation(lineLength: u8) void {
    var i: u8 = 0;

    setMarginText();
    //csl.print("┃", .{});
    while (i < lineLength) : (i += 1) {
        csl.print("━", .{});
        csl.wait(0.05);
    }
    //csl.print("┃", .{});
    csl.print("\n", .{});
    csl.wait(0.3);
}

pub fn computerChoice(computer_choice: *const []const u8) void {
    arrowAnimation(4);
    csl.print(" Camputer chose : ", .{});
    csl.wait(0.5);
    csl.print("{s}\n", .{computer_choice.*});
}

pub fn playerChoice(player_choice: *const []const u8) void {
    const str = choiceMeaning(player_choice.*);
    csl.clear();
    csl.wait(0.5);
    arrowAnimation(4);
    csl.print(" You chose {s}\n", .{str});
    csl.wait(1);
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

fn lineJump() void {
    csl.print("\n");
}

pub fn charToUpper(c: *u8) void {
    c.* = if (c.* >= 'a' and c.* <= 'z') c.* - ('a' - 'A') else c.*;
}

pub fn invalidSymbol() void {
    csl.print("\n   Symbol incorrect \n", .{});
}

pub fn gameResults(gameIssue: gi.GameIssue) void {
    lineAnimation(30);
    arrowAnimation(2);
    switch (gameIssue) {
        gi.GameIssue.DRAW => csl.print(" It's a Draw ! \n", .{}),
        gi.GameIssue.LOSE => csl.print(" Sorry, You LOSE ! \n", .{}),
        gi.GameIssue.WIN => csl.print(" Congratulations ! You WON ! \n", .{}),
    }
    //lineAnimation(20);
}
