# ===== PRIVATE METHODS BELOW HERE =================================================================================== #
# TODO: Add private parsing helpers here. Prefix each helper name with `_` and document its input/output contract.
# ===== PRIVATE METHODS ABOVE HERE =================================================================================== #

# ===== PUBLIC METHODS BELOW HERE ==================================================================================== #
"""
    function decode_part_1(models::Dict{Int64, MyChemicalFormulaModel},
        masses::Dict{String, Float64}) -> Tuple{Float64, Dict{Int64, Float64}}

The `decode_part_1` function computes the molecular weight of every formula in the `models` dictionary
using the Part 1 grammar: every element is a single uppercase letter, optionally followed by a positive
integer count written as one or more digits (a missing count means 1). A formula must not be empty.

### Arguments
- `models::Dict{Int64, MyChemicalFormulaModel}`: The parsed manifest. The key is the line number, the value is the formula model.
- `masses::Dict{String, Float64}`: The atomic-mass table. The key is the element symbol, the value is the mass in amu.

### Returns
- A `Tuple` with two elements. The `first` element is the manifest checksum, i.e., the sum of the molecular
  weights of every formula in the manifest, of type `Float64`. The `second` element is a `Dict{Int64, Float64}`
  where the key is the line number and the value is the molecular weight of that line's formula.

### Errors
- An `ArgumentError` is thrown when a formula is empty, contains a nonpositive count, contains a character
  that the Part 1 grammar does not recognize, or uses an element symbol that is not in the mass table.
"""
function decode_part_1(models::Dict{Int64, MyChemicalFormulaModel},
    masses::Dict{String, Float64})::Tuple{Float64, Dict{Int64, Float64}}
    # TODO: Replace this starter error with the Part 1 scanner and checksum calculation.
    throw("decode_part_1 method not implemented yet"); # prevents an unfinished decoder from returning a plausible value
end

"""
    function decode_part_2(models::Dict{Int64, MyChemicalFormulaModel},
        masses::Dict{String, Float64}) -> Tuple{Float64, Dict{Int64, Float64}}

The `decode_part_2` function computes the molecular weight of every formula in the `models` dictionary
using the Part 2 grammar: an element symbol is one uppercase letter followed by zero or more lowercase
letters, optionally followed by a positive integer count written as one or more digits (a missing count
means 1). A formula must not be empty.

### Arguments
- `models::Dict{Int64, MyChemicalFormulaModel}`: The parsed manifest. The key is the line number, the value is the formula model.
- `masses::Dict{String, Float64}`: The atomic-mass table. The key is the element symbol, the value is the mass in amu.

### Returns
- A `Tuple` with two elements. The `first` element is the manifest checksum, i.e., the sum of the molecular
  weights of every formula in the manifest, of type `Float64`. The `second` element is a `Dict{Int64, Float64}`
  where the key is the line number and the value is the molecular weight of that line's formula.

### Errors
- An `ArgumentError` is thrown when a formula is empty, contains a nonpositive count, contains a character
  that the Part 2 grammar does not recognize, or uses an element symbol that is not in the mass table.
"""
function decode_part_2(models::Dict{Int64, MyChemicalFormulaModel},
    masses::Dict{String, Float64})::Tuple{Float64, Dict{Int64, Float64}}
    # TODO: Replace this starter error with the multi-letter-symbol scanner and checksum calculation.
    throw("decode_part_2 method not implemented yet"); # prevents an unfinished decoder from returning a plausible value
end
# ===== PUBLIC METHODS ABOVE HERE ==================================================================================== #
