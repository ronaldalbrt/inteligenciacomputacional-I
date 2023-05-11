module Data
    export Dataset

    using Distributions

    struct Dataset
        n::Int64
        X::Vector{Vector{Float64}}
        y::Vector{Int64}
        X_test::Vector{Vector{Float64}}
        y_test::Vector{Int64}
        target_function::Function
        w::Array{Float64,1}
        b::Float64
    end

    function generate_target_function()
        # Gerar dois pontos aleatórios em [-1, 1] x [-1, 1]
        x = rand(Uniform(-1, 1), (2,2))
        
        # Calcular a equação da reta que passa por esses dois pontos
        # y = ax + b
        a = (x[2,2] - x[1,2]) / (x[2,1] - x[1,1])
        b = x[1,2] - a * x[1,1]

        w = [a, -1]
        return x -> sign(w' * x + b), w, b
    end

    function Dataset(n::Int64=1000) 
        # Gerando função objetivo
        target_function, w, b = generate_target_function()

        # Gerando pontos aleatórios
        X = [rand(Uniform(-1, 1), 2) for i in 1:n]
        y = target_function.(X)

        # Gerando pontos de teste
        X_test = [rand(Uniform(-1, 1), 2) for i in 1:n]
        y_test = target_function.(X_test)

        return Dataset(n, X, y, X_test, y_test, target_function, w, b)
    end

end