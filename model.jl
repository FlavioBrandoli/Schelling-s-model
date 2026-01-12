function initialize_model(;
    dims = (40,40),
    vacancy_frac = 0.02,
    seed = 123,
    tolerance = 0.65
    )

    rng = MersenneTwister(seed)
    space = GridSpace(dims, periodic = false)

    Npos = round(Int, dims[1]*dims[2])

    Nagents = round(Int, (1-vacancy_frac)*Npos)

    Npairs = round(Int, Nagents/2)

    interface_fraction = 0.0

    Nunhappy = 0

    properties = Dict(
        :rng => rng,
        :vacancy_frac => vacancy_frac,
        :dims => dims,
        :Nagents => Nagents,
        :Npos => Npos,
        :Npairs => Npairs,
        :tolerance => tolerance,
        :interface_fraction => interface_fraction,
        :Nunhappy => Nunhappy
    )

    model = AgentBasedModel(Agente, space; properties, rng)


    for n in 1:Npairs
        add_agent_single!(model,1,false)
        add_agent_single!(model,2,false)
    end

    model.interface_fraction = calculate_interface_fraction(model)
    model.Nunhappy = unhappy_counter(model)

    return model

end


function agent_step_relative!(agent::Agente, model::ABM)

    agent.happy = calculate_happiness_relative(agent.pos, agent, model)

    if !agent.happy 

        empty_pos = shuffle(model.rng, collect(empty_positions(model)))
        initial_pos = agent.pos

        for pos in empty_pos

            potential_happiness = calculate_happiness_relative(pos, agent, model)

            if potential_happiness
               
                move_agent!(agent, pos, model)

                agent.happy = potential_happiness

                break

            end

        end

    end

end


function model_step!(model::ABM) 

    model.interface_fraction = calculate_interface_fraction(model)
    model.Nunhappy = unhappy_counter(model)

end
