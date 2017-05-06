local round = function(x)
  return math.floor(x+0.5)
end

local function rescaleRecipe(recipe, factor)
  local ingredients = recipe.ingredients
  for _,entry in ipairs(ingredients) do
    if entry[2] then
      entry[2] = math.max(round(entry[2] * factor), 1)
    elseif entry.amount then
      entry.amount = math.max(round(entry.amount * factor), 1) 
    else
      error("unknown ingredient format " .. serpent.dump(entry))    
    end
  end
end

return rescaleRecipe
