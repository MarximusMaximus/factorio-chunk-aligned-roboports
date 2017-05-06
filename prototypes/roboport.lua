local round = function(x)
  return math.floor(x+0.5)
end

local roboport = data.raw["roboport"]["roboport"]
local radiusRatio = 16 / roboport.logistics_radius
local extraConstructionRadius = roboport.construction_radius - 2 * roboport.logistics_radius -- 0.15.9: 55 - 2 * 25 == 5
local radiusRatioSquared = radiusRatio * radiusRatio
roboport.logistics_radius = 16
roboport.construction_radius = 2 * roboport.logistics_radius + extraConstructionRadius

-- TODO use the prototype value
local oldEnergyUsage = tonumber(roboport.energy_usage:sub(1,-3))
local oldUnit = roboport.energy_usage:sub(-2)
roboport.energy_usage = round(oldEnergyUsage * radiusRatioSquared) .. oldUnit

local recipe = data.raw["recipe"]["roboport"]
local ingredients = recipe.ingredients
for _,entry in ipairs(ingredients) do
  entry[2] = round(entry[2] * radiusRatioSquared)
end