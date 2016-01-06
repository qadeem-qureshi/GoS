require("Inspired_new")
require("OpenPredict")

class "Gangplank"
function Gangplank:__init()
	MenuG = MenuConfig("Gangplank", "Gangplank")

	MenuG:Menu("c", "Combo")
	MenuG.c:Section("h", "Defaults")
	MenuG.c.h:Boolean("Q", "Use Q", true)
	MenuG.c.h:Boolean("QB", "Use Q on Barrel", true)
	MenuG.c.h:Boolean("W", "Use W", true)
	MenuG.c.h:Boolean("E", "Use E", true)
	MenuG.c.h:Slider("BarrelLinkM", "Minimum Barrel Link", 2, 1, 5)

	MenuG:Menu("f", "Farm")
	MenuG.f:Section("lh", "LastHit")
	MenuG.f.lh:Boolean("Q", "Use Q Lashit", true)
	MenuG.f:Section("l", "LaneClear")
	MenuG.f.l:Boolean("Q", "Use Q LaneClear", true)
	MenuG.f.l:Boolean("QB", "Use Q on Barrel", true)
	MenuG.f.l:Boolean("E", "Use E LaneClear", true)
	MenuG.f.l:Slider("BarrelLinkM", "Minimum Barrel Link", 2, 1, 5)

	MenuG:Menu("m", "Misc")
	MenuG.m:Section("m", "Others")
	MenuG.m.m:Boolean("AQ", "Use Q Farm Auto", false)
	MenuG.m.m:Boolean("AR", "Auto KS ult", false)
	MenuG.m.m:Boolean("ARR", "Auto R if Enemies >= x", false)
	MenuG.m.m:Slider("ARRS", "Auto R Minimum Enemies", 3, 1, 5)

	BarrelPred = { delay = 0.25, speed = 1700, width = 400, range = 630 }
	BarrelCount = 0
	Killablebarrels = {}
	Killablebarrels2 = {}
	Callback.Add("Tick", function() self:Loop() end)
	Callback.Add("CreateObj", function(Object) self:CreateObj(Object) end)
	Callback.Add("DeleteObj", function(Object) self:DeleteObj(Object) end)
	LoadIOW()
end

function Gangplank:Loop()
	if IOW:Mode() == "Combo" then
		self:Combo()
	end
	if IOW:Mode() == "LastHit" and MenuG.f.lh.Q:Value() then
		self:LastHit()
	end
	if IOW:Mode() == "LaneClear" and (MenuG.f.l.Q:Value() or MenuG.f.l.E:Value()) then
		self:LaneClear()
	end
	unit = GetCurrentTarget()
	if BarrelCount > 0 then
	self:AddingBarrel()
	elseif BarrelCount <= 0 then
	self:RemoveBarrel() 
	end
	if MenuG.m.m.AQ:Value() then
		self:AuotQ()
	end
	if MenuG.m.m.AR:Value() then
		self:AutoRKs()
	end
	if MenuG.m.m.ARR:Value() then
		self:AutoRR()
	end
end

function Gangplank:Combo()
IOW.forceTarget = nil
local Ori = ClosestBarrel(GetOrigin(myHero))
for _,Killablebarrel in pairs(Killablebarrels2) do 
	if MenuG.c.h.QB:Value() and Ori ~= nil and CanUseSpell(myHero, _Q) == READY and GetDistance(GetOrigin(unit), GetOrigin(Killablebarrel)) <=380 and BarrelCount >= MenuG.c.h.BarrelLinkM:Value() then
		CastTargetSpell(Ori, _Q)
		elseif Ori and GetDistance(GetOrigin(myHero), GetOrigin(Ori)) <=GetRange(myHero) and GetDistance(GetOrigin(unit), GetOrigin(Ori)) <=400 then
			IOW.forceTarget = Ori 
	end
	if MenuG.c.h.E:Value() and CanUseSpell(myHero, _E) == READY and ValidTarget(unit, 1000) then
		PredPos = GetCircularAOEPrediction(unit, BarrelPred, GetOrigin(Ori))
		CastSkillShot(_E, PredPos)
		elseif CanUseSpell(myHero, _E) ~= READY and ValidTarget(unit, 650) and BarrelCount <=0 then
			CastTargetSpell(unit, _Q)
		end
	end
end

function Gangplank:AutoRKs()
for i,enemy in pairs(GetEnemyHeroes()) do
	local z = (GetCastLevel(myHero, _Q)*240)+(GetBonusAP(myHero)*1.20)+(GetBaseDamage(myHero))
	local Dmg = myHero:CalcDamage(enemy, z)
	if CanUseSpell(myHero, _R) == READY and ValidTarget(enemy, 100000) and Dmg > enemy.health then
		CastSkillShot(_R, GetOrigin(enemy))
	end
