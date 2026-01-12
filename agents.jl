
mutable struct Agente <: AbstractAgent
    id::Int
    pos::Tuple{Int,Int}
    group::Int
    happy::Bool
end