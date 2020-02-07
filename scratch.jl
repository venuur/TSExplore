using Revise
using TSExplore

function simulate(f, g, x)
    y = similar(x)
    w = rand(2, 1, 10)
    v = rand(2, 1, 10)
    for i = 1:10
        y = obs_eq(g, x, view(w, :, :, i))
        println(y)
        x = state_eq(f, x, view(v, :, :, i))
    end
end
let f = [1 2; -1 1],
    g = [10 2; -10 1],
    x = rand(2)
    simulate(f, g, x)
end

function simulate(m, x0, w, v)
    @assert length(w) == length(v) + 1
    obs = similar(w, length(w))
    state = similar(obs)
    state[1] = x0
    obs[1] = obs_eq(m, state[1], w[1])
    for i = eachindex(v)
        obs[i] = obs_eq(m, state[i], w[i])
        state[i+1] = state_eq(m, state[i], v[i])
    end
    obs[end] = obs_eq(m, state[end], w[end])
    obs, state
end
