
if GetObjectName(GetMyHero()) ~= "Elise" then return end

require('Inspired')
require("IPrediction")

class "Elise"
function Elise:__init()
	Elise = MenuConfig("Elise", "Elise")
      Elise:Menu("c", "Combo")
      	Elise.c:Boolean("HQ", "Use Human Q", true)
      	Elise.c:Boolean("HW", "Use Human W", true)
      	Elise.c:Boolean("HE", "Use Human E", true)
      	Elise.c:Boolean("SQ", "Use Spider Q", true)
      	Elise.c:Boolean("SW", "Use Spider W", true)
      	Elise.c:Boolean("SE", "Use Spider E", false)
      	Elise.c:Boolean("R", "Use R", true)
      	Elise.c:Slider("Range", "Min range E", 425,1, 750, 1)
      Elise:Menu("h", "Harass")
      	Elise.h:Boolean("HQ", "Use Human Q", true)
      	Elise.h:Boolean("HW", "Use Human W", true)
      	Elise.h:Slider("Mana", "Min Mana %", 30, 1, 100, 1)
      Elise:Menu("j", "JungleClear")
      	Elise.j:Boolean("HQ", "Use Human Q", true)
      	Elise.j:Boolean("HW", "Use Human W", true)
      	Elise.j:Boolean("SQ", "Use Spider Q", true)
      	Elise.j:Boolean("SW", "Use Spider W", true)
      	Elise.j:Boolean("R", "R", true)
      	Elise.j:Slider("Mana", "Min Mana %", 30, 1, 100, 1)
      Elise:Menu("l", "LaneClear")
      	Elise.l:Boolean("HQ", "Use Human Q", true)
      	Elise.l:Boolean("HW", "Use Human W", true)
      	Elise.l:Boolean("SQ", "Use Spider Q", true)
      	Elise.l:Boolean("SW", "Use Spider W", true)
      	Elise.l:Boolean("R", "R", true)
      	Elise.l:Slider("Mana", "Min Mana %", 30, 1, 100, 1)
      Elise:Menu("k", "KillSteal")
      	Elise.k:Boolean("HQ", "Use Human Q", true)
      	Elise.k:Boolean("HW", "Use Human W", true)
      	Elise.k:Boolean("SQ", "Use Spider Q", true)
      Elise:Menu("m", "Misc")
      	Elise.m:Boolean("Q", "Draw Q", true)
      	Elise.m:Boolean("E", "Draw E", true)
      	Elise.m:Boolean("W", "Draw W", true)
      	--Elise.m:KeyBinding("ma", "Flee E", 90) I have to make better flee logic so for now i wont add it.
   	OnTick(function(myHero) self:Loop(myHero) end)
   	EP = { name = "EliseHumanE", speed = 1450, delay = 0.250, range = 1075, width = 55, collision = true, aoe = false, type = "linear"}
   	W = { name = "EliseHumanW", speed = 5000, delay = 0.250, range = 975, width = 235, collision = false, aoe = false, type = "linear"}
    EP.pred = IPrediction.Prediction(EP)
    W.pred = IPrediction.Prediction(W)
    --OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
    OnDraw(function(myHero) self:Draw(myHero) end)
    AutoUpdate("/Cloudhax23/GoS/blob/master/Common/Elise.lua","/Cloudhax23/GoS/blob/master/Common/Elise.version","Elise.lua",2)
end

--{
CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["Drain"]                       = {Name = "FiddleSticks", Spellslot = _W},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["ReapTheWhirlwind"]            = {Name = "Janna",        Spellslot = _R},
    ["KarthusFallenOne"]            = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R},                        
    ["PantheonRJump"]               = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["Destiny"]                     = {Name = "TwistedFate",  Spellslot = _R},
    ["UrgotSwap2"]                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                      = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R},
    ["XerathLocusOfPower2"]         = {Name = "Xerath",       Spellslot = _R}
    
}

 
function Elise:ProcessSpell(unit, spell)
      if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero, _E) == READY then
        if CHANELLING_SPELLS[spell.name] and Elise.InterruptMenu.I.IU:Value() then
          if IsInDistance(unit, 975) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and Elise.InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
          	local hitchance, pos = EP.pred:Predict(unit)
			 if hitchance > 2 then 
				CastSkillShot(_E, pos) 
			 end
          end
       end
    end
end --} Heres that interrupter taken from Deftsu

function Elise:Draw(myHero) -- Deftsu, you might claim this but it is fairly common sense to do drawings this way <_<
local pos = GetOrigin(myHero)
if Elise.m.Q:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(pos,GetCastRange(myHero, _Q),1,25, 0xffff00ff) end
if Elise.m.E:Value() and CanUseSpell(myHero, _E) == READY then DrawCircle(pos,GetCastRange(myHero, _E),1,25, 0xffff00ff) end
if Elise.m.W:Value() and CanUseSpell(myHero, _W) == READY then DrawCircle(pos,GetCastRange(myHero, _W),1,25, 0xffff00ff) end
end

