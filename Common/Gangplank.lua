require("OpenPredict")
require("DamageLib")
local ver = "0.7"

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
	MenuG = MenuConfig("Gangplank", "Gangplank")

	MenuG:Menu("c", "Combo")
	MenuG.c:Boolean("Q", "Use Q", true)
	MenuG.c:Boolean("E", "Use E", true)

	MenuG:Menu("f", "Farm")
	MenuG.f:Menu("lh", "LastHit")
	MenuG.f.lh:Boolean("Q", "Use Q Lashit", true)
	MenuG.f:Menu("l", "LaneClear")
	MenuG.f.l:Boolean("Q", "Use Q LaneClear", true)
	MenuG.f.l:Boolean("E", "Use E LaneClear", true)

	MenuG:Menu("m", "Misc")
	MenuG.m:Boolean("AQ", "Use Q Farm Auto", false)
	MenuG.m:Boolean("W", "Use W", true)
	MenuG.m:Boolean("AQKS", "Use Q KS Auto", true)
	MenuG.m:Boolean("AR", "Auto KS ult", false)
	MenuG.m:Boolean("ARR", "Auto R if Enemies >= x", false)
	MenuG.m:Slider("ARRS", "Auto R Minimum Enemies", 3, 1, 5)
	self:LoadWalker()
	BarrelPred = { delay = 0.25, speed = math.huge, width = 390, range = 1000 }
	GPR = { delay = 0.25, speed = math.huge, width = 575, range = math.huge }
	BarrelCount = 0
	Barrel = { }
	Callback.Add("CreateObj", function(Object) self:CreateObj(Object) end)
	Callback.Add("DeleteObj", function(Object) self:DeleteObj(Object) end)
end

function Gangplank:LoadWalker()
	if IOW_Loaded then
		Callback.Add("Tick", function() self:Loop(IOW:Mode(), "Combo", "LastHit", "LaneClear") end)
	end
	if DAC_Loaded then
		Callback.Add("Tick", function() self:Loop(DAC:Mode(), "Combo", "LastHit", "LaneClear") end)
	end
	if PW_Loaded then
		Callback.Add("Tick", function() self:Loop(PW:Mode(), "Combo", "LastHit", "LaneClear") end)
	end
	if GosWalk_Loaded then
		Callback.Add("Tick", function() self:Loop(GetCurrentMode(), 0, 3, 2) end)
	end
end

function Gangplank:Loop(orb,value,value1,value2)
	enemy = GetCurrentTarget()

	if orb== value and ValidTarget(enemy, 2000) then
		self:Combo()
	end

	if orb == value1 then
		self:UseQFarm()
	end

	if orb == value2 then
		self:LaneClear()
	end
	
	if MenuG.m.AQ:Value() then
		self:UseQFarm()
	end

	if MenuG.m.W:Value() then
		self:UseW()
	end

	if MenuG.m.AR:Value() or MenuG.m.AQKS:Value() then
		self:AutoKS()
	end
	
	BarrelNearPlayer()
	KillBarrelWithEnemyNearMe()
	KillBarrelWithEnemy()
	BarrelWithEnemy()
	GetBarrel()
end

function Gangplank:Combo()
	if ValidTarget(enemy, 2000) then
		if MenuG.c.E:Value() then
			self:CastE(enemy)
			self:CastEInception()
			self:CastQBarrels()
		end
		if MenuG.c.Q:Value() then
			self:CastQ()
		end
	end
end

function Gangplank:LaneClear()
	if MenuG.f.l.Q:Value() then
		self:UseQFarm()
	end
end

