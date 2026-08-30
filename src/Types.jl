"""
    MyChemicalFormulaModel

The `MyChemicalFormulaModel` type is a mutable struct that represents one molecular
formula read from a manifest file.

### Fields
- TODO: Fill in the fields documentation (don't forget to include the type of each field)
"""
mutable struct MyChemicalFormulaModel

    # Data fields -
    # TODO: Fill in the fields (don't forget to include the type of each field).
    # The model should hold the formula String, the characters of the formula as
    # an Array{Char,1}, and the number of characters as an Int64.

    # Default constructor -
    MyChemicalFormulaModel() = new(); # `build(...)` populates the fields after allocation
end
