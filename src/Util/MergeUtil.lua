local function merge(...: table?): table
  local new = {}

  for _, dictionary in ipairs({ ... }) do
    if type(dictionary) ~= "table" then
      continue
    end

    for key, value in pairs(dictionary) do
      new[key] = value
    end
  end

  return new
end

return {
  Merge = merge,
}
