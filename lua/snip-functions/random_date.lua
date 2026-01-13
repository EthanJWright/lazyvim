local function randomDate()
  math.randomseed(os.clock())

  local current_date = os.date("*t")
  local year = current_date.year
  local month = current_date.month

  local days_in_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

  if month == 2 and (year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)) then
    days_in_month[2] = 29
  end

  local day = math.random(1, days_in_month[month])
  local hour = math.random(0, 23)
  local minute = math.random(0, 59)
  local second = math.random(0, 59)
  local millisecond = math.random(0, 999)

  return string.format("%04d-%02d-%02dT%02d:%02d:%02d.%03dZ", year, month, day, hour, minute, second, millisecond)
end

return randomDate
