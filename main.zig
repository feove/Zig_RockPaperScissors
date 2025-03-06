const texts = @import("src/texts.zig");
const consol = @import("src/consol.zig");
const computer = @import("src/computer.zig");
const game = @import("src/game_issue.zig");
const symbols = @import("src/symbols.zig");

pub fn main() !void {
    texts.intro();

    var gpa = consol.std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const computer_choice: []const u8 = computer.computer_choice();

    var player_choice: []const u8 = try consol.reader(allocator);

    try game.symbolResent(&player_choice, allocator);

    texts.playerChoice(&player_choice);

    texts.computerChoice(&computer_choice);

    const GameResult: game.GameIssue = game.gameIssueChecker(player_choice, computer_choice);

    texts.gameResults(GameResult);

    allocator.free(player_choice);

    consol.Cursor.on(); //Must be repasted
}
