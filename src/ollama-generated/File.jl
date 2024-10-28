mutable struct File
    name::String
    revision_history::Vector{Commit}
    backup_status::Bool
    content::String

    function File(name::String)
        new(name, Commit[], false, "")
    end
end
