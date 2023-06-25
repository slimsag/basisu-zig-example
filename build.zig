const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const basisu_zig_dep = b.dependency("basisu_zig", .{
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "basisu-zig-example",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.addModule("basisu-zig", basisu_zig_dep.module("basisu-zig"));

    // A hack / workaround is to have the zig wrapper expose its own static library,
    // and then require users of the Zig module link that library themselves:
    //
    //exe.linkLibrary(basisu_zig_dep.artifact("basisu-zig"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
