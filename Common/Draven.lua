require("OpenPredict")

local QM, WM, EM, RM = 0,0,0,0
local AxeCatchRange = 0
local tickIndex = 0
local buffcount = 0
local buffslow = 0
local ret = {}
Callback.Add("Load", function() Draven_Load() end)
function Draven_Load()
	Q = { delay = 0.25, speed = math.huge, width = 0, range = GetRange(myHero)}
	W = { delay = 0.25, speed = math.huge, width = 0, range = 0}
	E = { delay = 0.25, speed = 1400, width = 100, range = 950}
	R = { delay = 0.40, speed = 2000, width = 160, range = 3000}	
	M = MenuConfig("Draven", "Draven")
		M:Menu("a", "Axe Settings")
			M.a:Slider("acr", "Axe Catch Range?", 500, 200, 2000, 1)
			M.a:Boolean("at", "Dont Catch Axe Under Enemy Tower", true)
			M.a:Boolean("ae", "Don't catch axe in enemy group", true)
			M.a:Boolean("ak", "Don't catch axe if can kill 2 AA", true)
		M:Menu("Q", "Q Settings")
			M.Q:Boolean("aq", "Use Q", true)
			M.Q:Boolean("fq", "Farm Q", true)
		M:Menu("W", "W Settings")
			M.W:Boolean("aw", "Use W", true)
			M.W:Boolean("as", "Auto W Slow", true) 
		M:Menu("E", "E Settings")
			M.E:Boolean("ae", "Use E", true)
			M.E:Boolean("ae2", "Harras E if can hit 2 targets", true)
		M:Menu("R", "R Settings")
			M.R:Boolean("ar", "Auto R", true)
			M.R:DropDown("Rdmg", "KS damage calculation", 2, {"X1", "X2"})
			M.R:Boolean("comboR", "Auto R in combo", true)
			M.R:Boolean("Rcc", "R cc", true)
			M.R:Boolean("Raoe", "R aoe combo", true)
			M.R:KeyBinding("useR", "Semi-manual cast R key", string.byte("T"))
		M:Menu("O", "Other Settings")
			M.O:Boolean("mana", "Disable Mana Manager", false)
	Callback.Add("UpdateBuff", function(unit, buff) Draven_UBuff(unit, buff) end)
	Callback.Add("RemoveBuff", function(unit, buff) Draven_RBuff(unit, buff) end)
	GoSWalk:RegisterBeforeAttackCallback(function() Draven_BeforeAttack() end)
	Callback.Add("CreateObj", function(Obj) Draven_CreateObj(Obj) end)
	Callback.Add("DeleteObj", function(Obj) Draven_DeleteObj(Obj) end)
	--Callback.Add("Draw", function() Draven_Draw() end)
	Callback.Add("Tick", function() tickIndex = tickIndex+1  Draven_Tick() target = GetCurrentTarget() if tickIndex > 4 then tickIndex = 0 end end)
end

function Draven_LagFree(count)
	if tickIndex == count then
		return true 
	else 
		return false 
	end
end

function Draven_UBuff(unit, buff)
	if unit and unit == myHero and buff.Name:lower():find("dravenspinningattack")  then
		buffcount = buff.Count 
		expiretime = buff.ExpireTime - GetGameTimer()
	end
	if unit and unit == myHero and buff.Name == "Slow" then
		buffslow = buff.Count 
	end
end

function Draven_RBuff(unit, buff)
	if unit and unit == myHero and buff.Name:lower():find("dravenspinningattack") then
		buffcount = buff.Count
		expiretime = 0 
	end
	if unit and unit == myHero and buff.Name == "Slow" then
		buffslow = buff.Count 
	end
end

function Draven_BeforeAttack()
	if Ready(_Q) then
		if M.Q.aq:Value() and ValidTarget(target, Q.range) then
			if buffcount + #ret == 0 then
				CastSpell(_Q)
				elseif myHero.mana > RM + QM and buffcount == 0 then
					CastSpell(_Q)
			end
		end
		if M.Q.fq:Value() and (GoSWalk.CurrentMode == 1 or GoSWalk.CurrentMode == 2) then
			if buffcount + #ret == 0 and myHero.mana > RM + EM + WM then
				CastSpell(_Q)
				elseif GetPercentMP(myHero) > 70 and buffcount == 0 then
					CastSpell(_Q)
			end
		end 
	end
end

function Draven_Tick()
	if Draven_LagFree(1) then
		AxeCatchRange = M.a.acr:Value()
		Draven_SetMana()
		Draven_AxeLogic()
	end
	if Draven_LagFree(2) and Ready(_E) and M.E.ae:Value() then
		Draven_LogicE()
	end
	if Draven_LagFree(3) and Ready(_W) then
		Draven_LogicW()
	end
	if Draven_LagFree(4) and Ready(_R) then
		Draven_LogicR()
	end
end

function Draven_LogicW()
	if M.W.aw:Value() and GoSWalk.CurrentMode == 0 and myHero.mana > RM+EM+WM+QM and EnemiesAround(myHero, 1000) > 0 and buffcount <= 1 then 
		CastSpell(_W)
		elseif M.W.as:Value() and myHero.mana > RM+EM+WM and buffslow >=1 then
			CastSpell(_W)
	end 
end

