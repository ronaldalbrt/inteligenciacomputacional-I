module Lista1
    include("Data.jl")
    include("PLA.jl")

    using .Data, .PLA

    function run_experiment(n::Int64=10)
        dataset = Dataset(n)
        model = PLAModel(2)
        
        return fit!(model, dataset.X, dataset.y), error_measure(model, dataset.X_test, dataset.y_test)
    end

end