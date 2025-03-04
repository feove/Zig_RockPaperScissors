const sy = @import("symbols.zig");
const csl = @import("consol.zig");

const std = csl.std;
const RndGen = std.rand.DefaultPrng;

pub fn computer_choice() []const u8 {
    const random_index = random_integer(2);
    return sy.Symbols_str[random_index];
}

pub fn random_integer(max: usize) usize {
    const seed: u64 = @intCast(std.time.microTimestamp());
    var rand_impl = RndGen.init(seed);
    return rand_impl.random().intRangeAtMost(usize, 0, max);
}
