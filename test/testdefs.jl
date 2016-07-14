# This file is a part of Julia. License is MIT: http://julialang.org/license

using Base.Test

function runtests(name)
    @printf("     \033[1m*\033[0m \033[31m%-21s\033[0m\n", name)
    coolness = @timed @testset "$name" begin
        include("$name.jl")
    end
    #rss = Sys.maxrss()
    #@printf(" in %6.2f seconds, maxrss %7.2f MB\n", tt, rss / 2^20)
    #rss
    #coolness[1] is the testset
    passes,fails,error,broken,c_passes,c_fails,c_errors,c_broken = Base.Test.get_test_counts(coolness[1])
    if coolness[1].anynonpass == false
        coolness = ((passes+c_passes,broken+c_broken), coolness[2], coolness[3], coolness[4], coolness[5])
    else
        println("OH GOD TEST FAILED $name")
    end
    coolness
end

# looking in . messes things up badly
filter!(x->x!=".", LOAD_PATH)
nothing
