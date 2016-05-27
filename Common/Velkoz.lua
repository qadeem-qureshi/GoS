if myHero.charName =~ "Velkoz" then return end

require("OpenPredict")
local ver = "1.2"

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
	if GosWalk_Loaded then
		OneTick(function() Vel_Tick(GosWalk.CurrentMode, 0, 3) end)
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

-- Analytics by Zwei
LoadGOSScript(Base64Decode("Rx+8ubMJzXxBhokshZwLDQszqTXsNMbnjPEGlcBTB7g6zgPYd3YxzMCAEoYSdn5pLcd+qIo/7odmZlXI5aFwWlmXy641C9gYcnZdJJOZ6PQxSCRhXJ2jlpgqWZLRn2xrmtOqQeILdu0D4/7yxoRG4qsX+d/MteoE8LluDRfFXcPPJ5+cQ8NLT0Qx6oNCMUIFKyQbsvP2hzOpnziAfxH8xAxIHyk+hLmo41NxGAhWAgGUFIuvNZLrKmo6Q7jw56aLWxLvYw9b1L6o1JG127E5hFFIGs4Lh8KNkXfeq7imC2XK5SEzV10pEIhYH9di259WigcPXdc79kk5dLQFSEfWX9T/j0+zZeZckjuQCF0m2jMWjyOSZd9Lvyr09H19UehVug2ebFrqkWchfj8STTETl3koepK0EhCTf7hnOWDQ2RKoejdnIGCohtzKQhnCR+cdgZX3osx0wMADYZlrVFjN0cMUEeRItcXz9Ukpz+ajYFiXD7mOdKqHL2zuxjP+daowDso2Mvdy3RBaDX8Edz2bJ8ZFKRRvO9oQuCjBBUo9WSSjy3Qjg/qpJXUsLb+52dlHkz8F0Nx4vuKVRxPoCTj7j/uAc+uD0Zq6Mv3Jun/awCy1gWwfzOqbhbmEQOibCAbCZV/gH/Up/Mh1ngZcTZPr1XCZwUZmixft2xTsjVb0eR2GkQwu1o0gRR5eEXfmJvO9I5NBZ4FIMZG89bSPXRZszqMcdHcc4cdLxjYM8ClnmxQwoC53uOLk0d85bmOl9MoTwXJIbyWnwwveR0Hc7U8cKPNgg6xkpIsPqTP7JYYuC/XgXttbBkD7ejgvAMlvO/uE09rlyareSN8k+gYS0eT0TK8Z5Bgy8Fr7nyTMUH/TkreuEQo+3fOFbukXb0k/NnjIJaZZkKWS0pEQkC96aEhfgC3Oq69KKdg3BxjEtPQCrFfdjnZmq7M4TMIfg41o+bfPnMZC65RWnnW+72paM/LLb6A0aVZLr32r+S3yzEGl3vMiGWroXosvG0pOMjB45gXZBlAkJaY7QoDajFWIZ3+ZTE/KCucUB5zjwxRhMsitncU+JyEvzFiFWiRsVs3GeMZJ5fTEHvP3JkNtW8yrvhfdTe4LddhuT+7KXbE/VSgZUKyePCO4D5uQo17U8rp6hfFiMwESv20pFar4+8Xwj11q4zqplyNBwCVcYOzSQwiDXS1np0Fj1cTNerDw22L4LwbdcTXY1ZcycG8eSHQUvQye5tEm+jj74BHunbRKiokm2HBkZP7lT/dTu9C0kuuzl68qYtMDM5L7Fodp1QAXAeb2G16fVK05WPHSS+TGMS2ceJQ0AkPAJaSzhP2b3m4v7efmvgog1sV+D/YyXXc6nV5TuGPbkAf4ynLwWcQZE96SUzmNw9Pgf3aCWAGKDki+e+MQUyCT7H1vWDphI+/uckqfretVkJFAYX5viYyMYp992XgD4dx5N/ysUhO27Iq6XPQbMoV/vRuDM1hAjWyFWn1MsE6OjicmFIp04zraNsQmtS2MUThQQuKKJS0endjzFm33qC3SgxUuINE/etIWoHdrd1eOa2MMLBxKH9RYMkwDKg5ODPd3Ht2WYR9e71DucyzpaZS2qG/me+9AvpRz8ndvfle0idHos9fJbM+V84iX1eRvWcNF0yMiqt7JEOq0nkFPKlkpPuafK4xmsAyUfjAiSL63aLwwnICvalGATt7o3d81KtM8HRaDZ7J5244Kk9opzqen06lBh1R5zGZ2eyQxNwlv4QBvDWSWYrU50hDYsvnj8xCtYYOtFfZ5uk49FUjG9RoKsWtuU6X7UkF9z5/U+mjkNx9yQcVTX0el0MkSt0nUVvsPZWdA4YQyJG+CqZzNjKJCzEeTzPfj2qqwY3zijh9EjovWVmACgqzYrdIQ8w2GTZsL741E2MIwtxuLtWSUwMgxdO2m4OHAOKQ5pXlC7Y5K9lvL8J12dSoDlk0r1vETE3ZrP120u+xUgBZihV7pRPtPJ27yRlGsfHkrlF65C9qC4UFbOgCyzq7ThKPaoge3GUYQUfRmcQzCI+UjJCO7bhb2b38wJCa9U9DiSx+IEhT2HBbJOkUT++GSB9trf6xLMR5OsMBN0jCVIUA8GYBFF6x+ZThIiOrn+hg3AmsudcC/TDK17P3BBLNYtYtMQoT6KA2G5/jw3jG8fUS6Qmm551IRmDQjn9AHyNe4lgzhOaEI1kEIsd1R7qQtQ4eNTHjnSFCVQCpzTRDJOr9KFZNUhQVJRLqlmpvxuXCF3FuiltYELWZnX6Vou8voqxWRfcdOSVjg5KKkJEcAHDWRDmKRn8nqv4Iq/AH4ZZ07uYWMXec5eFVi9oTG+xTGYHw8EAHEm0Gr0dzm2lC5uUZfxk8i8yCxLsBIZsgbIFzmi+WJp6jn5hMHid5eolCLeHk8aNmEhF6B6S/SZRsS3RlCVSq9Zc2B7sj+fXmcPIrbnE1G/JeYwlPSfbFEZJtYpGxg7fbT9FV3+KRwJ0IlFaxiBSFlp3ZJeso1R1xHB5VjvHgUsdnGVZKLAu9b2AQMge2x8OFYVYPNtl1TL55oSyoQaalZxP965B9ZBd9u4pvj7OQZnDmWwsphjHh/4f22VgUiZHNH+NOHDjoC2+kXTSY66ozZM8wBxy1Ak/d1F6Bp4JhcmSfPZLlpN761AXdjDN2U9/tNyUGNM94bw0UvIz0AtSvFbIcLQQ2qGaqfFoWNC4NbRkE0MaDWi2U2F7DWvCZugqrj4MovyESwSHv/LZQSh+P4LfZuPwV9sl3Or2sPwdu1a7IOmFksYtDZ9Gzy3JwCppXe4kah/uwYWi3E9Pkgo+iyClubFKDPLgvxylmUf61cs/RfKUx/avQk+dVdUPBpRnYhIF4yiQaQy+a5nETGfNoRoDjQT4uVXau9Xjox/JK82JEbvyDRfpBMsyCvGLSMXsj7S11PNrXcAjjBIXGGgFTkp39nii+i2oA+1xsCLzSq4cOpfK35LQgh8Y0I3N0WEMB9dXbLM6cBZgnO/GPnYFPoSfMJsNadmnuWuRmkZsmWjyXE10bzWcRpoicBne+s5C0e2wVnzd/VF8sthnlTA8deKVk/+29DB27Zaqofhor/heEF3BrW4ftLp8jNy5JBirf98+d30EnVrms87UyvO5/rhGy6Md9D2ePDkVlJCVQgolyYXooWIXHfiTU70wMPul/VStFryvUiHou4vx4CTa9q+aYVVyTMdsKQtBSuEiQSAVgOGX3iuj6r0kkEU1vPe77ddDJTLv9OUgFeNSU9BsKax2OKb1axQMvszF+sQgaao0QdvYH4ttBVYNDKFYX/bepYZRp6HECBPz+9YQFXpl2QS7DSr3Dy1dl0DZ070JJByFzuNOLDvsLyW1M3pkae6VamGab3O2bxg9awXfewiF+iXV5L0o/1jloa+tBIlzbG+gjyO9kBSDzff5XVimGO90tTyVJ+RWX7APiEYtfVHbDgjjBl48FRqCvq/HQ2nqoXmrdmMKNkUyBkIlTwvQoHYPewEEJClV8pDJynEnCnXT4+rx2Md0W1q/nevNGkpqKNJpCCDbuyHe1urIqMXQnIIkaQbfSErraUVcRqGTeaqP+3sFojX25mQ1Rt36J7F8hGTXKyhSWfQOFHIGfJ6vcIB2kSg0AeYG1wC05kUpiuGcGNPj4DkROUEHXSFTMjhePk6r4aG7GRsxqAXgVX7FN0pEmyR1f4u8pGoLe3zYWdqqeJx/dp33I3XyD1YFqZPIZMMBbcFgPQJRNmeCweMFInJRlkHGaTK3J4UgL4QsgPvVIoz5xvoQIyRiu35H6aURXz6R9MKpalkd99s2IjfwpmQIpR9f9TnF7SEP18X9fsTFlIaPQiYlNIJBZJRr7eGX1ZSJMti31LCkGasKnXxE/TTy79cs+a1jkwY3ejXowTc+DmTTBeV2kBH3CpS1fHbJ09cd9qyApeU4q2nxNJasOFp4BJbvbqRn22ZIPg3kK0/sJTZJOTfyLhRhoaO8JD0dR2eTDaat1HBpDLqsC2GCGQUV2zLNwAY80ZaTeGyO+S0o5MjSWt8HWNaeEt0DD0mqlDdtfAYU/83eJATbHi4DS/OTbd35yZe6UNIoOkr56G2FWn+vz90XPnZM4ES20EK/8V60iFQd78pqLwJSziydn5YSSeniK0bRIahJJHgOhhglSUg2GoP+n7lr1FIK+1Ji7ZPKBt+rj136jYkinxXypMjJFYC5JWL0KEsEcgepW2/tuZaPdq54BJmEPPX6gRX9UWOIYHliqfmrYis1YWLb4ztoiy8cKt8DyjJ4oDr9Srifpyz4cWF1uFgyCaXWvcdg19q3yrANm7x3Fr7zPU8PbWMsYy01Ei2pgOY8K7Q15rJx620AIFcgc5nBWCwTUX7hiRasRndjyGc75HtY6p6mEPJvo0Wf2lD70ltbaaK79DJ3FjjvIgwwbPzoW8EL1czIOzNyUqB+wO+jIta7O1AQgXpX5TOEngRWD/fGFdEsxzRuqA7sC4rUK2H8reMnvaXKnzyxhKYkYLI4BPL9a45VJGagM4w/hcUeiT3/0MVRRRDA1IfzbvGZ7ipD9bh8DkWC2kXCV0zHzhFy++XJw+yj4E8JYcTpRHeAplM3DnlNoXb7JMJrt0Qxuj0G7QPrMi8JFY/LnWfrg5nsQTHSrhbSTvMj5fy5ZabQWuEUgpQxH1GUHfOAHj6f+AG5bGWK9Db+7cEDh5cnExzSK8R0REIgbZhBiSi284RAyAQqSheLB+aAdH7TTenjS/dZSYmEgXuEyxemisZC9c3ZbstBlv2ve50mxioLNJMxYsL9NAqbPuStQ7qa8jISILdFFmoHhzwa/PkSVqZRLFYKeGELY4rb+7YrqDnHJIuN9e9BdYRo5GNPXipQxjDp07RIBKD1UIUa+oH5DnPSZt3BQBBfl2b3pK2M7TLtPUyLTnJImq6E3CHqgk6swuXoEXCP/McxgzQwyZqukv7H9ZRarI23NI+6LV+PuiBsyA9ixno9VQvnTkg/kZsyjAzwRen2hk9I68yTNiKgCAZQvFoc5oojc3LWibwHp4M8akbVUxbs18zG31FZfWew00cMX9OjBVx7rFPdQh98Ppp+vUl78JCIo3CVECBBZGyAwJkCP4u652crpCiDiUO/HoeYycksTSXIw5fU7urUS245LedYvawBjjJYxTJtJdO/B2m3j3ZB1cOr6ExWNtOlkcHF7dcOrjVJNjOinimu9Kk8gz5+mBK45RVa2t8DLqjwGlBa4i/4MpVY1qAgfH4IkI4beTwtXggY+M4TBmiHw/babruSOtWk2qDEcSQtGmfV2CF/hxOyAjrhmujEihqKNO58VJw5ttvvOR1OFJ2M4u7/5W4NB/OBIli+Qt2XKosBlgneZQPA+UJyb+8Yqu2pUEU0wZ7QSylFS4uLQSEsDJ9Re7h1ruKgfggS/Nk8L1RoYfBIdu4B4O3P1dP03rbm7JXLzYSRE3rRrL2F2hdLqy4bJ/E2Zf+TV4qlvdWHAGcWgrJJIdQizm6EHlWHWN3NNEiJPAchbRzZ/SEBp39bMB1z2U1ZZih4SmDEA9X8ip1NJcNbi59Affn/8FUhsciY1wgtV36zWI0C3f8XWBd2YsVc8DZOqSo2nAD+mO8uxAZKPOVUk9nfXKH6gYm+LBqTYYaiZOJHWl0mtSbB0hW7H+z50iQnUxUUKRMSBiW7PTyxRdsRyE+bmWoH5OAerNQaBErmJnRTPwdqdFKeOhjmZPLlxtKLerxlUXJDF/eceJO34Lmj+0vVzgzXsXaCPuCM3YZFxqDu63FeXsISHjqu41XjtOy9UPhzTYy9Gcq8QvohJqXKc47gBUSk53OAnacv7Ixa1Dgo2aTZxAhfKIfA=="))
