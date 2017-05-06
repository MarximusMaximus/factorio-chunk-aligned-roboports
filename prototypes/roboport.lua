local round = function(x)
  return math.floor(x+0.5)
end

local function rescaleRoboportEntity(entity, newLogisticRadius)
  local radiusRatio = newLogisticRadius / entity.logistics_radius
  local extraConstructionRadius = entity.construction_radius - 2 * entity.logistics_radius -- 0.15.9: 55 - 2 * 25 == 5
  local radiusRatioSquared = radiusRatio * radiusRatio
  entity.logistics_radius = newLogisticRadius
  entity.construction_radius = 2 * newLogisticRadius + extraConstructionRadius

  local oldEnergyUsage = entity.energy_usage
  local oldEnergyUsageNumber = tonumber(oldEnergyUsage:sub(1,-3))
  local oldUnit = oldEnergyUsage:sub(-2)
  entity.energy_usage = round(oldEnergyUsageNumber * radiusRatioSquared) .. oldUnit

  return radiusRatioSquared
end

local function rescaleRoboportRecipe(recipe, radiusRatioSquared)
  local ingredients = recipe.ingredients
  for _,entry in ipairs(ingredients) do
    entry[2] = math.max(round(entry[2] * radiusRatioSquared), 1)
  end
end

local function rescaleRoboport(name, newLogisticRadius)
  local entity = data.raw["roboport"][name]
  local radiusRatioSquared = rescaleRoboportEntity(entity, newLogisticRadius)
  local recipe = data.raw["recipe"][name]
  rescaleRoboportRecipe(recipe, radiusRatioSquared)
end

rescaleRoboport("roboport", 16)

if data.raw['roboport']["bob-roboport-2"] then
  rescaleRoboport("bob-roboport-2", 16*2)
end
if data.raw['roboport']["bob-roboport-3"] then
  rescaleRoboport("bob-roboport-3", 16*3)
end
if data.raw['roboport']["bob-roboport-4"] then
  rescaleRoboport("bob-roboport-4", 16*4)
end
