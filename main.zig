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

    var player_input: []const u8 = try consol.reader(allocator);

    try game.symbolResent(&player_input, allocator);

    texts.computerChoice(&computer_choice);

    //consol.print("\n CURRENT PLAYER CHOICE : {s}\n", .{player_});
    const GameResult: game.GameIssue = game.gameIssueChecker(player_input, computer_choice);

    texts.gameResults(GameResult);
    //consol.print("\n Player Input: {s}\n", .{player_input});

    allocator.free(player_input);
    consol.Cursor.on(); //Must be repasted
}
