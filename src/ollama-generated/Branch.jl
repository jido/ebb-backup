mutable struct Branch
    name::String
    commits::Vector{Commit}
    current_commit::Commit

    function Branch(name::String)
        new(name, Commit[], Commit())
    end
end
