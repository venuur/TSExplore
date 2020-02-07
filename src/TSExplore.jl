module TSExplore

### Work through of Ch. 8 Brockwell and Davis 2002,
### "Introduction to Time Series and Forecasting," 2nd ed.


"""
The notation `WN(0, Rt²)` denotes an uuncorrelated sequence of random variables with mean
zero and standard deviation `Rt` at each time index `t`.
"""

## Observation equation p. 260
export obs_eq

"""
    Yt = Gt Xt + Wt

The variable `Wt` is independent zero mean white noise with standard deviation `Rt` for each
`t`.

"""
obs_eq(Gt, Xt, Wt) = Gt*Xt + Wt

## State equation p. 260
export state_eq

"""
    X(t+1) = Ft Xt + Vt

The variable `Vt` is independent zero mean white noise with standard deviation `Qt` for each
`t`.

"""
state_eq(Ft, Xt, Vt) = Ft*Xt + Vt

## Example 8.1.1 AR(1) process

export ar1_eq_direct, AR1Model

"""
    y(t+1) = ϕYt + Zt

The process `Zt ~ WN(0, σ²)`

"""
ar1_eq_direct(ϕ, y, z) = ϕ*y + z

# In state space notation.
struct AR1Model
    ϕ
end

obs_eq(m::AR1Model, x, z) = obs_eq(one(z), x, zero(z))
state_eq(m::AR1Model, x, z) = state_eq(m.ϕ, x, z)

## Example 8.1.2 ARMA(1,1) process

"""
    y(t+1) = ϕYt + Zt + θZ(t-1)

The process `Zt ~ WN(0, σ²)`

"""
arma11_eq_direct(ϕ, θ, y, zt, ztm1) = ϕ*y + z + θ*ztm1

# In State Space notation
struct ARMA11Model
    ϕ  # AR param
    θ  # MA param



### Simulate utilities for exploring processes.
include("simulate.jl")

end # module
