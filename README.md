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
------------------ Questão 7 ------------------
Média de iterações: 9.622
------------------ Questão 8 ------------------
Erro médio: 0.11199999999999963
------------------ Questão 9 ------------------
Média de iterações: 108.861
------------------ Questão 10 ------------------
Erro médio: 0.012749999999999874
```

<h2 align="center">
Módulos
</h2>
O repositório é composto por 3 módulos principais presentes na pasta <strong>src</strong>, são eles <strong> Data.jl </strong>, <strong>PLA.jl</strong> e <strong>Lista1.jl</strong>.

<ul>
    <li><h3>Data.jl</h3></li>
    Módulo onde a Base de Dados é definida. O construtor <code>Dataset(n)</code>, onde <code>n</code> é o número de observações, retorna um objeto <code>Dataset</code> com os campos <code>Dataset.X</code> (conjunto de <i>features</i> para treino), <code>Dataset.y</code> (variáveis objetivo para treino), <code>Dataset.X_test</code> (conjunto de <i>features</i> para teste), <code>Dataset.y_test</code> (variáveis objetivo para teste) e <code>Dataset.target_function</code> (função objetivo gerada aleatoriamente).</br>
    Quando o construtor <code>Dataset(n)</code>, dois pontos aleatórios do espaço [0,1] X [0,1] são selecionados e a reta é que passa por tais pontos é definida como a fronteira de decisão da função objetivo. Após gerada a função objetivo <code>n</code> pontos são gerados no espaço [0, 1] X [0, 1] e classificados de acordo com a função objetivo. O mesmo processo é realizado para a geração dos dados de teste.
    <li><h3>PLA.jl</h3></li>
    Módulo onde o modelo <strong>PLA</strong> é definido. O construtor <code>PLAModel(d)</code>, onde <code>d</code> é a dimensionalidade do modelo, retorna um objeto <code>PLAModel</code> com os campos <code>PLAModel.d</code> (dimensionalidade do modelo), <code>PLAModel.w</code> (vetor de coeficientes do PLA) e <code>PLAModel.b</code> (parâmetro de intercepto do PLA). </br> 
    O módulo exporta as seguintes funções:
    <ul>
    <li><strong>g(model, x)</strong></li>
    Toma como parâmetros um modelo do tipo <code>PLAModel</code> e um vetor x e retonar a previsão de classe do vetor x ($sign (w^Tx + b)$)
    </ul>
</ul>
