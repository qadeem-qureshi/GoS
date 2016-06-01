if myHero.charName ~= "Velkoz" then return end

if not FileExist(COMMON_PATH.. "Analytics.lua") then
  DownloadFileAsync("https://raw.githubusercontent.com/LoggeL/GoS/master/Analytics.lua", COMMON_PATH .. "Analytics.lua", function() end)
end

require("Analytics")
require("OpenPredict")
local ver = "1.5"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        print("<font color=\"#FF1493\"><b>[Velkoz OnS]:</b></font><font color=\"#FFFFFF\"> New version found!</font>")
        print("<font color=\"#FF1493\"><b>[Velkoz OnS]:</b></font><font color=\"#FFFFFF\"> Downloading update, please wait...</font>")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Velkoz.lua", SCRIPT_PATH .. "Velkoz.lua", function() print("<font color=\"#FF1493\"><b>[Velkoz OnS]:</b></font><font color=\"#FFFFFF\"> Update Complete, please 2x F6!</font>") return end)
    else
       print("<font color=\"#FF1493\"><b>[Velkoz OnS]:</b></font><font color=\"#FFFFFF\"> No Updates Found!</font>")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Velkoz.version", AutoUpdate)

Callback.Add("Load", function() if myHero.charName == "Velkoz" then Vel_Load() end end)

