Here's an outline for the `ebb` backup tool in Julia:

**ebb.jl**
```julia
module Ebb

# Import necessary packages
using ArgParse
using FileIO

# Define commands
include("commands/touch.jl")
include("commands/ls.jl")
include("commands/cp.jl")

# Function to update repository if it doesn't exist
function init_repository(dir::String)
    # Check if repository already exists
    repo_dir = joinpath(dir, ".ebb_repo")
    if isdir(repo_dir)
        return true
    end

    # Prompt for repository name if it doesn't exist
    println("Repository does not exist. Create a new one? (y/n)")
    response = readline()
    if response == "y"
        mkpath(repo_dir)
        return true
    else
        error("Repository creation cancelled.")
    end
end

# Function to add files to repository
function add_to_repo(files::Array{String})
    # Get current directory
    curr_dir = pwd()

    # Create repository if it doesn't exist
    init_repository(curr_dir)

    # Add files to repository
    for file in files
        # Check if file is already backed up
        repo_file = joinpath(get_repo_dir(), file)
        if isfile(repo_file)
            continue
        end

        # Copy file to repository
        copy(file, repo_file)
    end
end

# Function to get repository directory
function get_repo_dir()
    return findfirst(isequal(".ebb_repo")) do x
        isdir(x)
    end
end

# Function to list files in current directory with backup status
function list_files_with_status(dir::String)
    # Get repository directory
    repo_dir = get_repo_dir()

    # List files with backup status
    files = readdir(dir)
    for file in files
        repo_file = joinpath(repo_dir, file)
        if isfile(repo_file)
            println("$file - Backed up")
        else
            println("$file - Not backed up")
        end
    end
end

# Main function to handle user input
function main()
    # Parse arguments
    args = parse_args(ARGS)

    # Handle touch command
    if args.command == "touch"
        add_to_repo(args.files)
    # Handle ls command
    elseif args.command == "ls"
        list_files_with_status(args.dir)
    # Handle cp command
    elseif args.command == "cp"
        copy_file_from_source_to_target(args.source, args.target)
    end
end

# Run main function
main()

end  # module Ebb
```
This outline provides a basic structure for the `ebb` backup tool in Julia. It defines functions for updating the repository, adding files to the repository, and listing files with their backup status. The `main()` function 
handles user input based on the command specified.

**commands/touch.jl**
```julia
function add_to_repo(files::Array{String})
    # ... (same as above)
end

# Function to handle touch command
function touch(args...)
    # Get current directory
    curr_dir = pwd()

    # Create repository if it doesn't exist
    init_repository(curr_dir)

    # Add files to repository
    add_to_repo(args)
end
```
**commands/ls.jl**
```julia
# Function to handle ls command
function ls()
    list_files_with_status(pwd())
end

# Function to handle ls with file paths
function ls_with_paths(paths::Array{String})
    for path in paths
        list_files_with_status(path)
    end
end
```
**commands/cp.jl**
```julia
# Function to copy files from source to target
function copy_file_from_source_to_target(source::String, target::String)
    # Copy file(s) from source to target
    for src in split(source, ",")
        dst = joinpath(target, basename(src))
        copy(src, dst)
    end

    # Add files to repository if target is backed up
    repo_dir = get_repo_dir()
    if isfile(joinpath(repo_dir, basename(dst)))
        add_to_repo([dst])
    else
        println("Target directory is not backed up. Please use 'ebb touch' command.")
    end
end

# Function to handle cp command
function cp(args...)
    copy_file_from_source_to_target(args[1], args[2])
end
```
This code provides a basic implementation for the `touch`, `ls`, and `cp` commands in Julia. Note that this is just an outline, and you will need to flesh out the details based on your specific requirements.

Also, please keep in mind that this is a simple implementation and does not include any error handling or advanced features. You may want to add those depending on your use case.
