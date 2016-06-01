if myHero.charName ~= "Udyr" then return end

if not FileExist(COMMON_PATH.. "Analytics.lua") then
  DownloadFileAsync("https://raw.githubusercontent.com/LoggeL/GoS/master/Analytics.lua", COMMON_PATH .. "Analytics.lua", function() end)
end

require("Analytics")
require("OpenPredict")

local ver = "1.3"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        print("<font color=\"#FF1493\"><b>[Udyr OnS]:</b></font><font color=\"#FFFFFF\"> New version found!</font>")
        print("<font color=\"#FF1493\"><b>[Udyr OnS]:</b></font><font color=\"#FFFFFF\"> Downloading update, please wait...</font>")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Udyr.lua", SCRIPT_PATH .. "Udyr.lua", function() print("<font color=\"#FF1493\"><b>[Udyr OnS]:</b></font><font color=\"#FFFFFF\"> Update Complete, please 2x F6!</font>") return end)
    else
       print("<font color=\"#FF1493\"><b>[Udyr OnS]:</b></font><font color=\"#FFFFFF\"> No Updates Found!</font>")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Udyr.version", AutoUpdate)

Callback.Add("Load", function() Udyr_Load() end)

function Udyr_Load()
	--Other
	summonerNameOne = myHero:GetSpellData(SUMMONER_1).name 
	summonerNameTwo = myHero:GetSpellData(SUMMONER_2).name
	smite = (summonerNameOne:lower():find("smite") and SUMMONER_1 or (summonerNameTwo:lower():find("smite") and SUMMONER_2 or nil))
	--Menu
		M = MenuConfig("Udyr", "Udyr")
		M:Menu("c", "Combo")
			M.c:DropDown("CM", "Combo Mode", 1, {"Phoenix Stance","Tiger Stance"})
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("W", "Use W", true)
			M.c:Slider("Wh", "Use W at what hp?", 70, 1, 150, 1)
			M.c:Boolean("E", "Use E", true)
			M.c:Boolean("R", "Use R", true)
		M:Menu("f", "LaneClear/ JunglerClear")
			M.f:Boolean("Q", "Use LC Q", true)
			M.f:Boolean("W", "Use LC W", true)
			M.f:Boolean("R", "Use LC R", true)
			M.f:Boolean("QJ", "Use JC Q", true)
			M.f:Boolean("WJ", "Use JC W", true)
			M.f:Boolean("EJ", "Use JC E", true)
			M.f:Boolean("RJ", "Use JC R", true)
		M:Menu("m", "Misc")
			M.m:Slider("D", "Ticks Delay", 30, 1, 150, 1)
			M.m:Info("Dd","The Higher = More FPS")
			M.m:Info("DdDD","Also Slower Script")
			M.m:Info("DdD","The Lower = Faster Script")
		if smite then
		M:Menu("l", "Smite Settings")
			M.l:Boolean("B", "Blue", true)
			M.l:Boolean("R", "Red", true)
			M.l:Boolean("D", "Dragon", true)
			M.l:Boolean("H", "Rift Herald", true)
			M.l:Boolean("Ba", "Baron", true)
			M.l:Boolean("K", "Ks", true)
		end
		M:Menu("d", "Drawings")
			M.d:Boolean("R", "R White", false)
		M:Menu("p", "Skin Settings")
			M.p:Boolean("E","Enabled", true)
			M.p:DropDown("S", "Skin", 4, {"Classic", "Black Belt", "Primal", "Spirit Guard", "Definitely Not"}, function(kapap) Udyr_Skin() end)
	--Vars
	Q = { delay = 0.25, speed = math.huge, width = 0, range = myHero.range+myHero.boundingRadius}
	W = { delay = 0.25, speed = math.huge, width = 490, range = myHero.range+myHero.boundingRadius}
	E = { delay = 0.25, speed = 1500, width = 70, range = myHero.range+myHero.boundingRadius}
	R = { delay = 0.25, speed = math.huge, radius = 250, range = myHero.range+myHero.boundingRadius}
	Mode = nil
	Buffs = {Q=0,W=0,E=0,R=0}
	EBuff = {}
	--Callbacks
	Udyr_LoadWalker()
	OneTick(function() smite = (summonerNameOne:lower():find("smite") and SUMMONER_1 or (summonerNameTwo:lower():find("smite") and SUMMONER_2 or nil)); end, 12000)
	Callback.Add("UpdateBuff", function(unit, buff) Udyr_UBuff(unit, buff) end)
	Callback.Add("RemoveBuff", function(unit, buff) Udyr_RBuff(unit, buff) end)
	Callback.Add("Draw", function() Udyr_Draw() end)
	Callback.Add("UnLoad",function() myHero:Skin(0) end)
	--Misc
	Analytics("Clouds Udyr")
	print("<font color=\"#FF1493\"><b>[Udyr OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
	if M.p.E:Value() then
		Udyr_Skin()
	end
end

function Udyr_LoadWalker()
	if IOW_Loaded then
		OneTick(function() Udyr_Tick(IOW:Mode(), "Combo", "LaneClear") end)
	end
	if DAC_Loaded then
		OneTick(function() Udyr_Tick(DAC:Mode(), "Combo", "LaneClear") end)
	end
	if PW_Loaded then
		OneTick(function() Udyr_Tick(PW:Mode(), "Combo", "LaneClear") end)
	end
	if GoSWalk_Loaded then
		OneTick(function() Udyr_Tick(GoSWalk.CurrentMode, 0, 2) end)
	end
	if _G.AutoCarry_Loaded then
		OneTick(function() Udyr_Tick(DACR:Mode(), "Combo", "LaneClear") end)
	end
end

function Udyr_Tick(m,c,l)
	Enemy = GetCurrentTarget()
	if m == c then
		Udyr_Combo()
		Mode = "Combo"
	end
	if m == l then
		Udyr_Clear()
		Mode = "LaneClear"
	end
	if m ~= c and m ~= l then
		Mode = nil
	end
end

function Udyr_Combo()
	if M.c.CM:Value() == 1 and ValidTarget(Enemy, 700) and GetCastLevel(myHero, _E) >= 1 then
		if Ready(_E) and GetDistance(Enemy, myHero) > myHero.boundingRadius+myHero.range then
			CastSpell(_E)
			elseif Ready(_E) and EBuff and EBuff[Enemy.networkID] and EBuff[Enemy.networkID] == 0 and GetDistance(Enemy,myHero) < myHero.boundingRadius+myHero.range then
				CastSpell(_E)
		end
		if Ready(_R) and GetDistance(Enemy, myHero) < myHero.boundingRadius+myHero.range and EBuff and EBuff[Enemy.networkID] and EBuff[Enemy.networkID] >= 1  then
			CastSpell(_R)
			elseif Ready(_R) and GetDistance(Enemy, myHero) > myHero.boundingRadius+myHero.range and GetDistance(myHero, Enemy) < 650 then
				for i, u in pairs(minionManager.objects) do
					local RAOE = GetConicAOEPrediction(Enemy, R, u)
					if RAOE.hitChance >= .65 and GetDistance(u,myHero) < myHero.range + myHero.boundingRadius and Buffs.R == 0 then
						CastSpell(_R)
						AttackUnit(u)
						elseif RAOE.hitChance >= .65 and GetDistance(u,myHero) < myHero.range + myHero.boundingRadius and Buffs.R >= 1 then 
						AttackUnit(u) 
					end
				end
		end
		if Ready(_Q) and GetDistance(Enemy, myHero) < myHero.boundingRadius+myHero.range and EBuff and EBuff[Enemy.networkID] and EBuff[Enemy.networkID] >= 1 and Buffs.R < 3 and not Ready(_R) then
			CastSpell(_Q)
		end
		if Ready(_W) and GetDistance(Enemy,myHero) < myHero.boundingRadius+myHero.range and M.c.W:Value() and GetPercentHP(myHero) <= M.c.Wh:Value() and Buffs.R < 3  then
			CastSpell(_W)
		end
	end
	if M.c.CM:Value() == 2 and ValidTarget(Enemy, 700) and GetCastLevel(myHero, _E) >= 1 then
		if Ready(_E) and GetDistance(Enemy, myHero) > myHero.boundingRadius+myHero.range then
			CastSpell(_E)
			elseif Ready(_E) and EBuff and EBuff[Enemy.networkID] >= 1 and GetDistance(Enemy,myHero) < myHero.boundingRadius+myHero.range then
				CastSpell(_E)
		end
		if Ready(_Q) and GetDistance(Enemy, myHero) < myHero.boundingRadius+myHero.range and EBuff and EBuff[Enemy.networkID] and EBuff[Enemy.networkID] >= 1 then
			CastSpell(_Q)
		end
		if Ready(_R) and GetDistance(Enemy, myHero) < myHero.boundingRadius+myHero.range and EBuff and EBuff[Enemy.networkID] and EBuff[Enemy.networkID] >= 1 and not Ready(_Q) then
			CastSpell(_R)
			elseif Ready(_R) and GetDistance(Enemy, myHero) > myHero.boundingRadius+myHero.range and GetDistance(myHero, Enemy) < 650 then
				for i, u in pairs(minionManager.objects) do
					if not u.dead and u.valid then	
						local RAOE = GetConicAOEPrediction(Enemy, R, u)
						if RAOE.hitChance >= .65 and GetDistance(u,myHero) < myHero.range + myHero.boundingRadius and Buffs.R == 0 then
							CastSpell(_R)
							AttackUnit(u)
							elseif RAOE.hitChance >= .65 and GetDistance(u,myHero) < myHero.range + myHero.boundingRadius and Buffs.R >= 3 then 
							AttackUnit(u) 
						end
					end
				end
		end
		if Ready(_W) and GetDistance(Enemy,myHero) < myHero.boundingRadius+myHero.range and M.c.W:Value() and GetPercentHP(myHero) <= M.c.Wh:Value() and Buffs.R < 3  then
			CastSpell(_W)
		end
	end
	if GetCastLevel(myHero, _E) < 1 then 
		if Ready(_R) and ValidTarget(Enemy, myHero.range + myHero.boundingRadius) and M.c.R:Value() then
			CastSpell(_R)
		end
		if Ready(_Q) and ValidTarget(Enemy, myHero.range + myHero.boundingRadius) and M.c.Q:Value() and Buffs.R < 3 then
			CastSpell(_Q)
		end
		if Ready(_W) and ValidTarget(Enemy, myHero.range+myHero.boundingRadius) and M.c.W:Value() and GetPercentHP(myHero) <= M.c.Wh:Value() and Buffs.R < 3 then
			CastSpell(_W)
		end
	end
end

function Udyr_Clear()
	for i,u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY and u.team ~= 300 then
				if Ready(_R) and M.f.R:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius) then
					CastSpell(_R) 
				end
				if Ready(_Q) and M.f.R:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius) and Buffs.R ~= 3 then
					CastSpell(_Q)
				end
				if Ready(_W) and M.f.W:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius) and GetPercentHP(myHero) <= 75 and Buffs.R ~= 3 then
					CastSpell(_W)
				end
			end
		if u.team == MINION_JUNGLE and u.team ~= MINION_ENEMY then
			if Ready(_E) and M.f.EJ:Value() and ValidTarget(u, 450) then
				CastSpell(_E) 
			end
			if Ready(_R) and M.f.RJ:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius+100) then
				CastSpell(_R) 
			end
			if Ready(_Q) and M.f.QJ:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius+100) and Buffs.R ~= 3 then
				CastSpell(_Q)
			end
			if Ready(_W) and M.f.WJ:Value() and ValidTarget(u, myHero.range+myHero.boundingRadius+100) and GetPercentHP(myHero) <= 75 then
				CastSpell(_W)
			end
		end
	end