function Elise:Loop()
	self:Checks()
	self:SpellManager()
	self:KillSteal()
	--self:Flee()
	if IOW:Mode() == "Combo" then
		self:NormalCombo()
	end
	if IOW:Mode() == "Harass" then
		self:Harass()
	end
	if IOW:Mode() == "LaneClear" then
		self:LaneClear()
		self:JungleClear()
	end
end

function Elise:SpellManager()
	local now = 0
	if QSpider == false and GetTickCount() >= now + 6000 then
		QSpider = true 
	end
	if WSpider == false and GetTickCount() >= now + 12000 then
		WSpider = true 
	end
	if ESpider == false and GetTickCount() >= now + GetCastCooldown(myHero, _E, GetCastLevel(myHero, _E)) then
		ESpider = true 
	end
end

function Elise:Checks()
	unit = GetCurrentTarget()
	Human = true
	QSpider = true
	ESpider = true
	WSpider = true
	EnemyPos = GetOrigin(unit)
end

function Elise:NormalCombo()
if ValidTarget(unit, 1200) then
	if IsSpider() then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(unit, 475) and Elise.c.SQ:Value() then 
			CastTargetSpell(unit, _Q)
			QSpider = false
		elseif CanUseSpell(myHero, _E) == READY and Elise.c.SE:Value() and GetCastName(myHero, _E) == "EliseSpiderEInitial" and GetDistance(myHero, unit)>Elise.c.Range:Value() then
			CastSpell(_E)
			MoveToXYZ(GetOrigin(unit).x,GetOrigin(unit).y,GetOrigin(unit).z)
			ESpider = false	
		elseif CanUseSpell(myHero, _W) == READY and ValidTarget(unit, 475) and Elise.c.SW:Value() then
		CastSpell(_W)
		WSpider = false
		elseif CanUseSpell(myHero, _R) == READY and Elise.c.R:Value() and GotBuff(unit, "EliseSpiderW") == 0  and ValidTarget(unit, 625) or ValidTarget(unit, 950) or ValidTarget(unit, 1075) and not ValidTarget(unit, 125) then
			CastSpell(_R)
			Human = true
		end
	end
	if Human == true then
		if CanUseSpell(myHero, _E) == READY and ValidTarget(unit, 1075) and Elise.c.HE:Value() and GetCastName(myHero, _E) == "EliseHumanE" then
			local hitchance, pos = EP.pred:Predict(unit)
			 if hitchance > 2 then 
				CastSkillShot(_E, pos)
			 end
		elseif CanUseSpell(myHero, _W) == READY and Elise.c.HW:Value() and ValidTarget(unit, 600) then
			local hitchance2, pos2 = W.pred:Predict(unit)
			 if hitchance2 > 2 then 
			 	CastSkillShot(_W, pos2) 
			 end 
		elseif CanUseSpell(myHero, _Q) == READY and Elise.c.HQ:Value() and ValidTarget(unit, 675) then -- Hehe HQ
			CastTargetSpell(unit, _Q)
		elseif CanUseSpell(myHero, _R) == READY and Elise.c.R:Value() and ESpider == true and ValidTarget(unit, 475) or GotBuff(unit, "stun") >= 1 then
			CastSpell(_R)
			Human = false
		end
	end
end
end

function Elise:KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
local HQ = (GetCastLevel(myHero,_E)*35)+((GetBonusAP(myHero)/100)*.3)+(GetBaseDamage(myHero))+(GetMaxHP(enemy)-GetCurrentHP(enemy))*.4
local hp = GetCurrentHP(enemy)
local Dmg = CalcDamage(myHero, enemy, HQ)
local HW = (GetCastLevel(myHero,_W)*50)+(GetBonusAP(myHero)*.8)
local Dmg2 = CalcDamage(myHero, enemy, HW)
local SQ = (GetCastLevel(myHero,_E)*40)+((GetBonusAP(myHero)/100)*.3)+(GetBaseDamage(myHero))+(GetMaxHP(enemy)-GetCurrentHP(enemy))*.8
local Dmg3 = CalcDamage(myHero, enemy, SQ)
if ValidTarget(enemy, 1200) then
	if Human == true then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,675) and Elise.k.HQ:Value() and Dmg >= hp then
		CastTargetSpell(enemy, _Q)
				end
		if CanUseSpell(myHero, _W) == READY and ValidTarget(enemy,975) and Elise.k.HW:Value() and Dmg2 >= hp then
			local hitchance, pos = W.pred:Predict(enemy)
			 if hitchance > 2 then 
			 	CastSkillShot(_W, pos) 
			end
		end
	if IsSpider() then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,675) and Elise.k.SQ:Value() and Dmg3 >= hp then
		CastTargetSpell(enemy, _Q)
					end
				end 	
			end
		end
	end