function Gangplank:CastE(unit)
	if ValidTarget(unit, 2000) and CanUseSpell(myHero, _E) == READY then 
		local barrelnearplayer = BarrelNearPlayer()
		if barrelnearplayer == nil then
			local vectornear = GetOrigin(myHero) + (Vector(GetOrigin(unit)) - GetOrigin(myHero)):normalized() * 150
			local vectorfar = GetOrigin(myHero) + (Vector(GetOrigin(unit)) - GetOrigin(myHero)):normalized() * 350
			if GetDistance(unit, myHero) <= 650 and GetDistance(vectornear, myHero) <= 650 then
				CastSkillShot(_E, vectornear)
				elseif GetDistance(unit, myHero) >= 650 and GetDistance(unit, myHero) <= 1250 and GetDistance(vectorfar, myHero) <= 1250 then
					CastSkillShot(_E, vectorfar)
			end
		elseif barrelnearplayer ~= nil and BarrelHpPred(barrelnearplayer) == true then
		local prediction = GetCircularAOEPrediction(unit, BarrelPred)
		local barrelrework = BarrelFinder(prediction.castPos)
			if barrelrework == nil then
				local predpos = prediction.castPos
				if barrelnearplayer ~= nil and CanUseSpell(myHero, _Q) == READY and GetDistance(predpos, barrelnearplayer) <= 650 then
					CastSkillShot(_E, predpos.x, predpos.y, predpos.z)
					self:CastEInception()
					local barrelcombo = KillBarrelWithEnemyNearMe()
					local barrelwithenemyk = BarrelWithEnemy()
					if barrelcombo ~= nil and barrelwithenemyk ~= nil and BarrelHpPred(barrelcombo) == true and barrelcombo ~= barrelwithenemyk and (GetDistance(barrelcombo, barrelwithenemyk) < 825 or BarrelLinkManager() == true) then
						CastTargetSpell(barrelcombo, _Q)
					end
				end
			end
		end
	end 
end

function Gangplank:CastEInception()
	local barrelcombo = KillBarrelWithEnemyNearMe()
	if barrelcombo ~= nil then
		local barrelwithenemyk = BarrelWithEnemy()
		if barrelwithenemyk ~= nil and GetCurrentHP(barrelwithenemyk) > 1 then
			if barrelwithenemyk ~= nil and BarrelLinkManager() == false and CanUseSpell(myHero, _E) == READY then
				local posit = GetOrigin(barrelcombo) + (Vector(GetOrigin(barrelwithenemyk)) - GetOrigin(barrelcombo)):normalized() *500
				if GetDistance(barrelcombo, barrelwithenemyk) <= 825 and GetDistance(myHero, postit) <= 700 then
					CastSkillShot(_E, posit)
				end
			end
		end
	end
end

function Gangplank:CastQBarrels()
	local barrelcombo = KillBarrelWithEnemyNearMe()
	if barrelcombo ~= nil then
		local barrelwithenemyk = BarrelWithEnemy()
		if barrelwithenemyk ~= nil and GetCurrentHP(barrelwithenemyk) >= 1 and BarrelHpPred(barrelcombo) == true then
			if BarrelLinkManager() == true and CanUseSpell(myHero, _Q) == READY then
				CastTargetSpell(barrelcombo, _Q)
			end
		end
	end
	local Barrelz = KillBarrelWithEnemy()
	if Barrelz ~= nil and CanUseSpell(myHero, _Q) == READY and GetDistance(myHero, Barrelz) <= 625 and BarrelHpPred(Barrelz) == true then
		CastTargetSpell(Barrelz, _Q)
	end
end

function Gangplank:CastQ()
	local barrelc = KillBarrelWithEnemy()
	if CanUseSpell(myHero, _E) == READY and myHero:GetSpellData(_E).ammo >= 1 then
		self:CastQBarrel()
	else 
		if barrelc ~= nil and GetDistance(myHero, barrelc) <= 625 and CanUseSpell(myHero, _Q) == READY and BarrelHpPred(barrelc) == true then
			CastTargetSpell(barrelc, _Q)
		end
		self:CastQEnemy(enemy)
	end
end

function Gangplank:CastQEnemy(unit)
	if ValidTarget(unit, 625) and CanUseSpell(myHero, _Q) and ((CanUseSpell(myHero, _E) ~= READY and GetBarrel() == nil) or (GetBarrel() ~= nil and KillBarrelWithEnemy() == nil)) then
		CastTargetSpell(unit, _Q)
	end
end

function Gangplank:CastQBarrel()
	local barrelc = KillBarrelWithEnemy()
	if barrelc ~= nil and GetDistance(barrelc, myHero) <= 700 then
		if CanUseSpell(myHero, _Q) and GetDistance(myHero, barrelc) <= 625 and BarrelHpPred(barrelc) == true then
			CastTargetSpell(barrelc, _Q)
			local barrelenemy = KillBarrelWithEnemyNearMe()
		elseif barrelenemy ~= nil and barrelc ~= nil then
			if GetDistance(GetOrigin(barrelenemy), barrelc) < 850 and GetDistance(myHero, barrelenemy) <= 700 and BarrelHpPred(barrelenemy) == true then
				CastTargetSpell(barrelenemy, _Q)
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

