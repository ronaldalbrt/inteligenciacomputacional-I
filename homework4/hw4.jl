import Base.Math.sqrt
import Base.Math.log
using Plots
using DataFrames

# ----------------------------------------------
# ----------------- Questão 1 ------------------
# ----------------------------------------------
# Definição da função de ponto fixo
function fixed_point_method(f, initial_N, tolerance)
    N = initial_N
    while true
        N_plus_1 = f(N)
        if abs(N_plus_1 - N) < tolerance
            return N_plus_1
        end
        N = N_plus_1
    end
end

# Definição da função de ponto fixo
f(N) = log((4*((2*N)^10 + 1))/0.05)/0.0003125

# Cálculo do resultado
result = fixed_point_method(f, 2, 1e-5)

println(result)


# ----------------------------------------------
# ----------------- Questão 2 ------------------
# ----------------------------------------------

# Definição da dimensão VC
d_vc = 50

# Definição de delta
delta = 0.05


# Definição da Limitante VC
function vc(N)
    sqrt((8/N) * (log(4) + d_vc*log(2*N) - log(delta)))
end

# Definição da Limitante Rademacher
function rademacher(N)
    sqrt(2 * (log(2*N) + d_vc*log(N)) / N) + sqrt(2 * log(1/delta) / N) + 1/N
end

# Definição da Limitante Parrondo e Van den Broek
function parrondo(N, epsilon)
    sqrt(1/N * (2*epsilon + (log(6) + d_vc*log(2*N) - log(delta))))
end

# Definição da Limitante Devroye
function devroye(N, epsilon)
    sqrt((1/(2*N))*(4*epsilon*(1+epsilon) + (log(4)+2*d_vc*log(N)-log(delta))))
end

# Definição das funções de limitantes
bounds = [
    vc, rademacher,
    # Na funções de Parrondo e Devoye que possuem o epsilon como parâmetro, o método
    # do ponto fixo é utilizado para encontrar o valor de epsilon.
    N -> fixed_point_method(epsilon -> parrondo(N, epsilon), 1, 1e-5),
    N -> fixed_point_method(epsilon -> devroye(N, epsilon), 1, 1e-5)
]

# Função para calcular os limitantes para um conjunto de N valores
function compute_bounds(bounds, N_values)
    result = DataFrame(vc=Float64[], rademacher=Float64[], parrondo=Float64[], devroye=Float64[])

    # Itera sobre os valores de N
    for N in N_values
        # Itera sobre os limitantes
        bounds_result = Float64[]
        for bound_func in bounds
            push!(bounds_result, bound_func(N))
        end

        push!(result, bounds_result)
    end
    return result
end

# Conjunto de valores de N
N_values = 10:10000

# Cálculo dos limitantes
bounds_data = compute_bounds(bounds, N_values)

# Plot dos limitantes calculados
plot(Matrix(bounds_data), labels=permutedims(names(bounds_data)), legend=:topright, 
    xlabel="N (samples)", 
    ylabel="generalization error (bound)", 
    ylims = (0, 5))


