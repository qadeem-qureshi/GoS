require("OpenPredict")
Callback.Add("Load", function() if myHero.charName == "Gangplank" then GP_Load() end end)

function GP_Load()
	-- Prediction
	BarrelPred = { delay = 0.25, speed = math.huge, width = 390, range = 650 }
	GPR = { delay = 0.25, speed = math.huge, width = 575, range = math.huge }
	-- Variables
	Barrels = {}	
		-- Callbacks + Orbwalker
	GP_LoadWalker()
	Callback.Add("Draw", function() GP_Draw() end)
	Callback.Add("CreateObj", function(Obj) GP_CreateObj(Obj) end)
	Callback.Add("DeleteObj", function(Obj) GP_DeleteObj(Obj) end)
	-- Loaded Message
	print("<font color=\"#E56717\"><b>[Gangbang OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
	-- Menu
	M = MenuConfig("Gangplank", "Gangplank")

		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("E", "Use E", true)
			M.c:Slider("Ep", "Where to Place 1st Barrel?", 200, -500, 500, 1)
		
		M:Menu("f", "Farm")
			M.f:Menu("lh", "LastHit")
			M.f.lh:Boolean("Q", "Use Q Lashit", true)
			M.f:Menu("l", "LaneClear")
			M.f.l:Boolean("Q", "Use Q LaneClear", true)
			M.f.l:Boolean("E", "Use E LaneClear", true)

		M:Menu("d", "Draw")
			M.d:Boolean("EE", "Draw Barrel", true)
			M.d:Boolean("Q", "Draw Q", true)
			M.d:Boolean("E", "Draw E", true)

		M:Menu("m", "Misc")
			M.m:Boolean("AQ", "Use Q Farm Auto", false)
			M.m:Boolean("AE", "Auto Barrel Explode", false)
			M.m:Boolean("W", "Auto W", true)
			M.m:Slider("AW", "W HP", 25, 1, 100, 1)
			M.m:Boolean("AQKS", "Use Q KS Auto", true)
			M.m:Boolean("AR", "Auto KS ult", false)
			M.m:Boolean("ARR", "Auto R if Enemies >= x", false)
			M.m:Slider("ARRS", "Auto R Minimum Enemies", 3, 1, 5, 1)
			M.m:Slider("D", "Ticks Delay", 30, 1, 150, 1)
			M.m:Info("Dd","The Higher = More FPS")
			M.m:Info("DdDD","Also Slower Script")
			M.m:Info("DdD","The Lower = Faster Script")
end

function GP_LoadWalker()
	if IOW_Loaded then
		OneTick(function() GP_Tick(IOW:Mode(), "Combo", "LaneClear", "LastHit") end)
	end
	if DAC_Loaded then
		OneTick(function() GP_Tick(DAC:Mode(), "Combo", "LaneClear", "LastHit") end)
	end
	if PW_Loaded then
		OneTick(function() GP_Tick(PW:Mode(), "Combo", "LaneClear", "LastHit") end)
	end
	if GosWalk_Loaded then
		OneTick(function() GP_Tick(GosWalk.CurrentMode, 0, 3) end)
	end
end

function GP_Draw()
curTime = GetTickCount()
end

function GP_Tick(m,c,l,l1)
	Enemy = GetCurrentTarget()
	if m == c then
		GP_Combo()
	end
	--[[if KeyIsDown(string.byte("T")) then
		CastSkillShot(_E, GetMousePos())
		DelayAction(function() CastTargetSpell(Barrels[1]["obj"], _Q) end, BarrelPred.delay+.17)
	end]]
end   

function GP_Combo()
	local estack = myHero:GetSpellData(_E).ammo
	for i=1, #Barrels+1 do
		if  M.c.E:Value() then
			if #Barrels == 0 and estack >= 1 and M.c.E:Value() then 
				local e1 = Vector(VectorExtend(myHero.pos,Enemy,M.c.Ep:Value()))
				if ValidTarget(Enemy, 1000) and Ready(_E) then
					CastSkillShot(_E, e1)
				end
			end
			if #Barrels >= 1 and M.c.E:Value() then
				local CB = GP_CanQBarrel(i)
				if CB then
					local Vec = Vector(VectorExtend(CB,Enemy.pos,650)) 
					if ValidTarget(Enemy, 1000) and (GetDistance(myHero, CB) < 700 and Ready(_Q) or GetDistance(myHero, CB)< 125+myHero.boundingRadius) and GetDistance(Enemy.pos, CB.pos) < 370 then
						if Ready(_Q) then
						 	CastTargetSpell(CB, _Q) 
						 	elseif GetDistance(myHero, CB) < 125+myHero.boundingRadius then 
						 		AttackUnit(CB) 
						 end
						elseif ValidTarget(Enemy, 1000) and (GetDistance(myHero, CB) < 700 and Ready(_Q) or GetDistance(myHero, CB)< 125+myHero.boundingRadius) and GetDistance(Enemy.pos, CB.pos) > 370 and GetDistance(Enemy, Vec) < 370 then
							CastSkillShot(_E, Vec)
							DelayAction(function() if Ready(_Q) then CastTargetSpell(CB, _Q) elseif GetDistance(myHero, CB) < 125+myHero.boundingRadius then AttackUnit(CB) end end, BarrelPred.delay)
					end
				end
			end
		end
	end
end

function GP_CanQBarrel(index)
	local delay = function() if myHero.level >= 13 then return .5 elseif myHero.level >= 7 and myHero.level < 13 then return 1 elseif myHero.level < 7 then return 2 end end
	local time = function(target) return GetDistance(myHero, target)/1700+ .25 end
	local mod = function(target) return GetCurrentHP(target) * delay() * 1000 end
	if Barrels[index] ~= nil and (curTime - Barrels[index]["time"] + time(Barrels[index]["obj"]) * 1000 > mod(Barrels[index]["obj"]) or Barrels[index]["obj"].hp == 1) then
		return Barrels[index]["obj"]
	end
end

function GP_CreateObj(Obj)
	if Obj.name == "Barrel" then
		table.insert(Barrels, {obj = Obj, time = curTime, netid = Obj.networkID})
	end
end

function GP_DeleteObj(Obj)
	if Obj.name == "Gangplank_Base_E_AoE_Green.troy" and #Barrels >= 1  then 
		table.remove(Barrels, 1)
	end
	if Obj.name == "Barrel" and #Barrels >= 1 then
		table.remove(Barrels, 1)
	end
end

function VectorExtend(v,t,d)
	return v + d * (t-v):normalized() 
end

local Tick, Tick2 = 0, 0
function OneTick(name, custom)
	Callback.Add("Tick", function() ZeTick(name, custom) end)	
end

function ZeTick(thing, one)
	local time = GetTickCount()
	if time > Tick + M.m.D:Value() and not one then
		Tick = time 
		thing()
	end
	if one and time > Tick2 + one then
		Tick2 = time 
		thing()
	end
end