function Gangplank:UseW() -- WIP will add more logic
	local CC = {"Stun", "Taunt","Snare","Fear", "Charm", "Suppression", "Blind", "Silence", "Root", "Slow" }
	for _,v in pairs(CC) do
		if CanUseSpell(myHero, _W) == READY and MenuG.m.W:Value() and GotBuff(myHero, v) >= 1 then
			CastSpell(_W)
		end
	end
	if GetPercentHP(myHero)<=.25 and GotBuff(myHero, "recall") == 0 and MenuG.m.W:Value() then
		CastSpell(_W)
	end
end

function Gangplank:AutoKS()
	for i,zenmy in pairs(GetEnemyHeroes()) do
		local Pred = GetCircularAOEPrediction(zenmy, GPR)
		local z = (20*GetCastLevel(myHero, _R)+.1*GetBonusAP(myHero)*wavetime()+30)
		if CanUseSpell(myHero, _R) == READY and IsDead(zenmy) == false and ((z*4 > zenmy.health) or GetPercentHP(zenmy)<=0.2) and MenuG.m.AR:Value() and Pred.hitChance > 0.45 then -- 4 waves min
			CastSkillShot(_R, Pred.castPos)
		end
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(zenmy, 625) and getdmg("Q",zenmy,myHero) > zenmy.health and MenuG.m.AQKS:Value() then
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
		if CanUseSpell(myHero, _R) == READY and IsDead(zenmy) == false and MenuG.m.ARR:Value() and Pred:hCollision(MenuG.m.ARR:Value()) and AlliesAround(Pred.castPos, 750) > 0 and Pred.hitChance > 0.45 then
			CastSkillShot(_R, Pred.castPos)
		end
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

function BarrelHpPred(barrel)	
 	if CT ~= nil then
 		if BarrelWithMe() ~= nil and barrel ~= nil then
 			local barrelwithme = BarrelWithMe()
 			if GetCurrentHP(barrel) == 2 and GetLevel(myHero) >= 7 and ((GetTickCount() - CT >= 2*time() - GetLatency()-300) or GetTickCount() - CT >= time() - GetLatency()-300) then 
 				return true
 				elseif GetCurrentHP(barrel) == 1 then
 					return true
 			end
 		end
 	end
end

--[[function QTravelTime(target)
	return GetDistance(myHero, target)/2800 + .25
end]]

function time() -- Return miliseconds for barrel decay
	if GetLevel(myHero) >= 13 then
		return 500
	end
	if GetLevel(myHero) >= 7 and GetLevel(myHero) < 13 then 
		return 1000
	end  
	if GetLevel(myHero) < 7 then
		return 2000
	end
end

function BarrelWithMe()
	for i,object in pairs(Barrel) do
		if object ~= nil and GetDistance(object, myHero) <= 625 then
			return object
		end
	end
end 

function BarrelLinkManager() -- Sorry LongDong got lazy......
	if GetBarrel() ~= nil and GotBuff(GetBarrel(), "gangplankebarrellink") == 1 then
		return true
	end
	return false
end

function BarrelFinder(pos)
	for i,object in pairs(Barrel) do
		if GetDistance(object, pos) <= 120 then
			return object
		end
	end
end

function BarrelNearPlayer()
	for i,object in pairs(Barrel) do
		if GetDistance(myHero, KillBarrelWithEnemy()) <= 1000 then
			return object
		end
	end
end

function KillBarrelWithEnemyNearMe() -- Inspired all credits. Main reason is travel speed to closest barrel so we shoot that.
  local bArrel = nil
  for _,v in pairs(Barrel) do 
    if not bArrel and v then bArrel = v end
    if bArrel and v and (BarrelHpPred(bArrel) == true or BarrelHpPred(v) == true) and GetDistanceSqr(GetOrigin(bArrel),myHero) > GetDistanceSqr(GetOrigin(v),myHero) then
      bArrel = v
    end
  end
  return bArrel
end

function KillBarrelWithEnemy()
	for i,object in pairs(Barrel) do
		if object ~= nil and EnemiesAround(object, 380) >= 1 and BarrelHpPred(object) == true then 
			return object
		end
	end
end

function BarrelWithEnemy()
	for i,object in pairs(Barrel) do
		if object ~= nil and EnemiesAround(object, 380) >= 1 then
			return object
		end
	end
end

function GetBarrel()
	for i,object in pairs(Barrel) do
		if  object ~= nil then
			return object
		end
	end
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
