# Check-and-package helper. Run from the repository root:
#
#   julia --startup-file=no submit.jl
#
# The script runs both test suites (a partial solution is fine; failures are
# reported, not fatal), then writes MANIFEST.txt with a SHA-256 digest of every
# file in src/. Finish by zipping the folder as the printed instructions describe.

import Dates
using SHA

results = Dict{String, Bool}();
for part ∈ ["testme_part_1.jl", "testme_part_2.jl"]
    println("\n==================== running $(part) ====================");
    ok = true;
    try
        include(joinpath(@__DIR__, part));
    catch error
        ok = false; # the failure details were already printed by the test framework
    end
    results[part] = ok;
end

# write the manifest -
manifest_path = joinpath(@__DIR__, "MANIFEST.txt");
open(manifest_path, "w") do io
    println(io, "PS1 CHEME 4800/5800 Fall 2026 submission manifest");
    println(io, "generated: ", Dates.now());
    for part ∈ sort(collect(keys(results)))
        println(io, part, ": ", results[part] ? "all tests passed" : "some tests failed");
    end
    for file ∈ sort(readdir(joinpath(@__DIR__, "src"); join = true))
        digest = bytes2hex(open(sha256, file));
        println(io, digest, "  src/", basename(file));
    end
end

println("\n==================== submission summary ====================");
for part ∈ sort(collect(keys(results)))
    println(part, ": ", results[part] ? "all tests passed" : "SOME TESTS FAILED (partial credit is possible; submit anyway)");
end
println("wrote ", manifest_path);
println("""
Next steps:
1. Zip the whole problem-set folder (the folder holding this script):
   - macOS: right-click the folder in Finder and choose "Compress".
   - Windows: right-click the folder and choose "Send to" -> "Compressed (zipped) folder".
2. Rename the zip to PS1-<your netid>.zip (for example, PS1-abc123.zip).
3. Upload the zip to the PS1 assignment on Canvas before the deadline.
""");
