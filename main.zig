const texts = @import("src/texts.zig");
const consol = @import("src/consol.zig");
const computer = @import("src/computer.zig");
const game = @import("src/game_issue.zig");
const symbols = @import("src/symbols.zig");

pub fn main() !void {
    texts.intro();

    const computer_choice: []const u8 = computer.computer_choice();

    var player_choice: []const u8 = try consol.reader();

    try game.symbolResent(&player_choice);

    consol.print("\n You chose : {s}\n", .{player_choice});
    //Add function about that in texts.zig

    //texts.computerChoice(&computer_choice);

    const GameResult: game.GameIssue = game.gameIssueChecker(player_choice, computer_choice);

    texts.gameResults(GameResult);

    consol.Cursor.on(); //Must be repasted
}
