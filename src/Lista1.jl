module Lista1
    include("Data.jl")
    include("PLA.jl")

    using .Data, .PLA, Plots

    function run_experiment(n::Int64=10)
        dataset = Dataset(n)
        model = PLAModel(2)
        
        return fit!(model, dataset.X, dataset.y), error_measure(model, dataset.X_test, dataset.y_test)
    end

    function plot_data(n::Int64=50)
        dataset = Dataset(n)
        model = PLAModel(2)
        X_positive = dataset.X[findall(y -> y == 1, dataset.y)]
        X_negative = dataset.X[findall(y -> y != 1, dataset.y)]

        # Plotando os pontos de treino com y = 1
        x_1_positive = [x[1] for x in X_positive]
        x_2_positive = [x[2] for x in X_positive]
        plot(x_1_positive, x_2_positive, label="Dados de Treino (y = 1)", seriestype=:scatter, color=:lightgreen)

        # Plotando os pontos de treino com y = -1
        x_1_negative = [x[1] for x in X_negative]
        x_2_negative = [x[2] for x in X_negative]
        plot!(x_1_negative, x_2_negative, label="Dados de Treino (y = -1)", seriestype=:scatter, color=:indianred)

        X_test_positive = dataset.X_test[findall(y -> y == 1, dataset.y_test)]
        X_test_negative = dataset.X_test[findall(y -> y != 1, dataset.y_test)]

        # Plotando os pontos de teste comm y = 1
        x_1_positive_test = [x[1] for x in X_test_positive]
        x_2_positive_test = [x[2] for x in X_test_positive]
        plot!(x_1_positive_test, x_2_positive_test, label="Dados de Teste (y = 1)", seriestype=:scatter, color=:green)

        # Plotando os pontos de teste comm y = -1
        x_1_negative_test = [x[1] for x in X_test_negative]
        x_2_negative_test = [x[2] for x in X_test_negative]
        plot!(x_1_negative_test, x_2_negative_test, label="Dados de Teste (y = -1)", seriestype=:scatter, color=:red)

        fit!(model, dataset.X, dataset.y)

        # Plotando a função objetivo e a função encontrada pelo modelo
        x = [-1, 1]
        f = (x -> -dataset.w[1]*x/dataset.w[2] - dataset.b/dataset.w[2])
        g = (x -> -model.w[1]*x/model.w[2]- model.b/model.w[2])
        plot!(x, [f.(x), g.(x)], label=["f" "g"], legend=:topleft, lw=2)
        xlims!(-1, 1)
        ylims!(-1, 1)
    end

end