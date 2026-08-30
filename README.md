# PS1: Decode the Molecular-Weight Checksum of a Shipping Manifest
Problem set 1 `(PS1)` gives students practice working with [Strings](https://docs.julialang.org/en/v1/manual/strings/#man-strings), [Characters](https://docs.julialang.org/en/v1/manual/strings/#man-characters), [Arrays](https://docs.julialang.org/en/v1/manual/arrays/#man-arrays-1), [Dictionaries](https://docs.julialang.org/en/v1/base/collections/#Base.Dict), [Loops](https://docs.julialang.org/en/v1/manual/control-flow/#man-loops-1), and the documented, tested function interfaces from Week 2. `PS1` is divided into two parts.

__Dates:__ PS1 is released on Saturday, September 5 and is due (as a zip archive uploaded to Canvas) by 11:59 PM ET on Saturday, September 19. The reference solution will be published in this repository after the due date.

## The story
A chemical supplier ships you a manifest: a plain-text file with one molecular formula per line. Before the shipment is accepted, the receiving system must recompute the manifest `checksum`: the sum of the molecular weights of every compound listed in the file, in atomic mass units `amu`. Your job is to write the program that parses the manifest and recovers the checksum.

You are given an atomic-mass table in the file `atomic-masses.csv` in the `data` directory. The first line is a header; every following line has the form `symbol,mass`, e.g., `C,12.011`. The molecular weight of a formula is the sum over its elements of the atomic mass of the element multiplied by its count, e.g., the molecular weight of water `H2O` is `2*(1.008) + 15.999 = 18.015 amu`.

## Part 1
In Part 1, the manifest uses a simplified formula grammar: every element symbol is a `single uppercase letter`, optionally followed by a count written as one or more digits. A missing count means `1`. There are no parentheses, hydrates, or charges.

For example, consider the following `4-line` manifest, provided in the file `test_part_1.txt` in the `data` directory:
```
H2O
C6H12O6
CO2
NH3
```

The molecular weights of these four lines are `18.015`, `180.156`, `44.009`, and `17.031 amu`. Adding these together produces `259.211 amu`, the manifest checksum. Notice the count can have more than one digit: glucose contains `12` hydrogens.

### Tasks Part 1
The public `application programming interface (API)` for this problem set consists of the following types and functions:
1. Create the `MyChemicalFormulaModel` type in the `Types.jl` file. `MyChemicalFormulaModel` should be `mutable` and have three fields:
    * The `formula::String` field holds a single formula line of text,
    * The `characters::Array{Char, 1}` field holds the characters of the formula,
    * The `len::Int64` field holds the length (number of characters) of the formula.
2. Create a `build` method in the `Factory.jl` file that takes the `MyChemicalFormulaModel` type and a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple) holding the formula in its `formula` field, and returns a `MyChemicalFormulaModel` object (with all the fields populated).
3. Complete the implementation of the two functions in the `Files.jl` file:
   - The `formulaparse` function takes a manifest file path as input and returns a [Dictionary](https://docs.julialang.org/en/v1/base/collections/#Base.Dict) whose `key` is the line number (starting from index 1) and whose `value` is a `MyChemicalFormulaModel` instance holding that line's formula.
   - The `massparse` function takes the atomic-mass file path as input and returns a `Dict{String, Float64}` mapping each element symbol to its atomic mass.
4. Complete the implementation of the `decode_part_1` function in the `Compute.jl` file. The `decode_part_1` function takes `models::Dict{Int64, MyChemicalFormulaModel}` and `masses::Dict{String, Float64}` as input and returns a [Tuple](https://docs.julialang.org/en/v1/manual/functions/#Tuples) with two elements:
   - The `first` element should be the overall manifest `checksum` computed by processing `all` the formulas in a file. The checksum is of type `Float64`.
   - The `second` element should be a dictionary of type `Dict{Int64, Float64}` whose `key` is the line number (starting from index 1) and whose `value` is the molecular weight of that line's formula.
   - A formula containing a character the grammar does not recognize, or an element symbol missing from the mass table, should throw a descriptive [ArgumentError](https://docs.julialang.org/en/v1/base/base/#Core.ArgumentError). This is the defensive-interface contract from the Week 2 labs.

To test your implementation, execute the `testme_part_1.jl` script in the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) by using [the `include(...)` function](https://docs.julialang.org/en/v1/base/base/#Base.include). This checks the functions developed above and the final checksum on the `production_part_1.txt` manifest (`150` formulas). The Part 1 production checksum should be `113188.572 amu` (compared with a tolerance of `0.001`).

## Part 2
As it turns out, the supplier's real manifests use the full periodic table, and your Part 1 decoder is not just incomplete on them, it is `wrong`. Element symbols can have `one uppercase letter followed by zero or more lowercase letters`: sodium chloride is `NaCl`, and tin(IV) oxide is `SnO2`.

* `Interesting wrinkle`: Case is the only thing separating some molecules. `CO` is carbon monoxide, one carbon and one oxygen, weighing `28.010 amu`. `Co` is elemental cobalt, weighing `58.933 amu`. Your decoder has to read the characters carefully: an uppercase letter starts a symbol, and any lowercase letters that follow belong to that same symbol. This is the Week 2 lesson about characters and code points doing real work: `O` and `o` are different code points, and here they are worth `30.923 amu`.

For example, consider the following `6-line` manifest, provided in the `test_part_2.txt` file in the `data` directory:
```
NaCl
Co
CO
CuSO4
Sn
Mg3N2
```
The molecular weights of these six lines are `58.440`, `58.933`, `28.010`, `159.602`, `118.710`, and `100.929 amu`. Adding these together produces `524.624 amu`, the Part 2 checksum of the test manifest.

### Tasks Part 2
We can use all of the types and functions from [Part 1](#part-1) to solve this problem, except the `decode_part_1` function, because it does not understand multi-letter element symbols. Thus, we need to construct a new function that does:

1. Complete the implementation of the `decode_part_2` function in the `Compute.jl` file. The `decode_part_2` function has the same signature, return contract, and error contract as `decode_part_1`, but reads element symbols under the full grammar: one uppercase letter followed by zero or more lowercase letters, then an optional count.

To test your [Part 2](#part-2) implementation, execute the `testme_part_2.jl` script in the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) by using [the `include(...)` function](https://docs.julialang.org/en/v1/base/base/#Base.include). This script also confirms that `decode_part_1` throws an `ArgumentError` when handed a Part 2 manifest, because refusing bad input loudly beats returning a wrong number quietly. The Part 2 production checksum on the `production_part_2.txt` manifest (`150` formulas) should be `190707.141 amu` (compared with a tolerance of `0.001`).

## Submitting your work
When you are done (or as far as you got; partial solutions earn partial credit), run the `submit.jl` script from the repository root:

```
julia --startup-file=no submit.jl
```

The script runs both test suites, reports what passes, and writes a `MANIFEST.txt` file recording a digest of your source files. Then zip the whole problem-set folder, rename the archive to `PS1-<your netid>.zip`, and upload it to the PS1 assignment on Canvas before the deadline. The zip should contain everything: your `src` files, the `data` folder, and the generated `MANIFEST.txt`.
