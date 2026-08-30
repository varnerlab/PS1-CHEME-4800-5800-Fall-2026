
# ===== PUBLIC METHODS BELOW HERE ==================================================================================== #
"""
    formulaparse(filepath::String) -> Dict{Int64, MyChemicalFormulaModel}

The `formulaparse` function reads a manifest file and parses the contents into a dictionary of
`MyChemicalFormulaModel` objects. The key of the dictionary is the line number of the file (starting
from index 1), while the value is the `MyChemicalFormulaModel` object holding that line's formula.

### Arguments
- `filepath::String`: The path of the manifest file to parse. Each line holds one molecular formula.

### Returns
- A dictionary of `MyChemicalFormulaModel` objects where the key is the line number of the file and the value is the `MyChemicalFormulaModel` object.
"""
function formulaparse(filepath::String)::Dict{Int64, MyChemicalFormulaModel}

    # Initialize -
    records = Dict{Int64, MyChemicalFormulaModel}() # manifest line number => parsed formula model
    linecounter = 1; # physical file lines and Julia positions both start at 1

    # Read the formula manifest -
    open(filepath, "r") do io
        for line ∈ eachline(io)

            # TODO: Build a model from this line, store it under `linecounter`, and advance the counter.
            throw("formulaparse method not implemented yet");
        end
    end

    # Return the parsed records -
    return records;
end

"""
    massparse(filepath::String) -> Dict{String, Float64}

The `massparse` function reads the atomic-mass table and parses the contents into a dictionary.
The key of the dictionary is the element symbol, while the value is the atomic mass in amu.

### Arguments
- `filepath::String`: The path of the atomic-mass file to parse. The first line is a header;
  every following line has the form `symbol,mass`.

### Returns
- A dictionary where the key is the element symbol `String` and the value is the atomic mass `Float64`.
"""
function massparse(filepath::String)::Dict{String, Float64}

    # Initialize -
    masses = Dict{String, Float64}() # element symbol => atomic mass (amu)

    # Read the atomic-mass table -
    open(filepath, "r") do io
        for (i, line) ∈ enumerate(eachline(io))

            # `i` is the one-based physical line number; line 1 is the CSV header.
            # TODO: Skip the header, split each data row at the comma, and store symbol => mass.
            throw("massparse method not implemented yet");
        end
    end

    # Return the atomic-mass lookup table -
    return masses;
end
# ===== PUBLIC METHODS ABOVE HERE ==================================================================================== #