function Draven_LogicE()
	local Damage = (70+35*GetCastLevel(myHero, _E)*.5+myHero.totalDamage) 
	for i, u in pairs(GetEnemyHeroes()) do
		if myHero:CalcDamage(u, Damage) > u.health and Ready(_E) and ValidTarget(u, 950) then
			CastSkillShot(_E, u)
		end
		if ValidTarget(u, 300) and u.isMelee then
			local pred = GetPrediction(u, E)
			if pred.hitChance >= .65 then
				CastSkillShot(_E, pred.castPos)
			end
		end
	end
	if ValidTarget(target, E.range) then
		if GoSWalk.CurrentMode == 0 then
			if myHero.mana > RM + EM then
				if not ValidTarget(target, GetRange(myHero)) then
					CastSkillShot(_E, target)
				end
				if myHero.health < myHero.maxHealth *.5 then
					CastSkillShot(_E, target)
				end
			end
			if myHero.mana > RM + EM + QM then
				local pred = GetPrediction(target, E)
				if pred:hCollision(2) and pred.hitChance >= .65 and M.E.ae2:Value() then
					CastSkillShot(_E, pred.castPos)
				end
			end
		end
	end
end

function Draven_LogicR()
	if M.R.useR:Value() then
		if ValidTarget(target, R.range) then
			local pred = GetPrediction(target, R)
			if pred:hCollision(2) and pred.hitChance >= .75 then
				CastSkillShot(_R, pred.castPos)
			end
		end
	end
	if M.R.ar:Value() then
		for i,u in pairs(GetEnemyHeroes()) do 
			local Damage = (75+100*GetCastLevel(myHero, _R) + 1.1 * myHero.totalDamage)
			if ValidTarget(u, R.range) then 
				if myHero:CalcDamage(u, Damage)*2 > u.health and M.R.Rdmg:Value() == 2 then
					local pred = GetPrediction(u, R)
					if pred.hitChance >= .75 then
						CastSkillShot(_R, pred.castPos)
					end
				elseif myHero:CalcDamage(u, Damage) > u.health and M.R.Rdmg:Value() == 1 then
					local pred = GetPrediction(u, R)
					if pred.hitChance >= .75 then
						CastSkillShot(_R, pred.castPos)
					end
				end
				if GoSWalk.CurrentMode == 0 and ValidTarget(u, GetRange(myHero)) and myHero:CalcDamage(u, Damage)*2 > u.health then
					local pred = GetPrediction(u, R)
					if pred.hitChance >= .75 then
						CastSkillShot(_R, pred.castPos)
					end
				end
				if M.R.Rcc:Value() and myHero:CalcDamage(u, Damage)*2 > u.health and Draven_Motion(u) and ValidTarget(u, E.range) then
					local pred = GetPrediction(u, R)
					if pred.hitChance >= .75 then
						CastSkillShot(_R, pred.castPos)
					end
				end
				if M.R.Raoe:Value() and GoSWalk.CurrentMode == 0 then
					local pred = GetPrediction(u, R)
					if pred:hCollision(3) and pred.hitChance >= .65 then
						CastSkillShot(_R, pred.castPos)
					end
				end
			end
		end
	end
end

function Draven_Motion(target)
	if GetMoveSpeed(target) < 50 or target.isRecalling or target.isFeared or target.isCharmed or target.isTaunted then
		return true
	end
end

function Draven_AxeLogic()
	if M.a.ak:Value() and ValidTarget(target, 800) and target.distance > 400 and myHero.totalDamage*2 > target.health then 
		GoSWalk:ForceMovePoint(nil)
	end 
	if #ret == 0 then
		GoSWalk:ForceMovePoint(nil)
	end
	if #ret == 1 then
		Draven_CatchAxe(ret[1])
	end
	if #ret > 1 then
		local bestaxe = nil
		if bestaxe == nil then 
			for i, u in pairs(ret) do
				if not bestaxe and u then bestaxe = u end
				if bestaxe and u and GetDistanceSqr(GetOrigin(bestaxe),myHero) > GetDistanceSqr(GetOrigin(u),myHero) then
					bestaxe = u
				end
			end
		end
		if bestaxe ~= nil then
			Draven_CatchAxe(bestaxe)
				DrawCircle(bestaxe,100,5,25,GoS.White)
		end
	end
end

function Draven_CatchAxe(Axe)
	if M.a.at:Value() and (GoSWalk.CurrentMode == 0 or GoSWalk.CurrentMode == 1 or GoSWalk.CurrentMode == 2) and UnderTurret(Axe, true) then
		GoSWalk:ForceMovePoint(nil)
	end
	if M.a.ae:Value() and EnemiesAround(Axe, 500) > 2 then
		GoSWalk:ForceMovePoint(nil)
	end
	if GetDistanceFromMouse(Axe) < AxeCatchRange then
		 GoSWalk:ForceMovePoint(Axe)
		 DelayAction(function() table.remove(ret, 1) end, .65) -- Remove this line when delete obj is fixed!
		else
			GoSWalk:ForceMovePoint(nil)
	end 
end

function Draven_SetMana()
	if M.O.mana:Value() == true then
		QM = 0
		WM = 0
		EM = 0
		RM = 0
	end
	QM = GetCastMana(myHero, _Q, GetCastLevel(myHero, _Q))
	WM = GetCastMana(myHero, _W, GetCastLevel(myHero, _W))
	EM = GetCastMana(myHero, _E, GetCastLevel(myHero, _E))
	if not Ready(_R) then
		RM = EM - GetCastCooldown(myHero, _E, GetCastLevel(myHero, _E))
	else
		RM = GetCastMana(myHero, _R, GetCastLevel(myHero, _R))
	end
end

function Draven_CreateObj(Obj)
	if GetObjectBaseName(Obj) == "Draven_Base_Q_reticle_self.troy" then
		table.insert(ret, Obj)
	end 
end

function Draven_DeleteObj(Obj)
	if GetObjectBaseName(Obj) == "Draven_Base_Q_reticle_self.troy" then
		table.remove(ret, 1)
	end
end
