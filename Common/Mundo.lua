require("OpenPredict")

local ver = "2.1"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New version found! " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Mundo.lua", SCRIPT_PATH .. "Mundo.lua", function() PrintChat("<font color=\"#D9A300\"><b>[Mundo OnS]:</b></font><font color=\"#FFFFFF\"> Update Complete, please 2x F6!</font>") return end)
    else
       PrintChat("<font color=\"#D9A300\"><b>[Mundo OnS]:</b></font><font color=\"#FFFFFF\"> No Updates Found!</font>")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Mundo.version", AutoUpdate)

--local summonerNameOne = myHero:GetSpellData(SUMMONER_1).name
--local summonerNameTwo = myHero:GetSpellData(SUMMONER_2).name
--local ignite = (summonerNameOne:lower():find("summonerdot") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerdot") and SUMMONER_2 or nil))

class "DrMundo"
function DrMundo:__init()
	Q = { delay = 0.275, speed = 2000, width = 60, range = 1000}
	W = { delay = 0.25, speed = math.huge, width = 0, range = 325}
	E = { delay = 0.25, speed = math.huge, width = 0, range = GetRange(myHero)+25}
	R = { delay = 0.25, speed = math.huge, width = 0, range = 0} 
	Callback.Add("Load", function() self:Load() Mundo_LoadSprite()  end)
end

function DrMundo:Load()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() Mundo_DrawSprite() if M.d.Q:Value() and Ready(_Q) then DrawCircle(myHero, Q.range, 2,30,GoS.Blue) end end)
	Callback.Add("CreateObj", function(Obj) Mundo_CreateObj(Obj) end)
	Callback.Add("DeleteObj", function(Obj) Mundo_DeleteObj(Obj) end)
	M = MenuConfig("Mundo", "Dr.Mundo")
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Slider("QM", "Minimum Q HP?", 10, 1, 100, 1)
			M.c:Boolean("W", "Use W", true)
			M.c:Slider("WM", "Minimum W HP?", 25, 1, 100, 1)
			M.c:Boolean("E", "Use E", true)
		M:Menu("h", "Harass")
			M.h:Boolean("Q", "Use Q", true)
			M.h:Slider("QM", "Minimum Q HP?", 10, 1, 100, 1)
		M:Menu("f", "Farm")
			M.f:Boolean("QL", "Use Q LastHit", true)
			M.f:Slider("QLM", "Minimum Q LastHit HP?", 40, 1, 100, 1)
			M.f:Boolean("EL", "Use E LastHit Big Min", true)
			M.f:Boolean("QC", "Use Q LaneClear", true)
			M.f:Slider("QCM", "Minimum Q LaneClear HP?", 50, 1, 100, 1)
			M.f:Boolean("WC", "Use W LaneClear", true)
			M.f:Slider("WCM", "Minimum W LaneClear HP?", 60, 1, 100, 1)
			M.f:Boolean("QJ", "Use Q JungleClear", true)
			M.f:Slider("QJM", "Minimum Q JungleClear HP?", 50, 1, 100, 1)
			M.f:Boolean("WJ", "Use W JungleClear", true)
			M.f:Slider("WJM", "Minimum W JungleClear HP?", 60, 1, 100, 1)
			M.f:Boolean("EJ", "Use E JungleClear", true)
		M:Menu("k", "KillSteal")
			M.k:Boolean("Q", "Use Q", true)
			M.k:Boolean("I", "Use Ignite", true)
		M:Menu("m", "Misc")
			M.m:Boolean("R", "Use R Auto", true)
			M.m:Slider("RM", "Minimum R HP?", 20, 1, 100, 1)
			M.m:Boolean("RE", "Dont waste R?", true)
			M.m:Boolean("Z", "Turn off W automatically?", true)
		M:Menu("d", "Drawings!")
 			M.d:DropDown("OP", "Choose Meme?", 1, {"Kappa", "Salt", "Doge", "None :("}, function() DownloadSprites(Mundo_Sprite[M.d.OP:Value()], true) end)
			M.d:Boolean("Q", "Draw Q Range", true)
			PrintChat("<font color=\"#D9A300\"><b>[Mundo OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
end

function DrMundo:AutoAttackd()
	if PW:Mode() == "Combo" and M.c.E:Value() and Ready(_E) then
		if ValidTarget(Enemy, E.range) then
			CastSpell(_E)
		end
	end
	if PW:Mode() == "LaneClear" and M.f.EJ:Value() and Ready(_E) then 
		for i, u in pairs(minionManager.objects) do
			if GetTeam(u) == MINION_JUNGLE then
				if u.distance < E.range+100 then
					CastSpell(_E)
				end
			end
		end
	end
end

function DrMundo:Tick() 
	PW:AddCallback(AFTER_ATTACK, self:AutoAttackd())
	Enemy = GetCurrentTarget()
	if not myHero.dead then
		if M.m.Z:Value() then
			if PW:Mode() ~= "Combo" and PW:Mode() ~= "Harass" and not PW:Mode() ~= "LaneClear" or PW:Mode() ~= "LastHit" then
				if GotBuff(myHero, "BurningAgony") >= 1 and Ready(_W) and not (MinionsAround(myHero, 450, MINION_ENEMY) >= 1 or MinionsAround(myHero, 450, MINION_JUNGLE) >= 1  or ValidTarget(Enemy, 650)) then
					CastSpell(_W) 
				end
			end
		end
		if PW:Mode() == "Combo"  and ValidTarget(Enemy, Q.range) then
			self:Combo()
		end
		if PW:Mode() == "Harass"  and ValidTarget(Enemy, Q.range) and M.h.Q:Value() and GetPercentHP(myHero) > M.h.QM:Value() then
			self:Harass()
		end
		if PW:Mode() == "LaneClear" then
			if MinionsAround(myHero, Q.range, MINION_ENEMY) >= 1 then 
				self:LaneClear()
			end
			if MinionsAround(myHero, Q.range, MINION_JUNGLE) >= 1 then 
				self:JungleClear()
			end
		end
		if PW:Mode() == "LastHit" and Ready(_Q) and M.f.QL:Value() and GetPercentHP(myHero) > M.f.QLM:Value() then
			self:LastHit()
		end
		if EnemiesAround(myHero, 1100) >= 1 then 
			self:KillSteal()
		end
		if M.m.R:Value() and Ready(_R) then
			self:AutoR()
		end 
	end
end

function DrMundo:Combo()
	if not ValidTarget(Enemy, Q.range) then return end
	if M.c.Q:Value() and GetPercentHP(myHero) > M.c.QM:Value() and Ready(_Q) then
		local pred = GetPrediction(Enemy, Q)
		if pred.hitChance > .65 and not pred:mCollision(1) then
			CastSkillShot(_Q, pred.castPos)
		end
	end
	if M.c.W:Value() and GetPercentHP(myHero) > M.c.WM:Value() and ValidTarget(Enemy, W.range) and Ready(_W) and GotBuff(myHero, "BurningAgony") == 0 then
		CastSpell(_W)
		elseif M.c.W:Value() and (GetPercentHP(myHero) < M.c.WM:Value() or GetDistance(Enemy, myHero) > 450 or ValidTarget(Enemy, Q.range) == nil) and GotBuff(myHero, "BurningAgony") >= 1 and Ready(_W) then
			CastSpell(_W)
	end
end

function DrMundo:Harass()
	if not ValidTarget(Enemy, Q.range) then return end
	if M.h.Q:Value() and GetPercentHP(myHero) > M.h.QM:Value() and Ready(_Q) then
		local pred = GetPrediction(Enemy, Q)
		if pred.hitChance > .65 and not pred:mCollision(1) then
			CastSkillShot(_Q, pred.castPos)
		end
	end
end

function DrMundo:LaneClear()
	for i, u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY then
			local Hp, aggro = GetHealthPrediction(u, Q.delay+u.distance/Q.speed)
			local z = math.max((2.5*GetCastLevel(myHero, _Q)+12.5)*GetCurrentHP(u)/100,50*GetCastLevel(myHero, _Q)+30)
			local Dmg = myHero:CalcDamage(u, z)
			if M.f.QC:Value() and GetPercentHP(myHero) > M.f.QCM:Value() and Ready(_Q) and Dmg > Hp and u.distance < Q.range and not u.dead  then
					CastSkillShot(_Q, u)
			end      
		end
	end
	if M.f.WC:Value() and GetPercentHP(myHero) > M.f.WCM:Value() and MinionsAround(myHero, W.range, MINION_ENEMY) >= 1 and Ready(_W) and GotBuff(myHero, "BurningAgony") == 0 then
		CastSpell(_W)
	end
	if GotBuff(myHero, "BurningAgony") >= 1 and Ready(_W) and (MinionsAround(myHero, 450, MINION_ENEMY) < 1 or GetPercentHP(myHero) < M.f.WCM:Value()) then
		CastSpell(_W) 
	end  
end

function DrMundo:LastHit()
	for i, u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY then
			local Hp, aggro = GetHealthPrediction(u, Q.delay+u.distance/Q.speed)
			local z = math.max((2.5*GetCastLevel(myHero, _Q)+12.5)*GetCurrentHP(u)/100,50*GetCastLevel(myHero, _Q)+30)
			local Dmg = myHero:CalcDamage(u, z) 
			if M.f.QL:Value() and GetPercentHP(myHero) > M.f.QLM:Value() and Ready(_Q) and Dmg > Hp and u.distance < Q.range and not u.dead then
					CastSkillShot(_Q, u)
			end
			if u.charName == "SRU_ChaosMinionSiege" or u.charName == "SRU_OrderMinionSiege" then
				local m = math.max(GetBaseDamage(myHero)+20*GetCastLevel(myHero, _E))
				if M.f.EL:Value() and Ready(_E) and m > u.health and u.distance < E.range and not u.dead then
					CastSpell(_E) 
				end
			end 
		end
	end
end

function DrMundo:JungleClear()
	for i, u in pairs(minionManager.objects) do
		if u.team == MINION_JUNGLE then
			if u.distance < Q.range and not u.dead then
				if M.f.QJ:Value() and GetPercentHP(myHero) > M.f.QJM:Value() and Ready(_Q) then
					CastSkillShot(_Q, u)
				end
			end
		end
	end
	if M.f.WJ:Value() and GetPercentHP(myHero) > M.f.WJM:Value() and MinionsAround(myHero, W.range, MINION_JUNGLE) >= 1 and Ready(_W) and GotBuff(myHero, "BurningAgony") == 0 then
		CastSpell(_W)
	end 
	 if GotBuff(myHero, "BurningAgony") >= 1 and Ready(_W) and (MinionsAround(myHero, 450, MINION_JUNGLE) < 1 or GetPercentHP(myHero) < M.f.WJM:Value()) then
		CastSpell(_W) 
	end  
end

function DrMundo:KillSteal()
	for i, h in pairs(GetEnemyHeroes()) do
		local pred = GetPrediction(h, Q)
		local z = math.max((2.5*GetCastLevel(myHero, _Q)+12.5)*GetCurrentHP(h)/100,50*GetCastLevel(myHero, _Q)+30)
		if M.k.Q:Value() and ValidTarget(h, 1000) and Ready(_Q) and pred.hitChance > .65 and z > h.health and not pred:mCollision(1) then
			CastSkillShot(_Q, h)
		end
		--[[local ignitedamage = 70 + 20*GetLevel(myHero) 
		print(ignitedamage)
		if ValidTarget(h, 660) and ignite ~= nil and h.health < ignitedamage and M.k.I:Value() and Ready(ignite) then
			CastTargetSpell(h, SUMMONER_2)
		end]]
	end
end

function DrMundo:AutoR()
	local fountain = function() for i, f in pairs(GetTurrets()) do if GetDistance(myHero, f) < 1000 and (f.name == "Turret_OrderTurretShrine_A" or f.name == "Turret_ChaosTurretShrine_A") then return true end end end
	if M.m.RE:Value() and M.m.RM:Value() >= GetPercentHP(myHero) and EnemiesAround(myHero, Q.range) > 0 and not fountain() then
		CastSpell(_R)
		elseif M.m.RM:Value() >= GetPercentHP(myHero) and M.m.RE:Value() == false and not fountain() then
			CastSpell(_R) 
	end
end	

--[[local myspriteID = {["Salt"] = CreateSpriteFromFile("\\DrMundo\\Salt.png"), ["Kappa"] = CreateSpriteFromFile("\\DrMundo\\Kappa.png"), ["Doge"] = CreateSpriteFromFile("\\DrMundo\\Doge.png"), ["Platypus"] = CreateSpriteFromFile("\\DrMundo\\Platypus.png") }

function DrMundo:CreateObj(Obj)
	if GetObjectBaseName(Obj) == "DrMundo_Base_Q_mis.troy" then
		savedobject = Obj
	end
end
function DrMundo:DeleteObj(Obj)
	if GetObjectBaseName(Obj) == "DrMundo_Base_Q_mis.troy" then
		savedobject = nil
	end
end

function DrMundo:DrawMeme()
	if M.d.meme:Value() == 5 or savedobject == nil then return end 
	if M.d.meme:Value() ~= 5 and savedobject ~= nil then
		local pos = WorldToScreen(1, Vector(savedobject))
		DrawSprite(myspriteID[tablez[M.d.meme:Value()][,pos.x, pos.y,0,0,0,0,ARGB(255,255,255,255)) 
	end
end]]

function Mundo_LoadSprite()
    Mundo_Sprite = {
    [1] = { name = "Kappa.png", width = 25, height = 28, path = SPRITE_PATH.."Mundo\\Kappa.png", link = "https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Mundo/Kappa.png" },
    [2] = { name = "Salt.png",  width = 36, height = 30, path = SPRITE_PATH.."Mundo\\Salt.png",  link = "https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Mundo/Salt.png" },
    [3] = { name = "Doge.png",  width = 33, height = 33, path = SPRITE_PATH.."Mundo\\Doge.png",  link = "https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Mundo/Doge.png" }
    }
    savedobject, run = nil, nil

    if not DirExists(SPRITE_PATH.."Mundo\\") then CreateDir(SPRITE_PATH.."Mundo\\") end
      if Mundo_Sprite[M.d.OP:Value()] then DownloadSprites(Mundo_Sprite[M.d.OP:Value()], false) end
end

local function Mundo_Print(text)
    PrintChat(string.format("<font color=\"#D9A300\"><b>[Mundo OnS]:</b></font><font color=\"#FFFFFF\"> %s</font>", tostring(text)))
end

function DownloadSprites(table, boolean)
    if boolean and M.d.OP:Value() < 4 and FileExist(table.path) then
      local OPP = Mundo_Sprite[M.d.OP:Value()].name:gsub(".png", "")
      Mundo_Print("Meme has been changed to "..OPP..". Have fun")
    elseif boolean and M.d.OP:Value() == 4 then
      Mundo_Print("Meme has been Disabled. much sad :(")
    end

    if not table then return end
    if FileExist(table.path) then run = Sprite("Mundo\\"..table.name, table.width, table.height, 0, 0, 1.6) return end
    Mundo_Print("Please wait for download "..table.name)
    DelayAction(function() DownloadFileAsync(table.link, table.path, function() Mundo_Print(table.name.." has been downloaded. Have fun") DelayAction(function() run = Sprite("Mundo\\"..table.name, table.width, table.height, 0, 0, 1.6) end, 0.1)  end) end, 1)
end

function Mundo_CreateObj(Obj)
    if GetObjectBaseName(Obj) == "DrMundo_Base_Q_mis.troy" then
        savedobject = Obj
    end
end

function Mundo_DeleteObj(Obj)
    if GetObjectBaseName(Obj) == "DrMundo_Base_Q_mis.troy" then
        savedobject = nil
    end
end

function Mundo_DrawSprite()
    if M.d.OP:Value() == 4 or savedobject == nil or run == nil then return end
      local sprite = Mundo_Sprite[M.d.OP:Value()]
      if FileExist(sprite.path) then
        local Pos = WorldToScreen(1, Vector(savedobject))
        run:Draw(Pos.x - sprite.width*0.8, Pos.y - sprite.height*0.8, GoS.White)
      end
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
