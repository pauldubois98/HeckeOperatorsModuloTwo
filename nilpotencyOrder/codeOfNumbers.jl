
function n_3(k)
    k = k >> 1
    i = 0
    n = 0
    while k > 0
        if k & 1 == 1
            n += 2^i
        end
        i += 1
        k = k >> 2
    end
    return n
end

function n_5(k)
    k = k >> 2
    i = 0
    n = 0
    while k > 0
        if k & 1 == 1
            n += 2^i
        end
        i += 1
        k = k >> 2
    end
    return n
end

function h(k)
    return n_3(k) + n_5(k)
end

function g(k)
    return h(k) + 1
end

function code(k)
    return [n_3(k), n_5(k)]
end

function square_powers_2(k)
    i = 0
    n = 0
    while k > 0
        if k & 1 == 1
            n += 2^(2*i)
        end
        i+=1
        k = k >> 1
    end
    return n
end

function number_even(code)
    return 2*square_powers_2(code[1]) + 4*square_powers_2(code[2])
end

function number_odd(code)
    return 2*square_powers_2(code[1]) + 4*square_powers_2(code[2]) + 1
end