end

function Udyr_Draw()
	if M.d.R:Value() and Ready(_R) then
		myHero:Draw(R.range, GoS.White)
	end
	if smite and Ready(smite) then
		for i, u in pairs(minionManager.objects) do
			if u.team ~= MINION_ENEMY and u.team == 300 and ValidTarget(u, 650) then
				local smiteDMG = ({390, 410, 430, 450, 480, 510, 540, 570, 600, 640, 680, 720, 760, 800, 850, 900, 950, 1000})[myHero.level]
				if u.charName:lower():find("dragon") and M.l.D:Value() then
					if u.health < smiteDMG then
						CastTargetSpell(u, smite)
					end
				end
				local smiteable = {["SRU_Red"]={menu = M.l.R:Value()},["SRU_Blue"]={menu = M.l.B:Value()},["SRU_RiftHerald"]={menu = M.l.H:Value()},["SRU_Baron"]={menu = M.l.Ba:Value()}}
				if smiteable[u.charName] and smiteable[u.charName].menu then
					if u.health < smiteDMG then
						CastTargetSpell(u, smite)
					end
				end		
			end
		end
		if GetCastName(myHero,smite) == "S5_SummonerSmitePlayerGanker" and M.l.K:Value() then
			for i,enemy in pairs(GetEnemyHeroes()) do
				if ValidTarget(enemy, 750) and GetCurrentHP(enemy) + GetDmgShield(enemy) <= 20+8*GetLevel(myHero) then
					CastTargetSpell(enemy,smite)
				end
			end
		end
	end
