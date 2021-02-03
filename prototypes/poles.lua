local rescaleRecipe = require('prototypes/util')

local round = function(x)
  return math.floor(x+0.5)
end

local function rescalePoleEntity(entity, newReach, newSupplyRadius)
  local reachRatio = newReach / entity.maximum_wire_distance
  local supplyRatio = newSupplyRadius / entity.supply_area_distance
  entity.maximum_wire_distance = newReach
  entity.supply_area_distance = newSupplyRadius
  return reachRatio * supplyRatio
end

local function rescalePole(name, newReach, newSupplyRadius)
  local entity = data.raw['electric-pole'][name]
  local costFactor = rescalePoleEntity(entity, newReach, newSupplyRadius)
  local recipe = data.raw['recipe'][name]
  rescaleRecipe(recipe, costFactor)
end

local function rescaleIfFound(name, newReach, newSupplyRadius)
  if data.raw['electric-pole'][name] then
    rescalePole(name, newReach, newSupplyRadius)
  end
end

-- big pole
rescaleIfFound('big-electric-pole', 32, 2)   -- 4 needed for 4 chunks
rescaleIfFound('big-electric-pole-2', 43, 2) -- 3 needed for 4 chunks
rescaleIfFound('big-electric-pole-3', 48, 2) -- 2 needed for 3 chunks
rescaleIfFound('big-electric-pole-4', 64, 2) -- 2 needed for 4 chunks

-- substation
rescaleIfFound('substation', 16, 16)
rescaleIfFound('substation-2', 22, 22)
rescaleIfFound('substation-3', 24, 24)
rescaleIfFound('substation-4', 32, 32)
