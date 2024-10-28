mutable struct Repository
    root_directory::Directory
    branches::Dict{String, Branch}

    function Repository()
        new(Directory("root"), Dict())
    end
end
