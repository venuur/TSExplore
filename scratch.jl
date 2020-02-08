using Revise
using TSExplore
using Plots

plot(hcat([simulate(AR1Model(1.0), zeros(1), randn(101), randn(100).*0.01)[1] for _ in 1:10]...))
plot(hcat([simulate(ARMA11Model(1.0, 1.0), zeros(2), randn(101), randn(100).*0.01)[1] for _ in 1:10]...))
