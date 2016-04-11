require("OpenPredict")

local ver = "1.0"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New version found! " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Gangplank.lua", SCRIPT_PATH .. "Gangplank.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
    else
        PrintChat("No updates found!")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Gangplank.version", AutoUpdate)

class "Gangplank"
function Gangplank:__init()
	-- Prediction
	BarrelPred = { delay = 0.25, speed = math.huge, width = 390, range = 1000 }
	GPR = { delay = 0.25, speed = math.huge, width = 575, range = math.huge }
	-- Variables
	BarrelCount = 0
	Barrel = { }
	-- Callbacks + Orbwalker
	self:LoadWalker()
	Callback.Add("CreateObj", function(Object) self:CreateObj(Object) end)
	Callback.Add("DeleteObj", function(Object) self:DeleteObj(Object) end)
	Callback.Add("Draw", function() self:Draw() end)
	-- Loaded Message
	PrintChat('GP loadded.')
	-- Menu
	MenuG = MenuConfig("Gangplank", "Gangplank")

	MenuG:Menu("c", "Combo")
	MenuG.c:Boolean("Q", "Use Q", true)
	MenuG.c:Boolean("E", "Use E", true)

	MenuG:Menu("h", "Harass")
	MenuG.h:Boolean("Q", "Use Q", true)
	MenuG.h:Boolean("QF", "Use Q Farm", true)
	MenuG.h:Slider("MQ", "Q Mana", 1, 1, 100, 1)
	MenuG.h:Boolean("E", "Use E", true)
	
	MenuG:Menu("f", "Farm")
	MenuG.f:Menu("lh", "LastHit")
	MenuG.f.lh:Boolean("Q", "Use Q Lashit", true)
	MenuG.f:Menu("l", "LaneClear")
	MenuG.f.l:Boolean("Q", "Use Q LaneClear", true)
	MenuG.f.l:Boolean("E", "Use E LaneClear", true)

	MenuG:Menu("d", "Draw")
	MenuG.d:Boolean("EE", "Draw Barrel", true)
	MenuG.d:Boolean("Q", "Draw Q", true)
	MenuG.d:Boolean("E", "Draw E", true)

	MenuG:Menu("m", "Misc")
	MenuG.m:Boolean("AQ", "Use Q Farm Auto", false)
	MenuG.m:Boolean("AE", "Auto Barrel Explode", false)
	MenuG.m:Boolean("W", "Auto W", true)
	MenuG.m:Slider("AW", "W HP", 25, 1, 100, 1)
	MenuG.m:Boolean("AQKS", "Use Q KS Auto", true)
	MenuG.m:Boolean("AR", "Auto KS ult", false)
	MenuG.m:Boolean("ARR", "Auto R if Enemies >= x", false)
	MenuG.m:Slider("ARRS", "Auto R Minimum Enemies", 3, 1, 5, 1)
end

function Gangplank:LoadWalker()
	if IOW_Loaded then
		Callback.Add("Tick", function() self:Loop(IOW:Mode(), "Combo", "LastHit", "LaneClear", "Harass") end)
	end
	if DAC_Loaded then
		Callback.Add("Tick", function() self:Loop(DAC:Mode(), "Combo", "LastHit", "LaneClear", "Harass") end)
	end
	if PW_Loaded then
		Callback.Add("Tick", function() self:Loop(PW:Mode(), "Combo", "LastHit", "LaneClear", "Harass") end)
	end
	if GosWalk_Loaded then
		Callback.Add("Tick", function() self:Loop(GosWalk:GetCurrentMode(), 0, 3, 2) end)
	end
end

function Gangplank:Loop(orb,value,value1,value2,value3)
	enemy = GetCurrentTarget()
	-- Combo
	if orb== value and ValidTarget(enemy, 2000) and EnemiesAround(enemy, 1000) <= 1 and MenuG.c.Q:Value() and MenuG.c.E:Value() then
		self:Combo()
		self:CastQEnemy()
			if not MenuG.m.AE:Value() then
				self:AutoBarrel()
			end
		elseif orb== value and ValidTarget(enemy, 2000) and EnemiesAround(enemy, 1000) > 1 and MenuG.c.Q:Value() and MenuG.c.E:Value() then
			self:AOECOmbo()
			if not MenuG.m.AE:Value() then
				self:AutoBarrel()
			end
	end 
	-- Harass 
	if orb== value3 and EnemiesAround(enemy, 1000) <= 1 and ValidTarget(enemy, 2000) then
		if MenuG.h.QF:Value() and GetPercentMP(myHero) >= MenuG.h.MQ:Value() then
			self:UseQFarm()
		end
		if MenuG.h.Q:Value() and GetPercentMP(myHero) >= MenuG.h.MQ:Value() then
			self:CastQEnemy()
		end
		if MenuG.h.E:Value() then
			self:Combo()
			if not MenuG.m.AE:Value() then
				self:AutoBarrel()
			end
		end
	end
	-- Farm
	if orb == value1 then
		self:UseQFarm()
	end

	if orb == value2 then
		self:LaneClear()
	end
	-- Automatic
	if MenuG.m.AE:Value() then
		self:AutoBarrel()
	end
	if MenuG.m.AR:Value() or MenuG.m.AQKS:Value() then
		self:AutoKS()
	end
	if MenuG.m.AQ:Value() and Ready(_Q) then
		self:UseQFarm()
	end
	if MenuG.m.ARR:Value() and Ready(_R) then
		self:AutoRR()
	end
	if MenuG.m.W:Value() and Ready(_W) then
		self:UseW()
	end
