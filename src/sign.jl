nextfloat(p::Optim8) = reinterpret(Optim8,reinterpret(UInt8,p)+one(UInt8))
nextfloat(p::Optim16) = reinterpret(Optim16,reinterpret(UInt16,p)+one(UInt16))

prevfloat(p::Optim8) = reinterpret(Optim8,reinterpret(UInt8,p)-one(UInt8))
prevfloat(p::Optim16) = reinterpret(Optim16,reinterpret(UInt16,p)-one(UInt16))

function -(x::Optim8)
    if UInt8(x) == 0x00 || UInt8(x) == 0x80 # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x00 (two's complement def for neg)
        return Optim8(0x00 - UInt8(x))
    end
end

function -(x::Optim16)
    if UInt16(x) == 0x0000 || UInt16(x) == 0x8000 # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x0000 (two's complement def for neg)
        return Optim16(0x0000 - UInt16(x))
    end
end

function abs(x::Optim8)
    if UInt8(x) > 0x80  # negative number reverse sign bit
        return Optim8(0x00 - UInt8(x))
    else
        return x
    end
end

function abs(x::Optim16)
    if UInt16(x) > 0x8000  # negative number reverse sign bit
        return Optim16(0x0000 - UInt16(x))
    else                  # positive number or 0 or NaR
        return x
    end
end

function signbit(x::Optim8)
    if UInt8(x) >= 0x80
        return true
    else
        return false
    end
end

function signbit(x::Optim16)
    if UInt16(x) >= 0x8000
        return true
    else
        return false
    end
end

function sign(p::T) where {T <: AbstractOptim}
    if signbit(p)       # negative and infinity case
        if isfinite(p)  # negative
            return minusone(T)
        else            # infinity
            return zero(T)
        end
    else                # positive and zero case
        if iszero(p)    # zero
            return zero(T)
        else            # positive
            return one(T)
        end
    end
end
