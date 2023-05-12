import Pkg
Pkg.activate(".")
Pkg.instantiate()

import Lista1

using Statistics

n_iterations_10 = []
n_error_10 = []

n_iterations_100 = []
n_error_100 = []
for i in 1:1000
    iterations_10, err_10 = Lista1.run_experiment()
    iterations_100, err_100 = Lista1.run_experiment(100)

    push!(n_iterations_10, iterations_10)
    push!(n_error_10, err_10)
    push!(n_iterations_100, iterations_100)
    push!(n_error_100, err_100)
end

#---------------------------------------------------------------
# Questão 7
#---------------------------------------------------------------
println("------------------ Questão 7 ------------------")
println("Média de iterações: ", mean(n_iterations_10))

#---------------------------------------------------------------
# Questão 8
#---------------------------------------------------------------
println("------------------ Questão 8 ------------------")
println("Erro médio: ", mean(n_error_10))

#---------------------------------------------------------------
# Questão 9
#---------------------------------------------------------------
println("------------------ Questão 9 ------------------")
println("Média de iterações: ", mean(n_iterations_100))

#---------------------------------------------------------------
# Questão 10
#---------------------------------------------------------------
println("------------------ Questão 10 ------------------")
println("Erro médio: ", mean(n_error_100))
