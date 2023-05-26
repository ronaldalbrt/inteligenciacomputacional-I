module PLA

    export PLAModel, fit!, g, error_measure

    using StatsBase
    
    # Estrutura de dados que representa o modelo Perceptron Learning 
    mutable struct PLAModel
        d::Int64
        w::Array{Float64,1}
        b::Float64
    end

    # Construtor da estrutura de dados PLAModel
    function PLAModel(d)
        w = zeros(d)
        b = 0

        return PLAModel(d, w, b)
    end

    function g(model, x)
        return sign(model.w' * x + model.b)
    end

    # Função que realiza o treinamento do modelo
    function fit!(model::PLAModel, X::Vector{T}, y::Array{Int64,1}) where {T}
        # Função que calcula a saída do modelo
        g_model = x -> g(model, x) 

        # Encontrando os pontos classificados incorretamente
        misclassified_points = findall(x -> x == 1, g_model.(X) .!= y)

        n_iterations = 0

        while !isempty(misclassified_points)
            # Escolhendo um ponto aleatório classificado incorretamente
            misclassified_idx = sample(misclassified_points)
            misclassified_X = X[misclassified_idx]
            misclassified_y = y[misclassified_idx]

            # Atualizando os parâmetros do modelo
            model.w = model.w + misclassified_y * misclassified_X
            model.b = model.b + misclassified_y

            # Encontrando os pontos classificados incorretamente
            misclassified_points = findall(x -> x == 1, g_model.(X) .!= y)

            n_iterations += 1
        end

        # Retornando o número de iterações
        return n_iterations
    end

    # Função que calcula a acurácia do modelo
    function error_measure(model::PLAModel, X_test::Vector{T}, y_test::Array{Int64,1}) where {T}
        g_model = x -> g(model, x) 

        y_pred = g_model.(X_test)

        return sum(y_pred .!= y_test) / length(y_test)
    end 
end