function calculate_happiness_relative(pos::Tuple{Int,Int}, agent::Agente, model::ABM)

    neighbors = collect(neig for neig in nearby_agents(pos, model, 1) if neig.pos != pos)

    n_neighbors = length(neighbors)

    if n_neighbors == 0
        return true 
    end

    other_neigh_counter = 0.0
    
    for neighbor in neighbors
        if neighbor.group != agent.group
            other_neigh_counter += 1
        end
    end

    other_neigh_fraction = other_neigh_counter/n_neighbors

    if other_neigh_fraction <= model.tolerance
        happiness = true
    else
        happiness = false
    end

    return happiness

end

function calculate_happiness_absolute(pos::Tuple{Int,Int}, agent::Agente, model::ABM)

    neighbors = collect(neig for neig in nearby_agents(pos, model, 1) if neig.pos != pos)

    n_neighbors = length(neighbors)

    if n_neighbors == 0
        return true 
    end

    same_neigh_counter = 0.0
    
    for neighbor in neighbors
        if neighbor.group == agent.group
            same_neigh_counter += 1
        end
    end

    same_neigh_absolute_fraction = same_neigh_counter/8

    if same_neigh_absolute_fraction >= (1-model.tolerance)
        happiness = true
    else
        happiness = false
    end

    return happiness

end


function plot_model(model; title="", legend_on=true)
    
    agent_color(a) = a.group == 1 ? :blue : :red
    agent_size(a) = 15

    fig, ax, abmobs = abmplot(
        model;
        ac = agent_color,
        as = agent_size,
        legend = false, 
        figure = (; resolution = (600, 600))
    )

    dims = size(abmspace(model))
    ax.xticks = 0.5:1:(dims[1] + 0.5)
    ax.yticks = 0.5:1:(dims[2] + 0.5)
    ax.xgridstyle = :dash
    ax.ygridstyle = :dash
    ax.xticksvisible = false
    ax.yticksvisible = false
    ax.xticklabelsvisible = false
    ax.yticklabelsvisible = false

    ax.title = title

    if legend_on
        
        CairoMakie.scatter!(ax, [-1], [-1], color=:dodgerblue, label="Gruppo 1")
        CairoMakie.scatter!(ax, [-1], [-1], color=:darkorange, label="Gruppo 2")
        
        CairoMakie.xlims!(ax, 0, dims[1]+1)
        CairoMakie.ylims!(ax, 0, dims[2]+1)
    end

    return fig
end

function calculate_interface_fraction(model::ABM) 

    Nlinks = 0.0
    Ninterfaces = 0.0

    for agent in allagents(model)

        for neig in nearby_agents(agent, model, 1)

            if agent.id < neig.id

                Nlinks += 1
                
                if agent.group != neig.group
                    Ninterfaces += 1
                end
            end
        end
    end

    return Ninterfaces/Nlinks
end

function plot_model!(ax, model; legend_on=false)
    
    agent_color(a) = a.group == 1 ? :blue : :red
    agent_size(a) = 15

    abmplot!(
        ax, model;
        ac = agent_color,
        as = agent_size,
        legend = false 
    )

    dims = size(abmspace(model))
    ax.xticks = 0.5:1:(dims[1] + 0.5)
    ax.yticks = 0.5:1:(dims[2] + 0.5)
    ax.xgridstyle = :dash
    ax.ygridstyle = :dash
    ax.xticksvisible = false
    ax.yticksvisible = false
    ax.xticklabelsvisible = false
    ax.yticklabelsvisible = false

    if legend_on
        CairoMakie.scatter!(ax, [-1], [-1], color=:dodgerblue, label="Gruppo 1")
        CairoMakie.scatter!(ax, [-1], [-1], color=:darkorange, label="Gruppo 2")
        CairoMakie.xlims!(ax, 0, dims[1]+1)
        CairoMakie.ylims!(ax, 0, dims[2]+1)
    end
    
    return 
end

function unhappy_counter(model::ABM)
    counter = 0
    for agent in allagents(model)
        if !agent.happy
            counter+= 1
        end
    end
    return counter
end