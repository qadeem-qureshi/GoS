if myHero.charName ~= "Lucian" then return end

if not FileExist(COMMON_PATH.. "Analytics.lua") then
  DownloadFileAsync("https://raw.githubusercontent.com/LoggeL/GoS/master/Analytics.lua", COMMON_PATH .. "Analytics.lua", function() end)
end
Callback.Add("Load", function() Lucian_Load() end)

require("Analytics")
require("OpenPredict")

local ver = "1.1"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        print("<font color=\"#FF1493\"><b>[Lucian OnS]:</b></font><font color=\"#FFFFFF\"> New version found!</font>")
        print("<font color=\"#FF1493\"><b>[Lucian OnS]:</b></font><font color=\"#FFFFFF\"> Downloading update, please wait...</font>")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Lucian.lua", SCRIPT_PATH .. "champ.lua", function() print("<font color=\"#FF1493\"><b>[Lucian OnS]:</b></font><font color=\"#FFFFFF\"> Update Complete, please 2x F6!</font>") return end)
    else
       print("<font color=\"#FF1493\"><b>[Lucian OnS]:</b></font><font color=\"#FFFFFF\"> No Updates Found!</font>")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Lucian.version", AutoUpdate)

function Lucian_Load()
	--Menu
	M = MenuConfig("Lucian", "Lucian")
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("QE", "Use Q Extended", true)
			M.c:Boolean("W", "Use W", true)
			M.c:Boolean("Wh", "Use pred W", false)
			M.c:Boolean("E", "Use E", true)
		M:Menu("f", "LaneClear/ JunglerClear")
			M.f:Boolean("Q", "Use LC Q", true)
			M.f:Slider("QH", "Q Minion Hits", 3, 1, 6, 1)
			M.f:Boolean("W", "Use LC W", true)
			M.f:Boolean("E", "Use LC E", true)
			M.f:Boolean("QJ", "Use JC Q", true)
			M.f:Boolean("WJ", "Use JC W", true)
			M.f:Boolean("EJ", "Use JC E", true)
		M:Menu("m", "Misc")
			M.m:KeyBinding("R", "Use R", string.byte("T"))
			M.m:Boolean("Dev", "Dev Debug (DAC:R)", false)
			M.m:Slider("D", "Ticks Delay", 30, 1, 150, 1)
			M.m:Info("Dd","The Higher = More FPS")
			M.m:Info("DdDD","Also Slower Script")
			M.m:Info("DdD","The Lower = Faster Script")
		M:Menu("d", "Drawings")
			M.d:Boolean("Q", "Q Blue", false)
			M.d:Boolean("W", "W Green", false)
			M.d:Boolean("E", "E Yellow", false)
			M.d:Boolean("R", "R White", false)
		M:Menu("p", "Skin Settings")
			M.p:Boolean("E","Enabled", true)
			M.p:DropDown("S", "Skin", 7, {"Classic", "Hired Gun", "Striker", "Chroma Pack: Yellow", "Chroma Pack: Red", "Chroma Pack: Blue", "PROJECT"}, function(kapap) Lucian_Skin() end)
	--Vars
	Q = { delay = 0.35, speed = 1400, width = 50, range = 1100}
	W = { delay = 0.25, speed = 1600, width = 70, range = 1000}
	R = { delay = 0.25, speed = 2500, width = 100, range = 3000}
	Buffs = {P=0}
	Mode = nil
	--Callbacks
	Lucian_LoadWalker()
	Callback.Add("Draw", function() Lucian_Combo() end)
	Callback.Add("DeleteObj", function(Obj) Lucian_DeleteObj(Obj) end)
	Callback.Add("SpellCast", function(cast) Lucian_Weave(cast) end)
	Callback.Add("ProcessSpellComplete", function(unit,spell) Lucian_AA(unit, spell) end)
	--Misc
	Analytics("Cloud Lucian")
	print("<font color=\"#FF1493\"><b>[Lucian OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
	if M.p.E:Value() then
		Lucian_Skin()
	end
	if M.m.Dev:Value() then
		Lucian_Dev()
	end
end

function Lucian_LoadWalker()
	if IOW_Loaded then
		Callback.Add("Tick", function() Lucian_Tick(IOW:Mode(), "Combo", "LaneClear") end)
	end
	if DAC_Loaded then
		Callback.Add("Tick", function() Lucian_Tick(DAC:Mode(), "Combo", "LaneClear") end)
	end
	if PW_Loaded then
		Callback.Add("Tick", function() Lucian_Tick(PW:Mode(), "Combo", "LaneClear") end)
	end
	if _G.GoSWalkLoaded then
		Callback.Add("Tick", function() Lucian_Tick(GoSWalk.CurrentMode, 0, 2) end)
	end
	if _G.AutoCarry_Loaded then
		Callback.Add("Tick", function() Lucian_Tick(DACR:Mode(), "Combo", "LaneClear") end)
	end
end

function Lucian_Tick(m,c,l)
	Target = GetCurrentTarget()
	if m == c then
		Mode = "Combo"
	end
	if m == l then
		Mode = "Clear"
		Lucian_Clear()
	end
	if m ~= l and m ~= c then
		Mode = nil
	end
end

function Lucian_Combo()
	if M.d.Q:Value() and Ready(_Q) then
		myHero:Draw(Q.range, GoS.Blue)
	end
	if M.d.W:Value() and Ready(_W) then
		myHero:Draw(W.range, GoS.Green)
	end
	if M.d.E:Value() and Ready(_E) then
		myHero:Draw(E.range, GoS.Yellow)
	end
	if M.d.R:Value() and Ready(_R) then
		myHero:Draw(R.range, GoS.White)
	end
	--print(Mode)
	local Enemy = GetCurrentTarget()
	if Buffs.P >= 1 then return end
	--print("kkappa")
			for i,u in pairs(minionManager.objects) do
				if u.valid and not u.dead and ValidTarget(u, 500) and ValidTarget(Enemy, 1100) and GetDistance(Enemy, myHero) > 510 then
					local p = GetPrediction(Enemy, Q)
					local v = Vector(VectorExtend(u.pos, myHero, 0))
					local v2 = Vector(VectorExtend(v, myHero.pos, -(Q.range-GetDistance(u, myHero)+10)))
					--[[local TE = u.pos + Vector(Vector(u.pos)-myHero.pos):perpendicular2():normalized()*Q.width/2 -- A
					local TE1 = u.pos + Vector(Vector(u.pos)-myHero.pos):perpendicular():normalized()*Q.width/2 -- C
					local TE2 =  TE1 + Vector(Vector(TE1)-myHero.pos):normalized()*(Q.range-GetDistance(u, myHero)) -- B
					local TE3 = TE + Vector(Vector(TE)-myHero.pos):normalized()*(Q.range-GetDistance(u, myHero)) -- D
					local poly = Polygon2(Point2(Vector(TE).x,Vector(TE).y), Point2(Vector(TE1).x,Vector(TE1).y), Point2(Vector(TE2).x,Vector(TE2).y), Point2(Vector(TE3).x,Vector(TE3).y))]]
					local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(v, v2, p.castPos)
					if Ready(_Q) and Mode == "Combo" and M.c.QE:Value() and CountObjectsOnLineSegment(myHero, v, Q.width, GetEnemyHeroes(), MINION_ENEMY) >= 0 and  CountObjectsOnLineSegment(v, v2, Q.width, GetEnemyHeroes(), MINION_ENEMY) >= 1 and isOnSegment then
						CastTargetSpell(u, _Q)
					end
				end
			end
			if ValidTarget(Enemy, 500) and Ready(_Q) and Mode == "Combo" then
				CastTargetSpell(Enemy, _Q)
			end
			if ValidTarget(Enemy, 700) and Ready(_E) and Mode == "Combo" then
				CastSkillShot(_E, GetMousePos())
			end
			if ValidTarget(Enemy, 1050) and Ready(_W) and Mode == "Combo" and M.c.Wh:Value() then
				local prediction = GetPrediction(Enemy, W); 
				if prediction.hitChance > .65 and not prediction:mCollision(1) then 
						CastSkillShot(_W, prediction.castPos) 
				end 
				elseif ValidTarget(Enemy, myHero.range+myHero.boundingRadius) and Ready(_W) and Mode == "Combo" and not M.c.Wh:Value() then
					CastSkillShot(_W, Enemy)
			end
end

function Lucian_Clear()
	for i,u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY and u.team ~= 300 then
			local p = GetPrediction(u, Q)
			if Ready(_Q) and M.f.Q:Value() and ValidTarget(u, 500) and p:mCollision(M.f.QH:Value()) and (GetPercentMP(myHero) > 65 or  p:mCollision(4)) then
				CastTargetSpell(u, _Q)
			end
			if Ready(_E) and M.f.E:Value() and ValidTarget(u, 425) and GetDistanceFromMouse(u) < 425 and GetPercentMP(myHero) > 65 then
				CastSkillShot(_E, GetMousePos())
			end
			if Ready(_W) and M.f.W:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius) and GetPercentHP(myHero) > 65 then
				CastSpell(_W)
			end
		end
		if u.team == MINION_JUNGLE and u.team ~= MINION_ENEMY then
			if Ready(_Q) and M.f.QJ:Value() and ValidTarget(u, 500) then
				CastTargetSpell(u, _Q)
			end
			if Ready(_E) and M.f.EJ:Value() and ValidTarget(u, 425) and GetDistanceFromMouse(u) < 425 then
				CastSkillShot(_E, GetMousePos())
			end
			if Ready(_W) and M.f.WJ:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius) then
				CastSpell(_W)
			end
		end
	end
end

function Lucian_Dev()
	if _G.AutoCarry_Loaded then
		OnAfterAttack(function(unit, target) if unit.isMe and target.type == myHero.type then print(DACR.LastAttackTime) end end)
	end
end

function Lucian_AA(unit, spell)
	if unit.isMe and spell.name:lower():find("lucianpassiveattack") then
		Buffs.P = 0
	end
end

function Lucian_DeleteObj(Obj)
	if Obj.name == "Lucian_Base_P_buf.troy" then
		Buffs.P = 0
	end
end

function Lucian_Weave(cast)
	if (cast.spellID == 2 or cast.spellID == 0 or cast.spellID == 1) then
		Buffs.P = Buffs.P + 1
	end
end

function Lucian_Skin()
	if M.p.E:Value() then
		myHero:Skin(M.p.S:Value()-1)
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
	if time > Tick + 0 and not one then
		Tick = time 
		thing()
	end
	if one and time > Tick2 + one then
		Tick2 = time 
		thing()
	end
end
