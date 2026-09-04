# Local check-and-package helper. Run from the repository root:
#
#   julia --startup-file=no check_submission.jl
#
# The script runs both test suites (a partial solution is fine; failures are
# reported, not fatal), then writes MANIFEST.txt with a SHA-256 digest of every
# file in src/. It does not connect to Canvas or upload the submission. The final
# guidance distinguishes work that is ready from work that still needs attention.

import Dates # timestamp written to the submission manifest
using SHA    # SHA-256 digests used to identify the submitted source files

# Explain the boundary between this local check and the Canvas submission -
println("""
==================== important ====================
This script checks your work and prepares MANIFEST.txt.
It does NOT upload anything to Canvas.
You must still create a zip archive and upload it through Canvas yourself.
""");

# Run both public test suites and retain their completion status -
results = Dict{String, Bool}(); # test filename => whether the suite completed without an uncaught exception
for part ∈ ["testme_part_1.jl", "testme_part_2.jl"]
    println("\n==================== running $(part) ====================");
    ok = true; # optimistic status, cleared if `include(...)` propagates a test failure
    try
        include(joinpath(@__DIR__, part)); # `@__DIR__` keeps execution independent of `pwd()`
    catch error
        ok = false; # a failed assertion or early load error prevented clean suite completion
    end
    results[part] = ok; # preserve one status for each public test suite
end

# Write the submission manifest -
manifest_path = joinpath(@__DIR__, "MANIFEST.txt"); # generated beside this script
open(manifest_path, "w") do io
    println(io, "PS1 CHEME 4800/5800 Fall 2026 submission manifest");
    println(io, "generated: ", Dates.now()); # local wall-clock timestamp

    # Record the test outcomes -
    for part ∈ sort(collect(keys(results)))
        println(io, part, ": ", results[part] ? "all tests passed" : "some tests failed"); # sort for reproducible output order
    end

    # Fingerprint every submitted Julia source file -
    for file ∈ sort(readdir(joinpath(@__DIR__, "src"); join = true))
        digest = bytes2hex(open(sha256, file)); # lowercase hexadecimal SHA-256 digest
        println(io, digest, "  src/", basename(file));
    end
end

# Display the status and student packaging instructions -
println("\n==================== submission summary ====================");
for part ∈ sort(collect(keys(results)))
    println(part, ": ", results[part] ? "all tests passed" : "SOME TESTS FAILED");
end
println("wrote ", manifest_path);
all_suites_passed = all(values(results)); # true only when both public test files finish successfully

# Give advice appropriate to the public-test result -
if all_suites_passed == true
    println("""

Status: READY TO PACKAGE
All public tests passed. Follow the Canvas submission steps below.
""");
else
    println("""

Status: CHECKS NEED ATTENTION
One or more public test suites failed.

Recommended next steps:
1. Review the failure messages above.
2. Fix as many issues as you can.
3. Run this script again and check the new results.

Deadline safeguard: If you cannot fix every failure before the deadline, submit
your current work anyway. A submission is required for partial credit and for the
infinite-revision policy. Do not miss the deadline solely because a test is failing.
""");
end

# Repeat the manual Canvas boundary immediately before the upload instructions -
println("""
This script has NOT uploaded anything to Canvas.

Canvas submission steps:
1. Zip the whole problem-set folder (the folder holding this script):
   - macOS: right-click the folder in Finder and choose "Compress".
   - Windows: right-click the folder and choose "Send to" -> "Compressed (zipped) folder".
2. Rename the zip to CHEME-4800-5800-PS1-<your netid>.zip
   (for example, CHEME-4800-5800-PS1-abc123.zip).
3. Upload the zip to the PS1 assignment on Canvas before the deadline.
""");
