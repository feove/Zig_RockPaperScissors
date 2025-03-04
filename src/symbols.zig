pub const Symbols = enum { ROCK, PAPER, SCISSORS };

pub const Symbols_str: [3][]const u8 = .{ "ROCK", "PAPER", "SCISSORS" };

pub fn SymboltoString(symbol: Symbols) []const u8 {
    switch (symbol) {
        Symbols.ROCK => return "ROCK",
        Symbols.PAPER => return "PAPER",
        Symbols.SCISSORS => return "SCISSORS",
    }
}

pub const GameRules = struct {
    pub fn getOutcome(player: Symbols) struct { Symbols, Symbols } {
        return switch (player) {
            Symbols.ROCK => .{ Symbols.SCISSORS, Symbols.PAPER },
            Symbols.PAPER => .{ Symbols.ROCK, Symbols.SCISSORS },
            Symbols.SCISSORS => .{ Symbols.PAPER, Symbols.ROCK },
        };
    }
};
