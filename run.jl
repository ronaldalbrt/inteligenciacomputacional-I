import Pkg
Pkg.activate(".")
Pkg.instantiate()

import InteligenciaComputacional.Lista2

using Statistics

# Vetor com os erros In-Sample da Questão 5
n_error_in_sample = []

# Vetor com os erros Out of Sample da Questão 6
n_error_out_of_sample = []

# Vetor com os números de iterações da Questão 7
n_steps_until_convergence = []

# Vetor com os erros In-Sample da Questão 8
n_error_non_linear_function = []
# Vetores com os coeficientes w e b da Questão 9
n_w_non_linear_function = []
n_b_non_linear_function = []

# Vetor com os erros Out of Sample da Questão 10
n_error_non_linear_out_of_sample = []

n_error_k_10 = []
n_error_k_50 = []
n_error_k_10_lin_regression = []
n_error_k_50_lin_regression = []
for i in 1:1000
    # Questões 5 e 6
    error_in_sample, error_out_of_sample = Lista2.run_experiment_1()

    # Questão 7
    steps_until_convergence = Lista2.run_experiment_2()

    # Questões 8, 9 e 10
    error_non_linear_function, 
    w_non_linear_function, b_non_linear_function,
    error_non_linear_out_of_sample = Lista2.run_experiment_3()

    # Questão 11
    error_k_10, error_k_50, 
    error_k_10_lin_regression, 
    error_k_50_lin_regression = Lista2.run_experiment_4()

    push!(n_error_in_sample, error_in_sample)
    push!(n_error_out_of_sample, error_out_of_sample)
    push!(n_steps_until_convergence, steps_until_convergence)
    push!(n_error_non_linear_function, error_non_linear_function)
    push!(n_w_non_linear_function, w_non_linear_function)
    push!(n_b_non_linear_function, b_non_linear_function)
    push!(n_error_non_linear_out_of_sample, error_non_linear_out_of_sample)
    push!(n_error_k_10, error_k_10)
    push!(n_error_k_50, error_k_50)
    push!(n_error_k_10_lin_regression, error_k_10_lin_regression)
    push!(n_error_k_50_lin_regression, error_k_50_lin_regression)
end

#---------------------------------------------------------------
# Questão 5
#---------------------------------------------------------------
println("------------------ Questão 5 ------------------")
println("Erro médio: ", mean(n_error_in_sample))

#---------------------------------------------------------------
# Questão 6
#---------------------------------------------------------------
println("------------------ Questão 6 ------------------")
println("Erro médio: ", mean(n_error_out_of_sample))

#---------------------------------------------------------------
# Questão 7
#---------------------------------------------------------------
println("------------------ Questão 7 ------------------")
println("Média de iterações: ", mean(n_steps_until_convergence))

#---------------------------------------------------------------
# Questão 8
#---------------------------------------------------------------
println("------------------ Questão 8 ------------------")
println("Erro médio:  ", mean(n_error_non_linear_function))


#---------------------------------------------------------------
# Questão 9
#---------------------------------------------------------------
println("------------------ Questão 9 ------------------")
println("Coeficientes w:  ", mean(n_w_non_linear_function), 
    "\nCoeficiente b: ", mean(n_b_non_linear_function))

#---------------------------------------------------------------
# Questão 10
#---------------------------------------------------------------
println("------------------ Questão 10 ------------------")
println("Erro médio: ", mean(n_error_non_linear_out_of_sample))

#---------------------------------------------------------------
# Questão 11.1
#---------------------------------------------------------------
println("------------------ Questão 11.1 ------------------")
println("Erro médio: ", mean(n_error_k_10))

#---------------------------------------------------------------
# Questão 11.2
#---------------------------------------------------------------
println("------------------ Questão 11.2 ------------------")
println("Erro médio: ", mean(n_error_k_50))

#---------------------------------------------------------------
# Questão 11.3
#---------------------------------------------------------------
println("------------------ Questão 11.3 ------------------")
println("Erro médio: ", mean(n_error_k_10_lin_regression))

#---------------------------------------------------------------
# Questão 11.4
#---------------------------------------------------------------
println("------------------ Questão 11.4 ------------------")
println("Erro médio: ", mean(n_error_k_50_lin_regression))