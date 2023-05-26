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
        # Função objetivo não linear
        target_function = x -> sign(([1; 1]' * (x.^2)) - 0.6)
        
        # Dataset com ruído
        dataset = Dataset(n; target_function=target_function, noisy=true)
        
        # Modelos de regressão linear
        model_1 = LinearRegressionModel(2)
        model_2 = LinearRegressionModel(5)

        # Transformação polinomial
        transformed_X = polynomial_mapping(dataset.X, 2)
        transformed_X_test = polynomial_mapping(dataset.X_test, 2)
        
        # Treinamento dos modelos
        LinearRegression.fit!(model_1, dataset.X, dataset.y)
        LinearRegression.fit!(model_2, transformed_X, dataset.y)

        # Retorno dos resultados
        return LinearRegression.error_measure(model_1, dataset.X, dataset.y), 
        model_2.w, model_2.b,
        LinearRegression.error_measure(model_2, transformed_X_test, dataset.y_test)
    end

    # Experimento da questão 11
    function run_experiment_4(n_1::Int64=100, n_2::Int64=1000)
        dataset = Dataset(n_1; noisy=true, test_size=n_2)
        # Modelo PLA com k = 10
        model_10 = PLAModel(2)
        # Modelo PLA com k = 50
        model_50 = PLAModel(2)

        # Modelo de regressão linear
        model_linear_regression = LinearRegressionModel(2)
        LinearRegression.fit!(model_linear_regression, dataset.X, dataset.y)

        # Modelo de PLA com inicialização dos parâmetros com os parâmetros do modelo de regressão linear
        model_10_linear_regression = PLAModel(2, model_linear_regression.w, model_linear_regression.b)
        model_50_linear_regression = PLAModel(2, model_linear_regression.w, model_linear_regression.b)

        # Treinamento dos modelos com pocket PLA
        PLA.pocket_fit!(model_10, dataset.X, dataset.y, 10)
        PLA.pocket_fit!(model_50, dataset.X, dataset.y, 50)
        PLA.pocket_fit!(model_10_linear_regression, dataset.X, dataset.y, 10)
        PLA.pocket_fit!(model_50_linear_regression, dataset.X, dataset.y, 50)
        
        return PLA.error_measure(model_10, dataset.X_test, dataset.y_test), 
        PLA.error_measure(model_50, dataset.X_test, dataset.y_test),
        PLA.error_measure(model_10_linear_regression, dataset.X_test, dataset.y_test), 
        PLA.error_measure(model_50_linear_regression, dataset.X_test, dataset.y_test)
    end
end