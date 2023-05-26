module LinearRegression

    export LinearRegressionModel, fit!, g, error_measure

    # Estrutura de dados que representa o modelo de Regressão Linear
    mutable struct LinearRegressionModel
        d::Int64
        w::Array{Float64,1}
        b::Float64
    end


    # Construtor da estrutura de dados LinearRegressionModel
    function LinearRegressionModel(d)
        w = zeros(d)
        b = 0

        return LinearRegressionModel(d, w, b)
    end

    # Função que calcula a saída do modelo
    function g(model::LinearRegressionModel, x)
        return sign(model.w' * x + model.b)
    end

    # Função que realiza o treinamento do modelo
    function fit!(model::LinearRegressionModel, X::Vector{T}, y::Array{Int64,1}) where {T}
        X_with_intercept = hcat([vcat(x, 1) for x in X]...)'
        pseudo_inverse = inv(X_with_intercept' * X_with_intercept) * X_with_intercept'
        
        w_vector = pseudo_inverse * y
        model.w = w_vector[1:end-1]
        model.b = w_vector[end]

        return -1
    end

    # Função que calcula o Erro Médio Quadrático da Regressão Linear do modelo
    function error_measure(model::LinearRegressionModel, X_test::Vector{T}, y_test::Array{Int64,1}) where {T}
        g_model = x -> g(model, x) 

        y_pred = g_model.(X_test)

        return sum(y_pred .!= y_test) / length(y_test)
    end 
end