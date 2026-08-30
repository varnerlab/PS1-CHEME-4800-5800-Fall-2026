include("Include.jl")


# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "PS1 Test Suite Part 2" begin

    @testset "decode_part_2 with test_part_2.txt" begin

        # setup -
        path_to_test_file = joinpath(_PATH_TO_DATA, "test_part_2.txt");
        number_of_test_records = 6;
        masses = massparse(joinpath(_PATH_TO_DATA, "atomic-masses.csv"));

        # load the test file -
        d = formulaparse(path_to_test_file);
        @test length(d) == number_of_test_records;

        # decode the records -
        (total, weights) = decode_part_2(d, masses);

        # the checksum for test_part_2.txt should be 524.624 -
        @test isapprox(total, 524.624; atol = 1e-3)

        # cobalt is one element while carbon monoxide is two: line 2 is Co, line 3 is CO -
        @test isapprox(weights[2], 58.933; atol = 1e-3)
        @test isapprox(weights[3], 28.010; atol = 1e-3)
    end

    @testset "decode_part_1 rejects the Part 2 grammar" begin

        # setup -
        path_to_test_file = joinpath(_PATH_TO_DATA, "test_part_2.txt");
        masses = massparse(joinpath(_PATH_TO_DATA, "atomic-masses.csv"));

        # load the test file -
        d = formulaparse(path_to_test_file);

        # decode_part_1 does not understand lowercase letters, so it must throw -
        @test_throws ArgumentError decode_part_1(d, masses);
    end

    @testset "decode_part_2 with production_part_2.txt" begin

        # setup -
        path_to_production_file = joinpath(_PATH_TO_DATA, "production_part_2.txt");
        number_of_production_records = 150;
        masses = massparse(joinpath(_PATH_TO_DATA, "atomic-masses.csv"));

        # load the production file -
        d = formulaparse(path_to_production_file);

        # this should be a dictionary of 150 records, with type MyChemicalFormulaModel
        @test length(d) == number_of_production_records;
        @test typeof(d) == Dict{Int64, MyChemicalFormulaModel}

        # decode the records -
        (total, weights) = decode_part_2(d, masses);

        # the checksum for production_part_2.txt should be 190707.141 -
        @test isapprox(total, 190707.141; atol = 1e-3)
    end
end
