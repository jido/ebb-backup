mutable struct Directory
    name::String
    files::Vector{File}
    subdirectories::Vector{Directory}
    backup_status::Bool

    function Directory(name::String)
        new(name, File[], Directory[], false)
    end
end