end

function Elise:Harass()
if ValidTarget(unit, 1200) then
	if Human == true then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(unit,675) and GetPercentMP(myHero) >= Elise.h.Mana:Value() and Elise.h.HQ:Value() then
			CastTargetSpell(unit, _Q)
			elseif CanUseSpell(myHero, _W) == READY and ValidTarget(unit,975) and GetPercentMP(myHero) >= Elise.h.Mana:Value() and Elise.h.HW:Value() then
			local hitchance, pos = W.pred:Predict(unit)
			 if hitchance > 2 then 
			 	CastSkillShot(_W, pos) 
			 	end
			 end 
		end
	end
end

function Elise:JungleClear()
for _,Q in pairs(minionManager.objects) do
 if MINION_JUNGLE == GetTeam(Q) then
	if Human == true then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(Q,1075) and GetPercentMP(myHero) >= Elise.j.Mana:Value() and Elise.j.HQ:Value() then
			CastTargetSpell(Q, _Q)
			elseif CanUseSpell(myHero, _W) == READY and ValidTarget(Q,975) and GetPercentMP(myHero) >= Elise.j.Mana:Value() and Elise.j.HW:Value() then
				local pos = GetOrigin(Q)
				CastSkillShot(_W, pos)
			elseif CanUseSpell(myHero, _R) == READY and Elise.j.R:Value() and ESpider == true and GotBuff(Q, "EliseSpiderW") == 0  and ValidTarget(Q, 475) or GotBuff(Q, "stun") >= 1 then
				CastSpell(_R)
				Human = false
			end
		end 
	if IsSpider() then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(Q,475) and GetPercentMP(myHero) >= Elise.j.Mana:Value() and Elise.j.SQ:Value() then
			CastTargetSpell(Q, _Q)
			elseif CanUseSpell(myHero, _W) == READY and ValidTarget(Q,475) and GetPercentMP(myHero) >= Elise.j.Mana:Value() and Elise.j.SW:Value() then
				CastSpell(_W)
			elseif CanUseSpell(myHero, _R) == READY and Elise.j.R:Value() and ValidTarget(Q, 625) or ValidTarget(Q, 950) or ValidTarget(Q, 1075) and not ValidTarget(Q, 125) then
				CastSpell(_R)
				Human = true
				end
			end
		end
	end
end

function Elise:LaneClear()
for _,Q in pairs(minionManager.objects) do
 if MINION_ENEMY == GetTeam(Q) then
	if Human == true then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(Q,1075) and GetPercentMP(myHero) >= Elise.l.Mana:Value() and Elise.l.HQ:Value() then
			CastTargetSpell(Q, _Q)
			elseif CanUseSpell(myHero, _W) == READY and ValidTarget(Q,975) and GetPercentMP(myHero) >= Elise.l.Mana:Value() and Elise.l.HW:Value() then
				local pos = GetOrigin(Q)
				CastSkillShot(_W, pos)
			elseif CanUseSpell(myHero, _R) == READY and Elise.l.R:Value() and ESpider == true and GotBuff(Q, "EliseSpiderW") == 0  and ValidTarget(Q, 475) or GotBuff(Q, "stun") >= 1 then
				CastSpell(_R)
				Human = false
			end
		end 
	if IsSpider() then
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(Q,475) and GetPercentMP(myHero) >= Elise.l.Mana:Value() and Elise.l.SQ:Value() then
			CastTargetSpell(Q, _Q)
			elseif CanUseSpell(myHero, _W) == READY and ValidTarget(Q,475) and GetPercentMP(myHero) >= Elise.l.Mana:Value() and Elise.l.SW:Value() then
				CastSpell(_W)
			elseif CanUseSpell(myHero, _R) == READY and Elise.l.R:Value() and ValidTarget(Q, 625) or ValidTarget(Q, 950) or ValidTarget(Q, 1075) and not ValidTarget(Q, 125) then
				CastSpell(_R)
				Human = true
				end
			end
		end
	end
end

function Elise:Flee()
if Elise.m.ma:Value() then
 local MinionJumper = ClosestMinion(GetMousePos(), MINION_JUNGLE)
 local MinionJumper2 = ClosestMinion(GetMousePos(), MINION_ENEMY)
if Human == true then
	CastSpell(_R)
	Human = false
	elseif Human == false then
		CastSpell(_E)
		MoveToXYZ(MinionJumper)
		MoveToXYZ(MinionJumper2)
		end
	end
end

function IsSpider()
if GetCastName(myHero, _Q) == "EliseSpiderQCast" then return true
	end
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
