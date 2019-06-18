function createTableMul(v::Array{Float64,1})

    n = length(v)
    if n == 2^7-1   # 8bit case
        table = Array{UInt8,2}(undef,n,n)
    elseif n == 2^15-1
        table = Array{UInt16,2}(undef,n,n)
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        for j in 1:n
            table[i,j] = round(v[i]*v[j],v)
        end
    end

    return table
end

function createTableAdd(v::Array{Float64,1})

    n = length(v)
    if n == 2^7-1   # 8bit case
        table = Array{UInt8,2}(undef,n,n)
    elseif n == 2^15-1
        table = Array{UInt16,2}(undef,n,n)
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        for j in 1:n
            table[i,j] = round(v[i]+v[j],v)
        end
    end

    return table
end