end
end

function Gangplank:AutoRR()
for i,enemy in pairs(GetEnemyHeroes()) do
	if CanUseSpell(myHero, _R) == READY and ValidTarget(enemy, 100000) then
end
end
end

function Gangplank:LastHit()
	for _,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == MINION_ENEMY then
			local MHP = minion.health
			local z = (GetCastLevel(myHero, _Q)*25)+(GetBonusDmg(myHero)*.9)+(GetBaseDamage(myHero))
			local Dmg = myHero:CalcDamage(minion, z)
			if CanUseSpell(myHero, _Q) == READY and ValidTarget(minion, 625) and MHP <= Dmg then
				CastTargetSpell(minion, _Q)
			end
		end
	end
end
 
function Gangplank:LaneClear()
for _,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == MINION_ENEMY then
			local MHP = minion.health
			local z = (GetCastLevel(myHero, _Q)*25)+(GetBonusDmg(myHero)*.9)+(GetBaseDamage(myHero))
			local Dmg = myHero:CalcDamage(minion, z)
			local Ori = ClosestBarrel(GetOrigin(myHero))
			if CanUseSpell(myHero, _Q) == READY and ValidTarget(minion, 625) and MHP <= Dmg and BarrelCount <= 0 and MenuG.f.l.Q:Value() then
				CastTargetSpell(minion, _Q)
				elseif BarrelCount >= 1 and CanUseSpell(myHero, _Q) == READY and GetDistance(GetOrigin(minion), GetOrigin(Killablebarrel)) <=380 and GetDistance(GetOrigin(myHero), GetOrigin(Ori)) >=GetRange(myHero) and BarrelCount >= MenuG.f.l.BarrelLinkM:Value() then 
					CastTargetSpell(Ori, _Q)
					elseif BarrelCount >= 1 and CanUseSpell(myHero, _Q) == READY and GetDistance(GetOrigin(minion), GetOrigin(Killablebarrel)) <=380 and GetDistance(GetOrigin(myHero), GetOrigin(Ori)) <=GetRange(myHero) and BarrelCount >= MenuG.f.l.BarrelLinkM:Value() then 
						IOW.forceTarget = Ori
					else
						IOW.forceTarget = nil
			end
			if CanUseSpell(myHero, _E) == READY and ValidTarget(minion, 650) and MenuG.f.l.E:Value() then
				CastSkillShot(_E, GetOrigin(minion))
			end
		end
	end
end

function Gangplank:AuotQ()
for _,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == MINION_ENEMY then
			local MHP = minion.health
			local z = (GetCastLevel(myHero, _Q)*25)+(GetBonusDmg(myHero)*.9)+(GetBaseDamage(myHero))
			local Dmg = myHero:CalcDamage(minion, z)
			if CanUseSpell(myHero, _Q) == READY and ValidTarget(minion, 625) and MHP <= Dmg then
				CastTargetSpell(minion, _Q)
			end
		end
	end
end

function Gangplank:CreateObj(Object) 
	if GetObjectBaseName(Object) == "Barrel" then
		BarrelCount = BarrelCount + 1
		table.insert(Killablebarrels, Object)
	end
end

function Gangplank:AddingBarrel()
	for i, Killablebarrel in pairs(Killablebarrels) do
		if GetPercentHP(Killablebarrel) <= 34 then
			table.insert(Killablebarrels2, Killablebarrel)
		end
	end
end

function Gangplank:RemoveBarrel()
for i, Killablebarrel in pairs(Killablebarrels2) do
			Killablebarrels2[i] = nil
	end
end

function Gangplank:DeleteObj(Object)
	if GetObjectBaseName(Object) == "Gangplank_Base_E_AoE_Green.troy" then 
		BarrelCount = BarrelCount - 1
		table.remove(Killablebarrels, 1)
		self:RemoveBarrel()
	end
end

function ClosestBarrel(pos) -- Inspired all credits and shiz. Main reason is travel speed to closest barrel so we shoot that.
  local bArrel = nil
  for _,v in pairs(Killablebarrels2) do 
    if not bArrel and v then bArrel = v end
    if bArrel and v and GetDistanceSqr(GetOrigin(bArrel),pos) > GetDistanceSqr(GetOrigin(v),pos) then
      bArrel = v
    end
  end
  return bArrel
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
