<h1 align="center">
<br> Inteligência Computacional I
</h1>
Repositório para as tarefas da Disciplina de Inteligência Computacional I no <a href="https://www.cos.ufrj.br/" >Programa de Engenharia de Sistemas e Computação</a> da <a href="https://ufrj.br/" >UFRJ - Universidade Federal do Rio de Janeiro</a>, ministrada pelo Prof. Carlos Eduardo Pedreira.

Desenvolvido por Ronald Albert.
<h2 align="center">
A linguagem Julia
</h2>
Todo o repositório está implemetado na linguagem <a href="https://julialang.org/">Julia</a>. Para a realização dos experimentos, o seguinte código deve ser executado na linha de comando:

```console
julia run.jl
```

A execução do programa deve ter como resultado, valores próximos dos apresentados abaixo:

```console
------------------ Questão 5 ------------------
Erro médio: 0.03891000000000012
------------------ Questão 6 ------------------
Erro médio: 0.0477800000000001
------------------ Questão 7 ------------------
Média de iterações: 3.482
------------------ Questão 8 ------------------
Erro médio:  0.5070110000000004
------------------ Questão 9 ------------------
Coeficientes w:  [0.00011439145349225554, -0.0002951624903763268, 1.5589581977342248, -0.0012691220046117824, 1.556829940546003]
Coeficiente b: -0.9932872422544256
------------------ Questão 10 ------------------
Erro médio: 0.12652500000000005
------------------ Questão 11.1 ------------------
Erro médio: 0.19339399999999993
------------------ Questão 11.2 ------------------
Erro médio: 0.14751199999999995
------------------ Questão 11.3 ------------------
Erro médio: 0.1447530000000002
------------------ Questão 11.4 ------------------
Erro médio: 0.13584100000000027
```

<h2 align="center">
Módulos
</h2>
O repositório é composto por 3 módulos principais presentes na pasta <strong>src</strong>, são eles <strong> Data.jl </strong>, <strong>PLA.jl</strong> e <strong>Lista1.jl</strong>.

<ul>
    <li><h3>Data.jl</h3></li>
    Módulo onde a Base de Dados é definida. O construtor <code>Dataset(n)</code>, onde <code>n</code> é o número de observações, retorna um objeto <code>Dataset</code> com os campos <code>Dataset.X</code> (conjunto de <i>features</i> para treino), <code>Dataset.y</code> (variáveis objetivo para treino), <code>Dataset.X_test</code> (conjunto de <i>features</i> para teste), <code>Dataset.y_test</code> (variáveis objetivo para teste), <code>Dataset.target_function</code> (função objetivo gerada aleatoriamente), <code>Dataset.w</code> (coeficientes da função objetivo gerada aleatoriamente) e <code>Dataset.b</code> (intercepto da função objetivo gerada aleatoriamente).</br>
    Quando o construtor <code>Dataset(n)</code>, dois pontos aleatórios do espaço [0,1] X [0,1] são selecionados e a reta é que passa por tais pontos é definida como a fronteira de decisão da função objetivo. Após gerada a função objetivo <code>n</code> pontos são gerados no espaço [0, 1] X [0, 1] e classificados de acordo com a função objetivo. O mesmo processo é realizado para a geração dos dados de teste.
    <li><h3>PLA.jl</h3></li>
    Módulo onde o modelo <strong>PLA</strong> é definido. O construtor <code>PLAModel(d)</code>, onde <code>d</code> é a dimensionalidade do modelo, retorna um objeto <code>PLAModel</code> com os campos <code>PLAModel.d</code> (dimensionalidade do modelo), <code>PLAModel.w</code> (vetor de coeficientes do PLA) e <code>PLAModel.b</code> (parâmetro de intercepto do PLA). </br> 
    O módulo exporta as seguintes funções:
    <ul>
    <li><strong>g(model, x)</strong></li>
    Toma como parâmetros um modelo do tipo <code>PLAModel</code> e um vetor x e retonar a previsão de classe do vetor x (sign(w'x + b)).
    <li><strong>fit!(model, X, y)</strong></li>
    Toma como parâmetros um modelo do tipo <code>PLAModel</code> uma matrix de dados de treino X e um vetor de variáveis objetivo Y. Estima os melhores parâmetros para <code>model.w</code> e <code>model.b</code>, de acordo com o processo de otimização apresentado em aula.
    <li><strong>error_measure(model, X_test, y_test)</strong></li>
    Toma como parâmetros um modelo do tipo <code>PLAModel</code> uma matrix de dados de teste X_test e um vetor de variáveis objetivo y_test e retorna a acurácia do modelo estimado.
    </ul>
    <li><h3>LinearRegression.jl</h3></li>
    Módulo onde o modelo <strong>LinearRegression</strong> é definido. O construtor <code>LinearRegression(d)</code>, onde <code>d</code> é a dimensionalidade do modelo, retorna um objeto <code>LinearRegressionModel</code> com os campos <code>LinearRegressionModel.d</code> (dimensionalidade do modelo), <code>LinearRegressionModel.w</code> (vetor de coeficientes da Regressão Linear) e <code>LinearRegressionModel.b</code> (parâmetro de intercepto da Regressão Linear). </br> 
    O módulo exporta as seguintes funções:
    <ul>
    <li><strong>g(model, x)</strong></li>
    Toma como parâmetros um modelo do tipo <code>LinearRegressionModel</code> e um vetor x e retonar a previsão de classe do vetor x (sign(w'x + b)).
    <li><strong>fit!(model, X, y)</strong></li>
    Toma como parâmetros um modelo do tipo <code>LinearRegressionModel</code> uma matrix de dados de treino X e um vetor de variáveis objetivo Y. Estima os melhores parâmetros para <code>model.w</code> e <code>model.b</code>, de acordo com o processo de otimização apresentado em aula.
    <li><strong>error_measure(model, X_test, y_test)</strong></li>
    Toma como parâmetros um modelo do tipo <code>LinearRegressionModel</code> uma matrix de dados de teste X_test e um vetor de variáveis objetivo y_test e retorna a acurácia do modelo estimado.
    </ul>
    <li><h3>Lista1.jl</h3></li>
    Módulo onde está definida a função <code>run_experiment(n)</code> que gera um conjuntos de dados, estima os parâmetos do modelo <strong>PLA</strong> e calcula a acurácia <code>n</code> vezes.</br>
    E a função <code>plot_data(n)</code> que gera um conjunto de dados, estima os parâmetros do modelo e combina todas essas informações em um gráfico com auxílio da biblioteca <strong>Plots.jl</strong> do Julia.
    <li><h3>Lista2.jl</h3></li>
    Módulo onde estão definidos todos os experimentos definidos para os exercícios de implemetação da Lista 2. Onde <code>run_experiment_1</code> é o experimento referente às questões 5 e 6, <code>run_experiment_2</code> é o experimento referente à questão 7, <code>run_experiment_3</code> é o experimento referente às questões 8, 9 e 10 e <code>run_experiment_4</code> é o experimento referente à questão 11. 
</ul>
