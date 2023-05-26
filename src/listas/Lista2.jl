module Lista2
    using ..Data, ..LinearRegression, ..PLA

    # Experimento das questões 5 e 6
    function run_experiment_1(n::Int64=100)
        dataset = Dataset(n)
        model = LinearRegressionModel(2)
        
        LinearRegression.fit!(model, dataset.X, dataset.y)

        return LinearRegression.error_measure(model, dataset.X, dataset.y), LinearRegression.error_measure(model, dataset.X_test, dataset.y_test)
    end

    # Experimento da questão 7
    function run_experiment_2(n::Int64=10)
        dataset = Dataset(n)
        linear_regression_model = LinearRegressionModel(2)

        LinearRegression.fit!(linear_regression_model, dataset.X, dataset.y)

        pla_model = PLAModel(2, linear_regression_model.w, linear_regression_model.b)

        return PLA.fit!(pla_model, dataset.X, dataset.y)
    end

    # Experimento das questões 8, 9 e 10
    function run_experiment_3(n::Int64=1000)
        target_function = x -> sign(([1; 1]' * (x.^2)) - 0.6)
        dataset = Dataset(n; target_function=target_function, noisy=true)
        model_1 = LinearRegressionModel(2)
        model_2 = LinearRegressionModel(5)

        transformed_X = polynomial_mapping(dataset.X, 2)
        transformed_X_test = polynomial_mapping(dataset.X_test, 2)
        
        LinearRegression.fit!(model_1, dataset.X, dataset.y)
        LinearRegression.fit!(model_2, transformed_X, dataset.y)

        return LinearRegression.error_measure(model_1, dataset.X, dataset.y), 
        model_2.w, model_2.b,
        LinearRegression.error_measure(model_2, transformed_X_test, dataset.y_test)
    end
end