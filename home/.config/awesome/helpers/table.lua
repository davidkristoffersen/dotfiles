local function update(t, other)
    for k, v in pairs(other) do
        t[k] = v
    end
end


return {
    update = update,
}
