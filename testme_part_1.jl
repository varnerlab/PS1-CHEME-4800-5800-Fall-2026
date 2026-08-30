include("Include.jl")


# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "PS1 Test Suite Part 1" begin

    @testset "massparse with atomic-masses.csv" begin

        # setup -
        path_to_mass_file = joinpath(_PATH_TO_DATA, "atomic-masses.csv");

        # load the mass table -
        masses = massparse(path_to_mass_file);

        # the table holds 33 elements, keyed by symbol -
        @test typeof(masses) == Dict{String, Float64}
        @test length(masses) == 33

        # spot-check two entries -
        @test isapprox(masses["C"], 12.011; atol = 1e-6)
        @test isapprox(masses["O"], 15.999; atol = 1e-6)
    end

    @testset "formulaparse with test_part_1.txt" begin

        # setup -
        path_to_test_file = joinpath(_PATH_TO_DATA, "test_part_1.txt");
        number_of_test_records = 4;

        # load the test file -
        d = formulaparse(path_to_test_file);

        # this should be a dictionary of 4 records, with type MyChemicalFormulaModel
        @test length(d) == number_of_test_records;
        @test typeof(d) == Dict{Int64, MyChemicalFormulaModel}

        # the first record holds the water formula -
        @test d[1].formula == "H2O"
        @test d[1].characters == ['H', '2', 'O']
        @test d[1].len == 3
    end

    @testset "decode_part_1 with test_part_1.txt" begin

        # setup -
        path_to_test_file = joinpath(_PATH_TO_DATA, "test_part_1.txt");
        masses = massparse(joinpath(_PATH_TO_DATA, "atomic-masses.csv"));

        # load the test file -
        d = formulaparse(path_to_test_file);

        # decode the records -
        (total, weights) = decode_part_1(d, masses);

        # water on line 1 weighs 18.015 amu, and the checksum for test_part_1.txt is 259.211 -
        @test isapprox(weights[1], 18.015; atol = 1e-3)
        @test isapprox(weights[2], 180.156; atol = 1e-3)
        @test isapprox(total, 259.211; atol = 1e-3)
    end

    @testset "decode_part_1 with production_part_1.txt" begin

        # setup -
        path_to_production_file = joinpath(_PATH_TO_DATA, "production_part_1.txt");
        number_of_production_records = 150;
        masses = massparse(joinpath(_PATH_TO_DATA, "atomic-masses.csv"));

        # load the production file -
        d = formulaparse(path_to_production_file);

        # this should be a dictionary of 150 records, with type MyChemicalFormulaModel
        @test length(d) == number_of_production_records;
        @test typeof(d) == Dict{Int64, MyChemicalFormulaModel}

        # decode the records -
        (total, weights) = decode_part_1(d, masses);

        # the checksum for production_part_1.txt should be 113188.572 -
        @test isapprox(total, 113188.572; atol = 1e-3)
    end
end