end

function Udyr_UBuff(unit,buff)
	if unit.isMe and buff.Name:lower():find("udyrtigerpunch") then
		Buffs.Q = buff.Count
	end
	if unit.isMe and buff.Name:lower():find("udyrturtleactivation") then
		Buffs.W = buff.Count
	end
	if unit.isMe and buff.Name:lower():find("udyrbearstance") then
		Buffs.E = buff.Count
	end
	if unit.isMe and buff.Name:lower():find("udyrphoenixstance") then
		Buffs.R = buff.Count
	end
	if unit.isMe and buff.Name:lower():find("udyrphoenixactivation") then
		Buffs.R = 3
	end
	if not unit.isMe and unit.team ~= myHero.team and buff.Name:lower():find("udyrbearstuncheck") and unit.type == myHero.type then
		EBuff[unit.networkID] = buff.Count
	end
end

function Udyr_RBuff(unit,buff)
	if unit.isMe and  buff.Name:lower():find("udyrtigerpunch") then
		Buffs.Q = 0
	end
	if unit.isMe and buff.Name:lower():find("udyrturtleactivation") then
		Buffs.W = 0
	end
	if unit.isMe and buff.Name:lower():find("udyrbearstance") then
		Buffs.E = buff.Count
	end
	if unit.isMe and buff.Name:lower():find("udyrphoenixstance") then
		Buffs.R = 0
	end
	if not unit.isMe and unit.team ~= myHero.team and buff.Name:lower():find("udyrbearstuncheck") and unit.type == myHero.type then
		EBuff[unit.networkID] = 0
	end
end

function Udyr_Skin()
	if M.p.E:Value() then
		myHero:Skin(M.p.S:Value()-1)
	end
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
