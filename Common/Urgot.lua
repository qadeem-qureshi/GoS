require("Inspired")
require("OpenPredict")

QPred = { delay = 0.25, speed = 1600, width = 80, range = 1000 }
EPred = { delay = 0.25, speed = 1750, radius = 150, range = 950 }

Config = Menu("Urgot", "Urgot")
Config:SubMenu("c", "Combo")
Config.c:Boolean("Q1", "Use Q", true)
Config.c:Boolean("Q2", "Use E", true)
Config.c:Slider("hE", "HitChance E", 20, 0, 100, 1)
Config.c:Slider("hQ", "HitChance Q", 20, 0, 100, 1)

  Callback.Add("Tick", function() Loop() end)
function Loop()
	local unit = GetCurrentTarget()
	local EPred = GetCircularAOEPrediction(unit, EPred) -- Filthy Zwei PogChamp
	local QPred = GetPrediction(unit, QPred) -- Filthy Zwei PogChamp
	if IOW:Mode() == "Combo" then
		if Config.c.Q2:Value() and CanUseSpell(myHero, _E) and EPred and EPred.hitChance >= (Config.c.hE:Value()/100) then
			CastSkillShot(_E, EPred.castPos)
		end
		if Config.c.Q1:Value() and CanUseSpell(myHero, _Q) and QPred and QPred.hitChance >= (Config.c.hQ:Value()/100) and GotBuff(unit, "urgotcorrosivedebuff") == 0 and not QPred:mCollision(1) then
			CastSkillShot(_Q, QPred.castPos)
			elseif Config.c.Q1:Value() and CanUseSpell(myHero, _Q) and GotBuff(unit, "urgotcorrosivedebuff") >= 1 then
				CastSkillShot(_Q, GetOrigin(unit)) -- Filthy Zwei PogChamp
		end
	end
end
