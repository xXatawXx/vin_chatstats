Utils = {
    format_thousand = function(v)
      local s = string.format("%d", math.floor(v))
      local pos = string.len(s) % 3
      if pos == 0 then pos = 2 end
      return string.sub(s, 1, pos)
              .. string.gsub(string.sub(s, pos + 1), "(...)", ".%1")
    end,
    playerHealth = function()
      local plyPed = GetPlayerPed(-1)
      local plyHealth = (GetEntityHealth(plyPed) - 100)
      return plyHealth
    end,
    Draw3DText = function(coords, message, txtColor)
      local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
      local camCoords = GetGameplayCamCoords()
      local scale = ((1 / GetDistanceBetweenCoords(camCoords, coords, true)) * 2) * ((1 / GetGameplayCamFov()) * 100)
      local txtColor = txtColor or color
    
      if onScreen then
        SetTextColour(txtColor.r, txtColor.g, txtColor.b, txtColor.a)
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(font)
        SetTextProportional(true)
        SetTextCentre(true)
    
        BeginTextCommandDisplayText('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandDisplayText(x, y)
      end
    end,
      tablelength = function(t)
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
      end    
  }
  
RegisterCommand('stats', function(source)
    TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
    TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
    TriggerEvent('esx_status:getStatus', 'stress', function(stress)
      local playerhealth = Utils.playerHealth()
      local myfood = hunger["val"]
      local mywater = thirst["val"]
      local mystress = stress["val"]
        TriggerEvent('chat:addMessage', {
          template = '<div style="display: inline-block !important; padding: 0.6vw; padding-top: 0.6vw; padding-bottom: 0.7vw; margin: 0.1vw; margin-left: 0.4vw; border-radius: 10px; background-color: rgba(255, 215, 0, 0.9); color: white; width: fit-content; max-width: 50%; overflow: hidden; word-break: break-word; ">* {0} Health: {1}HP Hunger: {2} Thirst: {3} Stress: {4}</div>',
          args = { '[STATS]', {playerhealth}, {Utils.format_thousand(myfood)..'%'}, {Utils.format_thousand(mywater)..'%'}, {Utils.format_thousand(mystress).. '%'} }
      })
    end)
    end)
    end)
end)
  