function Vel_Load()
	--Menu
	M = MenuConfig("Velkoz", "Velkoz")
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("Qs", "Use Q Split", true)
			M.c:Boolean("W", "Use W", true)
			M.c:Boolean("E", "Use E", true)
		M:Menu("f", "LaneClear/ JunglerClear")
			M.f:Boolean("W", "Use LC W", true)
			M.f:Boolean("E", "Use LC E", true)
			M.f:Boolean("WJ", "Use JC W", true)
			M.f:Boolean("EJ", "Use JC E", true)
		M:Menu("m", "Misc")
			M.m:Slider("E", "Extra Q Buffer", 15, 1, 35, 1)
			M.m:Info("Ee","Adds Range to QBall")
			M.m:Info("EeE","The Higher = Faster Detonate lower Accuracy")
			M.m:Info("EeEe","The Lower = Slower Detonate Higher Accuracy")
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
			M.p:DropDown("S", "Skin", 3, {"Classic", "Battlecast", "Arclight", "Definitely Not"}, function(kapap) Vel_Skin() end)
	--Vars
	Q = {range= 1050, delay =.5, width=50, speed= 1300}
	QSplit = {range = 1150, width = 55, speed = 2100, delay=.25}
	W = {range = 1050, width = 80, speed = 1700, delay=0.064}
	E = {range = 850, width = 225, speed = math.huge, delay=0.333}
	Mode = nil
	-- Callbacks
	Vel_LoadWalker()
	Callback.Add("CreateObj", function(Obj) Vel_CreateObj(Obj) end)
	Callback.Add("DeleteObj", function(Obj) Vel_DeleteObj(Obj) end)
	Callback.Add("Draw", function(myHero) Vel_Draw(myHero) end)
	Callback.Add("UnLoad",function() myHero:Skin(0) end)
	--Misc
	Analytics("Cloud VelKoz")
	print("<font color=\"#FF1493\"><b>[Velkoz OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
	if M.p.E:Value() then
		Vel_Skin()
	end
end

function Vel_LoadWalker()
	if IOW_Loaded then
		OneTick(function() Vel_Tick(IOW:Mode(), "Combo", "LaneClear") end)
	end
	if DAC_Loaded then
		OneTick(function() Vel_Tick(DAC:Mode(), "Combo", "LaneClear") end)
	end
	if PW_Loaded then
		OneTick(function() Vel_Tick(PW:Mode(), "Combo", "LaneClear") end)
	end
	if GoSWalk_Loaded then
		OneTick(function() Vel_Tick(GoSWalk.CurrentMode, 0, 2) end)
	end
	if _G.AutoCarry_Loaded then
		OneTick(function() Vel_Tick(DACR:Mode(), "Combo", "LaneClear") end)
	end
end

function Vel_Tick(m,c,l)
	if m == c then
		Vel_Combo()
		Mode = "Combo"
	end
	if m == l then
		Vel_Clear()
		Mode = "LaneClear"
	end
	if m ~= c and m ~= l then
		Mode = nil
	end
end

function Vel_CreateObj(Obj)
	if Obj.name == "missile" and GetObjectSpellOwner(Obj) == myHero and GetObjectSpellName(Obj) == "VelkozQMissile" then
		QObj = Obj
	end
end

function Vel_DeleteObj(Obj)
    if Obj.name == "missile" and GetObjectSpellOwner(Obj) == myHero and GetObjectSpellName(Obj) == "VelkozQMissileSplit"  then
        QObj = nil
    end
end
lastQtick = 0

function Vel_Draw(myHero)
	Ticker = GetTickCount()
	Enemy = GetCurrentTarget()
	if QObj ~= nil and M.c.Qs:Value() then
		local Endpos = GetObjectSpellEndPos(QObj)
		local Stapos = GetObjectSpellStartPos(QObj)
		local Qpos = VectorExtend(QObj, myHero.pos, -M.m.E:Value())
		local TE = Qpos + Vector(Vector(Qpos)-Stapos):perpendicular2():normalized()*1300
		local TE2 = Qpos + Vector(Vector(Qpos)-Stapos):perpendicular():normalized()*1300
		local pred = GetPrediction(Enemy, Q, Qpos)
		--[[DrawCircle(Vector(TE),50,1,1,GoS.White)
		DrawCircle(Vector(Qpos),50,1,1,GoS.White)]]
		local predpos = GetPrediction(Enemy, QSplit, Qpos)
		for i, u in pairs(GetEnemyHeroes()) do
			if ValidTarget(u, QSplit.range+1000) and (CountObjectsOnLineSegment(Qpos, TE, QSplit.width+u.boundingRadius-12, GetEnemyHeroes(), MINION_ENEMY) >= 1 or CountObjectsOnLineSegment(Qpos, TE2, QSplit.width+u.boundingRadius-12, GetEnemyHeroes(), MINION_ENEMY)>=1) then
				CastSpell(_Q)
			end
		end
	end
	if QObj == nil and Mode == "Combo" and Ready(_Q) and ValidTarget(Enemy, Q.range) and Ready(_Q) and GetCastName(myHero, _Q) == "VelkozQ" and M.c.Q:Value() then
		local pred = GetPrediction(Enemy, Q) 
		for i= -math.pi*.5 ,math.pi*.5 ,math.pi*.05 do
			if pred.hitChance >= .65 and pred:mCollision(1) then
				local one = 25.79618 * math.pi/180
				local an = myHero.pos + Vector(Vector(pred.castPos)-myHero.pos):rotated(0, i*one, 0)
				local pred1 = GetPrediction(Vector(an), Q)
				local pred2 = GetPrediction(Enemy, QSplit, Vector(an))
				if pred2.hitChance >= .65 and CountObjectsOnLineSegment(myHero, Vector(an), QSplit.width, minionManager.objects, MINION_ENEMY) == 0 and CountObjectsOnLineSegment(an, pred2.castPos, QSplit.width, minionManager.objects, MINION_ENEMY) == 0  and not pred1:mCollision(1) and not pred2:mCollision(1) then
					--[[an1 = WorldToScreen(0, an)
					my = WorldToScreen(0, myHero)
					my1 = WorldToScreen(0,Enemy)
					DrawCircle(Vector(an),50,1,1,GoS.White)
					DrawLine(my.x, my.y, an1.x, an1.y,1,GoS.White)
					DrawLine(my1.x, my1.y, an1.x, an1.y,1,GoS.White)]]
					if lastQtick + 1000 < Ticker and GetCastName(myHero, _Q) == "VelkozQ" then 
						CastSkillShot(_Q,Vector(an))
					end
					lastQtick = Ticker 
				end
			end
		end
	end
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
		myHero:Draw(1550, GoS.White)
	end
end

function Vel_Combo()
	local Epred = GetCircularAOEPrediction(Enemy, E)
	local Wpred = GetPrediction(Enemy, W)
	local Qpred = GetPrediction(Enemy, Q)
	if M.c.E:Value() and Ready(_E) and ValidTarget(Enemy, E.range) and Epred.hitChance >= .65 and not Epred:mCollision(1) then 
		CastSkillShot(_E, Epred.castPos)
	end 
	if M.c.W:Value() and Ready(_W) and ValidTarget(Enemy, W.range) and Wpred.hitChance >= .65 and not Wpred:mCollision(1) then
		CastSkillShot(_W, Wpred.castPos)
	end
	if M.c.Q:Value() and Ready(_Q) and ValidTarget(Enemy, Q.range) and GetCastName(myHero, _Q) == "VelkozQ" and Qpred.hitChance >= .65 and not Qpred:mCollision(1) and lastQtick + 1000 < Ticker then
		lastQtick = Ticker
		CastSkillShot(_Q, Qpred.castPos)
	end  
end

function Vel_Clear()
	for i, u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY and u.team ~= 300 then
			if Ready(_W) and M.f.W:Value() then
				local pos, hits = GetLineFarmPosition(W.range, W.width, MINION_ENEMY)
				if pos and hits and hits >= 3 then
					CastSkillShot(_W, pos)
				end
			end
			if Ready(_E) and M.f.E:Value() then
				local pos,hits = GetFarmPosition(E.range, E.width, MINION_ENEMY)
				if pos and hits and hits >= 3 then
					CastSkillShot(_E, pos)
				end
			end
		end
		if u.team == MINION_JUNGLE and u.team ~= MINION_ENEMY then
			if Ready(_W) and M.f.WJ:Value() then
				CastSkillShot(_W, u)
			end
			if Ready(_E) and M.f.EJ:Value() then
				CastSkillShot(_E, u)
			end
		end
	end
end

function Vel_Skin()
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
	if time > Tick + M.m.D:Value() and not one then
		Tick = time 
		thing()
	end
	if one and time > Tick2 + one then
		Tick2 = time 
		thing()
	end
end
