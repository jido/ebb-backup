module Files
    import Base.Filesystem

    const ebbdir = ".ebb"
    const currentbranch = "main___21b50"
    const sugar = "20d80639" #string(rand(0x10000000:0xFFFFFFFF), base=16)
    
    function digest(sugar, path)
        output = IOBuffer()
        run(pipeline(IOBuffer(hex2bytes(sugar)), `cat - $path`, `shasum -a 256`, output))
        let r = String(take!(output)), s = split(r)
            return s[1]
        end
    end
    
    function fixedlen_name(file, len)
        parts = splitext(file)
        ext = parts[2]
        extlen = length(ext)
        if (extlen > len - 7)
            extlen = len - 7
            ext = Substring(ext, 1, extlen)
            while !isvalid(ext)
                extlen = extlen - 1
                ext = Substring(ext, 1, extlen)
            end
        end
        prefix = SubString(parts[1], 1, min(length(parts[1]), len - extlen - 6))
        while (!isvalid(prefix))
            prefix = SubString(prefix, 1, length(prefix) - 1)
        end
        random = string(rand(0x10000:0xFFFFF), base=16)
        copyname = rpad(prefix, len - extlen - 5, '_') * random * ext
    end

    function addfile(path)
        hash = digest(sugar, path)
        file = basename(path)
        cd(ebbdir)
        copyname = fixedlen_name(file, 20)
        copypath = joinpath("files", copyname)
        mkpath(dirname(copypath))
        cp(joinpath("..", path), copypath, follow_symlinks=true)
        linkpath = joinpath(currentbranch, "current", path)
        mkpath(dirname(linkpath))
        rel = repeat("../", length(splitpath(dirname(linkpath)))) # should use joinpath
        symlink(rel * copypath, linkpath)
    end

    addfile("Arcdown.adoc")

end