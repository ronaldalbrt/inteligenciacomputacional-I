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

n_error_non_linear_function = []
n_w_non_linear_function = []
n_b_non_linear_function = []
n_error_non_linear_out_of_sample = []
for i in 1:1000
    error_in_sample, error_out_of_sample = Lista2.run_experiment_1()

    steps_until_convergence = Lista2.run_experiment_2()

    error_non_linear_function, 
    w_non_linear_function, b_non_linear_function,
    error_non_linear_out_of_sample = Lista2.run_experiment_3()

    push!(n_error_in_sample, error_in_sample)
    push!(n_error_out_of_sample, error_out_of_sample)
    push!(n_steps_until_convergence, steps_until_convergence)
    push!(n_error_non_linear_function, error_non_linear_function)
    push!(n_w_non_linear_function, w_non_linear_function)
    push!(n_b_non_linear_function, b_non_linear_function)
    push!(n_error_non_linear_out_of_sample, error_non_linear_out_of_sample)
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
    "\n Coeficiente b: ", mean(n_b_non_linear_function))

#---------------------------------------------------------------
# Questão 10
#---------------------------------------------------------------
println("------------------ Questão 9 ------------------")
println("Erro médio: ", mean(n_error_non_linear_out_of_sample))