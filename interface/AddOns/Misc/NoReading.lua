hooksecurefunc("DoEmote", function(emote)
  if emote == "READ" and UnitChannelInfo("player") then
    CancelEmote()
  end
end)
