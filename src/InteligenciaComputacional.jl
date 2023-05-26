module InteligenciaComputacional
    
    include("data/Data.jl")
    include("models/LinearRegression.jl")
    include("models/PLA.jl")
    include("listas/Lista1.jl")
    include("listas/Lista2.jl")

    using .Data, .LinearRegression, .PLA, .Lista1, .Lista2, Plots
end