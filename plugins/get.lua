local function get_variables_hash(msg)
  if msg.to.type == 'chat' or msg.to.type == 'channel' then
    return 'chat:'..msg.to.id..':variables'
  end
end 

local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return value
    end
  end
end

local function run(msg, matches)
  if not is_momod(msg) then -- only for mods,owner and admins
  end
  if matches[1] then
    local name = user_print_name(msg.from)
    savelog(msg.to.id, name.." ["..msg.from.id.."]".. matches[1])-- save to logs
    return get_value(msg, matches[1])
  else
    return
  end
end

return {
  patterns = {
    "^(.+)$"
  },
  run = run
}
