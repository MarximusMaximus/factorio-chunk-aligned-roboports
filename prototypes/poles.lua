local rescaleRecipe = require("prototypes/util")

local round = function(x)
  return math.floor(x+0.5)
end

-- big pole
do
  local bigPole = data.raw["electric-pole"]["big-electric-pole"]
  local radiusRatio = 32 / bigPole.maximum_wire_distance
  local radiusRatioSquared = radiusRatio * radiusRatio
  bigPole.maximum_wire_distance = 32

  local recipe = data.raw["recipe"]["big-electric-pole"]
  rescaleRecipe(recipe, radiusRatioSquared)
end

-- substation
do
  local substation = data.raw["electric-pole"]["substation"]
  local radiusRatio = 8 / substation.supply_area_distance
  local radiusRatioSquared = radiusRatio * radiusRatio  
  substation.maximum_wire_distance = 16 + 2
  substation.supply_area_distance = 8
  
  local recipe = data.raw["recipe"]["substation"]
  rescaleRecipe(recipe, radiusRatioSquared)
end
