local M = {}

-- return true if the `value` is inside the `list`, false otherwise
function M.is_in(value, list)
  for _, item in ipairs(list) do
    if value == item then
      return true
    end
  end
  return false
end

return M
