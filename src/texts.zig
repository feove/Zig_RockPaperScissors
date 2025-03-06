const csl = @import("consol.zig");
const sm = @import("symbols.zig");
const gi = @import("game_issue.zig");

pub fn intro() void {
    csl.Cursor.off();
    csl.clear();
    csl.wait(1);
    setMarginText();
    arrowAnimationDefault(4);
    csl.print(" Ready To Play ?", .{});

    csl.wait(1.5);
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

fn arrowAnimation(arrowLength: u8, timePerLine: f64, timeAtTheEnd: f64) void {
    var i: u8 = 0;

    setMarginText();
    while (i < arrowLength) : (i += 1) {
        csl.print("-", .{});
        csl.wait(timePerLine);
    }
    csl.print(">", .{});
    csl.wait(timeAtTheEnd);
}

fn arrowAnimationDefault(arrowLength: u8) void {
    arrowAnimation(arrowLength, 0.1, 0.3);
}

pub fn loadingAnimation(loadingLength: u8, lastConsolContent: []const u8) void {
    var i: u8 = 0;
    while (i < loadingLength + 1) : (i += 1) {
        csl.clear();
        csl.print("{s}", .{lastConsolContent});

        var j: u8 = 0;
        while (j <= i) : (j += 1) {
            if (j != 0)
                csl.print(" ", .{});
        }
        csl.print("█", .{});
        csl.wait(0.2);
    }
    csl.wait(0.5);
}

pub fn computerChoice(computer_choice: *const []const u8) void {
    const lastConsolContent: []const u8 = "\n ----> Camputer chose : ";
    csl.clear();
    arrowAnimationDefault(4);
    csl.print(" Camputer chose : ", .{});
    loadingAnimation(@intCast(computer_choice.*.len), lastConsolContent);

    //Showing result string content whithout animations
    csl.clear();
    arrowAnimation(4, 0, 0);
    csl.print(" Camputer chose : ", .{});
    csl.print("{s}\n", .{computer_choice.*});
    csl.wait(1);
}

pub fn playerChoice(player_choice: *const []const u8) void {
    const str = choiceMeaning(player_choice.*);
    csl.wait(0.5);
    arrowAnimationDefault(4);
    csl.print(" You have chosen {s}\n", .{str});
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

fn lineAnimation() void {
    var i: u8 = 1;

    setMarginText();

    var s = [_]u8{ '[', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ']' };
    //csl.print("┃", .{});
    while (i < 15) : (i += 1) {
        csl.clear();
        csl.print("{s}", .{s});
        csl.wait(0.05);
        s[i] = '#';
    }
    //csl.print("┃", .{});
    csl.print("\n", .{});
    csl.wait(0.3);
}

pub fn gameResults(gameIssue: gi.GameIssue) void {
    lineAnimation();
    arrowAnimationDefault(2);
    switch (gameIssue) {
        gi.GameIssue.DRAW => csl.print(" It's a Draw ! \n", .{}),
        gi.GameIssue.LOSE => csl.print(" Sorry, You LOSE ! \n", .{}),
        gi.GameIssue.WIN => csl.print(" Congratulations ! You WON ! \n", .{}),
    }
    //lineAnimation(20);
}
