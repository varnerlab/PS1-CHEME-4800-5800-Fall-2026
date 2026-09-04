
# ===== PRIVATE METHODS BELOW HERE =================================================================================== #
# TODO: Add private factory helpers here if needed. Prefix each helper name with `_` and document its contract.
# ===== PRIVATE METHODS ABOVE HERE =================================================================================== #

# ===== PUBLIC METHODS BELOW HERE ==================================================================================== #

"""
    function build(modeltype::Type{MyChemicalFormulaModel}, data::NamedTuple) -> MyChemicalFormulaModel

The `build` function constructs and configures a `MyChemicalFormulaModel` instance from the `NamedTuple` of data.

### Arguments
- `modeltype::Type{MyChemicalFormulaModel}`: The type of the model to build, which should be `MyChemicalFormulaModel`.
- `data::NamedTuple`: The data to use to build the model. The `data.formula` field holds the formula `String`.

### Returns
- A `MyChemicalFormulaModel` instance with all of its fields populated from the formula.
"""
function build(modeltype::Type{MyChemicalFormulaModel}, data::NamedTuple)::MyChemicalFormulaModel
    # TODO: Replace this starter error with logic that populates every model field.
    throw("build method not implemented for model type: $(modeltype)"); # prevents an incomplete model from escaping silently
end
# ===== PUBLIC METHODS ABOVE HERE ==================================================================================== #
