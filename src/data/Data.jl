module Data
    export Dataset, polynomial_mapping

    using Distributions, StatsBase, Combinatorics

    struct Dataset
        n::Int64
        X::Vector{Vector{Float64}}
        y::Vector{Int64}
        X_test::Vector{Vector{Float64}}
        y_test::Vector{Int64}
        target_function::Function
        w::Union{Array{Float64,1}, Nothing}
        b::Union{Float64, Nothing}
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

    function Dataset(n::Int64=1000; target_function=nothing, noisy=false) 
        if target_function === nothing
             # Gerando função objetivo
            target_function, w, b = generate_target_function()
        else
            w = nothing
            b = nothing
        end

        # Gerando pontos aleatórios
        X = [rand(Uniform(-1, 1), 2) for i in 1:n]
        y = target_function.(X)

        # Gerando pontos de teste
        X_test = [rand(Uniform(-1, 1), 2) for i in 1:n]
        y_test = target_function.(X_test)

        # Adicionando ruído
        if noisy
            noisy_idx = sample(1:n, Int64(round(n * 0.1)), replace=false)

            y[noisy_idx] = -y[noisy_idx]
            y_test[noisy_idx] = -y_test[noisy_idx]
        end

        return Dataset(n, X, y, X_test, y_test, target_function, w, b)
    end

    # Função que mapeia os dados para um espaço polinomial de grau d
    function polynomial_mapping(X::Vector{Vector{Float64}}, d::Int64)
        transformed_X = [copy(x) for x in X]

        for i in 2:d
            for combination in with_replacement_combinations(1:length(X[1]), i)
                column_to_add = ones(length(X))

                for i in combination
                    column_to_add = column_to_add .* [x[i] for x in X]
                end
                
                transformed_X = [push!(transformed_X[k], column_to_add[k]) for k in 1:length(X)]
            end
        end
        
        return transformed_X
    end

end