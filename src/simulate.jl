# Uses obs_eq, state_eq

export simulate

function simulate(m, x0, w, v)
    @assert length(w) == length(v) + 1
    obs = similar(w, length(w))
    state = similar(obs)
    state[1] = x0
    obs[1] = obs_eq(m, state[1], w[1])
    for i in eachindex(v)
        obs[i] = obs_eq(m, state[i], w[i])
        state[i+1] = state_eq(m, state[i], v[i])
    end
    obs[end] = obs_eq(m, state[end], w[end])
    obs, state
end
