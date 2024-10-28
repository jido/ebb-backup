mutable struct Commit
    hash::String
    author::String
    message::String
    files_changed::Vector{File}

    function Commit(hash::String, author::String, message::String)
        new(hash, author, message, File[])
    end
end
