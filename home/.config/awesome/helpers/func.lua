--- ### Description
--- Wrap a function in a callback that can be called later
--- ### Parameters
--- @param func function The function to wrap
--- ### Returns
--- @return function callback The wrapped function
local function cb(func)
    return function (...)
        local args = ...
        return function () func(args) end
    end
end

--- ### Description
--- Strip the first argument from a function
--- ### Parameters
--- @param func function The function to remove the first argument from
--- ### Returns
--- @return function callback The modified function
local function noSelf(func)
    return function (_, ...) func(...) end
end

--- ### Description
--- Wrap a function in a callback that can be called later
--- Discards the first argument
--- ### Parameters
--- @param func function The function to wrap
--- ### Returns
--- @return function callback The wrapped function
local function noSelfCb(func)
    return function (_, ...)
        local args = ...
        return function () func(args) end
    end
end

return {
    cb = cb,
    noSelf = noSelf,
    noSelfCb = noSelfCb,
}
