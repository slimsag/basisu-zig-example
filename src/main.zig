const std = @import("std");

const basisu = @import("basisu-zig");

pub fn main() !void {
    basisu.init();
    std.debug.print("it worked!\n", .{});
}