end

function Gangplank:Draw()
	for i, u in pairs(Barrel) do
		local barrel = CanQBarrel()
		if u ~= nil and MenuG.d.EE:Value() then
			if barrel ~= nil then
				DrawCircle(u, 370, 2,30,GoS.Red)
			else
				DrawCircle(u, 370, 2,30,GoS.Blue)
			end
		end
	end
	if Ready(_Q) and MenuG.d.Q:Value() then
		DrawCircle(myHero, 625, 2,30,GoS.Blue)
	end
	if Ready(_E) and MenuG.d.E:Value() then
		DrawCircle(myHero, 1000, 2,30,GoS.Blue)
	end
end

function Gangplank:LaneClear()
	if MenuG.f.l.Q:Value() then
		self:UseQFarm()
	end
	if MenuG.f.l.E:Value() then
		self:MinionE()
	end
end

function Gangplank:Combo()
local estack = myHero:GetSpellData(_E).ammo
		local herof = function() return enemy end
		local hero = herof()
		local barrel = CanQBarrel()
		if Ready(_Q) and Ready(_E) and BarrelCount >= 1 then
			if barrel ~= nil then
				if hero.distance < 1300 and barrel:DistanceTo(hero) <= 780 then
					local prediction = GetCircularAOEPrediction(hero, BarrelPred)
					local predpos = prediction.castPos
					if barrel:DistanceTo(predpos) < 700 and prediction.hitChance >=.45 then
						CastSkillShot(_E, predpos)
					end
				end 
			end
			elseif barrel == nil and Ready(_Q) and Ready(_E) then
				local vectornear = GetOrigin(myHero) + (Vector(GetOrigin(hero)) - GetOrigin(myHero)):normalized() * 150
				local vectorfar = GetOrigin(myHero) + (Vector(GetOrigin(hero)) - GetOrigin(myHero)):normalized() * 350
			if GetDistance(hero, myHero) <= 650 and GetDistance(vectornear, myHero) <= 650 then
					CastSkillShot(_E, vectornear)
				elseif GetDistance(hero, myHero) >= 650 and GetDistance(hero, myHero) <= 1250 and GetDistance(vectorfar, myHero) <= 1250 then
					CastSkillShot(_E, vectorfar)
			end
		end
end

function Gangplank:AutoBarrel()
	local barrel = CanQBarrel()
	if barrel ~= nil then
		local barrelwithenemyf = function() for i,z in pairs(Barrel) do if barrel ~= z and EnemiesAround(z, 370) >= 1 and barrel:DistanceTo(z) < 700 then return z end end end
		local barrelwithenemy = barrelwithenemyf()
		if barrelwithenemy ~= nil and barrel ~= nil and barrel.distance < 625 and EnemiesAround(barrelwithenemy, 370) >= 1 then
			CastTargetSpell(barrel, _Q)
		end
		if barrel ~= nil and EnemiesAround(barrel, 370) >= 1 and barrel.distance < 625 then
			CastTargetSpell(barrel, _Q)
		end
	end
end

function Gangplank:AOECOmbo()
		if Ready(_Q) and Ready(_E) and BarrelCount >= 1 then
			local barrel = CanQBarrel()
			if barrel ~= nil then
				if enemy.distance < 1300 and barrel:DistanceTo(enemy) <= 780 then
					local prediction = GetCircularAOEPrediction(enemy, BarrelPred)
					local predpos = prediction.castPos
					if barrel:DistanceTo(predpos) < 700 and EnemiesAround(predpos, 370) > 1 and prediction.hitChance >=.45 then
						CastSkillShot(_E, predpos)
					end
				end 
			end
			elseif barrel == nil and Ready(_Q) and Ready(_E) then
				local vectornear = GetOrigin(myHero) + (Vector(GetOrigin(enemy)) - GetOrigin(myHero)):normalized() * 150
				local vectorfar = GetOrigin(myHero) + (Vector(GetOrigin(enemy)) - GetOrigin(myHero)):normalized() * 350
			if GetDistance(enemy, myHero) <= 650 and GetDistance(vectornear, myHero) <= 650 then
					CastSkillShot(_E, vectornear)
				elseif GetDistance(enemy, myHero) >= 650 and GetDistance(enemy, myHero) <= 1250 and GetDistance(vectorfar, myHero) <= 1250 then
					CastSkillShot(_E, vectorfar)
			end
		end
end

