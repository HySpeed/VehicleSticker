-- Valdation functions called by modules

local Constants = require( "common.constants" )

local Validators = {}

-- =============================================================================

function Validators.validateColorRGB( r, g, b )
  if r == nil or r < 0 or r > 255 then return false end
  if g == nil or g < 0 or g > 255 then return false end
  if b == nil or b < 0 or b > 255 then return false end
  return r, g, b
end

-- -----------------------------------------------------------------------------

function Validators.validateMessage( message )
  if type( message ) ~= "string" then message = "" end
  if message == "" then
    game.print( { "", {"vs-text.name"}, {"vs-error.add_wagon_sticker_fail"} }, Constants.COLOR.ERROR )
    return false
  end
  return true
end

-- -----------------------------------------------------------------------------

-- Ensure given player name is in the game
function Validators.validatePlayerName( player_name )
  local player = nil
  if player_name then
    player = game.players[player_name]
    if not player then
      game.print( { "", {"vs-text.name"}, {"vs-error.player_not_found", player_name} }, Constants.COLOR.ERROR )
    end
    else
    game.print( { "", {"vs-text.name"}, {"vs-error.player_name_required"} }, Constants.COLOR.ERROR )
  end
return player
end

-- -----------------------------------------------------------------------------


-- =============================================================================

return Validators
