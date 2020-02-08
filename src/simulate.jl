# Uses obs_eq, state_eq

export simulate

function simulate(m, x0, w, v; squeeze=true)
    @assert length(w) == length(v) + 1
    state = similar(w, length(x0), length(w))
    state[:, 1] .= x0
    first_obs = obs_eq(m, view(state, :, 1), w[1])
    obs = similar(w, length(first_obs), length(w))
    obs[:, 1] .= first_obs
    for i in eachindex(v)
        obs[:, i] .= obs_eq(m, view(state, :, i), w[i])
        state[:, i+1] .= state_eq(m, view(state, :, i), v[i])
    end
    obs[:, end] .= obs_eq(m, view(state, :, size(state)[2]), w[end])
    if squeeze && size(obs)[1] == 1
        obs = reshape(obs, :)
    end
    if squeeze && size(state)[1] == 1
        state = reshape(state, :)
    end
    obs, state
end