function CanQBarrel()
	local delay = function() if GetLevel(myHero) >= 13 then return .5 elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 13 then return 1 elseif GetLevel(myHero) < 7 then return 2 end end
	local time = function(target) return target.distance/1700+ .25 end 
	local mod = function(target) return GetCurrentHP(target) * delay() * 1000 end
	local barrelf = function() for i,object in pairs(Barrel) do if object ~= nil and CT ~= nil and (GetTickCount() - CT + time(object) * 1000 > mod(object) or GetCurrentHP(object) == 1) then return object end end end
	local barrel = barrelf()
	if barrel ~= nil then
		return barrel
	end
end

function Gangplank:CastQEnemy()
	if myHero:GetSpellData(_E).ammo == 0 and ValidTarget(enemy, 625) and Ready(_Q) and (CanQBarrel() == nil or GetDistance(CanQBarrel(), enemy) > 1200) then
		CastTargetSpell(enemy, _Q)
	end
end

function Gangplank:MinionE()
	for _,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == MINION_ENEMY then
			local barrel = CanQBarrel()
			if barrel ~= nil then
				local barrelwithenemyf = function() for i,z in pairs(Barrel) do if barrel ~= z and z ~= nil and barrel:DistanceTo(z) < 700 then return z end end end
				local barrelwithenemy = barrelwithenemyf()
				if barrelwithenemy ~= nil and barrel ~= nil and barrel.distance < 625 then
					CastTargetSpell(barrel, _Q)
				end
				if barrel ~= nil and barrel.distance < 625 then
					CastTargetSpell(barrel, _Q)
				end
			end
			if barrel == nil and BarrelCount <= 1 and Ready(_E) and ValidTarget(minion, 1000) then
					local prediction = GetCircularAOEPrediction(minion, BarrelPred)
					local Farm = prediction.castPos
				if Farm ~= nil and MinionsAround(Farm, 370) > 3 then
					CastSkillShot(_E, Farm)
				end
			end
		end
	end
end

function Gangplank:UseQFarm()
	for _,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == MINION_ENEMY then
			local MHP = minion.health
			local z = (GetCastLevel(myHero, _Q)*25)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
			local Dmg = myHero:CalcDamage(minion, z)
			if CanUseSpell(myHero, _Q) == READY and ValidTarget(minion, 625) and MHP <= Dmg then
				CastTargetSpell(minion, _Q)
			end
		end
	end
end

function Gangplank:AutoKS()
	for i,zenmy in pairs(GetEnemyHeroes()) do
		local Pred = GetCircularAOEPrediction(zenmy, GPR)
		local z = (20*GetCastLevel(myHero, _R)+.1*GetBonusAP(myHero)*wavetime()+30)
		if CanUseSpell(myHero, _R) == READY and IsDead(zenmy) == false and ((z > zenmy.health) or GetPercentHP(zenmy)<=15) and MenuG.m.AR:Value() and Pred.hitChance > 0.45 then -- 4 waves min
			CastSkillShot(_R, Pred.castPos)
		end
			local MHP = zenmy.health
			local z = (GetCastLevel(myHero, _Q)*25)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
			local Dmg = myHero:CalcDamage(zenmy, z)
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(zenmy, 625) and Dmg >= zenmy.health and MenuG.m.AQKS:Value() then
			CastTargetSpell(zenmy, _Q)
		end
	end	
end

function wavetime()
	if GotBuff(myHero, "GangplankRUpgrade1") >=1 then
		return 18
	else 
		return 12
	end
end


function Gangplank:AutoRR()
	for i,zenmy in pairs(GetEnemyHeroes()) do
		local Pred = GetCircularAOEPrediction(zenmy, GPR)
		if CanUseSpell(myHero, _R) == READY and IsDead(zenmy) == false and MenuG.m.ARR:Value() and Pred:hCollision(MenuG.m.ARRS:Value()) and EnemiesAround(Pred.castPos, 500) > MenuG.m.ARRS:Value() and AlliesAround(Pred.castPos, 750) > 0 and Pred.hitChance > 0.45 then
			CastSkillShot(_R, Pred.castPos)
		end
	end	
end

function Gangplank:UseW() -- WIP will add more logic
	local CC = {"Stun", "Taunt","Snare","Fear", "Charm", "Suppression", "Blind", "Silence", "Root", "Slow" }
	for _,v in pairs(CC) do
		if CanUseSpell(myHero, _W) == READY and MenuG.m.W:Value() and GotBuff(myHero, v) >= 1 then
			CastSpell(_W)
		end
	end
	if GetPercentHP(myHero)<=MenuG.m.AW:Value() and (GotBuff(myHero, "recall") == 0 or GotBuff(myHero, "odinrecall") == 0) and MenuG.m.W:Value() then
		CastSpell(_W)
	end
end

function Gangplank:CreateObj(Object)
	if GetObjectBaseName(Object) == "Barrel" then
		BarrelCount = BarrelCount + 1
		table.insert(Barrel, Object)
		if BarrelCount == 1 then
			CT = GetTickCount()
		end
	end
end

function Gangplank:DeleteObj(Object)
	if GetObjectBaseName(Object) == "Gangplank_Base_E_AoE_Green.troy" then 
		BarrelCount = BarrelCount - 1
		table.remove(Barrel, 1)
		CT = nil
	end
end


if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
