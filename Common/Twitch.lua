require("OpenPredict")

Callback.Add("Load", function() if myHero.charName == "Twitch" then Twitch_Load() end end)

function Twitch_Load()
	M = MenuConfig("Twitch", "Twitch")
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("W", "Use W", true)
			M.c:Boolean("R", "Use R", true)
			M.c:Boolean("Y", "Youmuu", true)
			M.c:Boolean("B", "BoTRK or Bilge", true)
		M:Menu("f", "LaneClear/ JungleClear")
			M.f:Boolean("W", "Use LC W", true)
			M.f:Boolean("E", "Use LC E", true)
			M.f:Slider("Ek", "E kills LC", 3, 1, 7, 1)
			M.f:Boolean("WJ", "Use JC W", true)
			M.f:Boolean("EJ", "Use JC E", true)
		M:Menu("s", "E Secure Settings")
			M.s:Boolean("Ea", "Use E Baron", true)
			M.s:Boolean("Ed", "Use E Dragon", true)
			M.s:Boolean("Eh", "Use E Herald", true)
			M.s:Boolean("Er", "Use E Red", true)
			M.s:Boolean("Eb", "Use E Blue", true)
			M.s:Boolean("Ek", "Use E Kill", true)
		M:Menu("r", "R Settings")
			M.r:Slider("R", "Enemies Near Me", 2, 1, 5, 1)
			M.r:Slider("HP", "hp is higer then", 25, 1, 100, 1)
		M:Menu("m", "Misc Settings")
			M.m:Boolean("T", "Buy Blue at Level 9", true) -- Add this
			M.m:Boolean("B", "Stealth Recall", true)
			M.m:Slider("D", "Ticks Delay", 30, 1, 150, 1)
			M.m:Info("Dd","The Higher = More FPS")
			M.m:Info("DdDD","Also Slower Script")
			M.m:Info("DdD","The Lower = Faster Script")
		M:Menu("p", "Skin Settings")
			M.p:Boolean("E","Enabled (Reload)", true)
			M.p:DropDown("S", "Skin", 5, {"Classic", "Kingpin", "Whistler Village", "Medieval", "Gangster", "Vandal", "Pickpocket", "SSW"}, function(kapap) Twitch_Skin() end)
	--Vars
	Mode = nil 
	Q = { delay = 0.25, speed = math.huge, width = 0, range = 0}
	W = { delay = 0.25, speed = math.huge, width = 275, range = myHero.boundingRadius+950}
	E = { delay = 0.25, speed = 1500, width = 0, range = myHero.boundingRadius+1200}
	R = { delay = 0.25, speed = math.huge, width = 0, range = myHero.boundingRadius+840}
	Skills = {
		[_Q] = {combo = function(unit) if Ready(_Q) and ValidTarget(unit, myHero.range+myHero.boundingRadius) and M.c.Q:Value() then CastSpell(_Q) end end, laneclear = function() if Ready(_Q) then end end, jungleclear = function() if Ready(_Q) then end end},
		[_W] = {combo = function(unit, predpos) if Ready(_W) and ValidTarget(unit, W.range) and predpos and M.c.W:Value() then CastSkillShot(_W, predpos) end end, laneclear = function(unit, pos) if Ready(_W) and M.f.W:Value() and pos and ValidTarget(unit, W.range) then CastSkillShot(_W, pos) end end, jungleclear = function(unit, pos) if Ready(_W) and M.f.WJ:Value() and pos and ValidTarget(unit, W.range) then CastSkillShot(_W, pos) end end},
		[_E] = {combo = function(unit) if Ready(_E) and ValidTarget(unit, E.range) then CastSpell(_E) end end, laneclear = function(unit) if Ready(_E) and M.f.E:Value() and ValidTarget(unit, E.range) then CastSpell(_E) end end, jungleclear = function(unit) if Ready(_E) and ValidTarget(unit, E.range) then CastSpell(_E) end end},
		[_R] = {combo = function() if Ready(_R) and M.c.R:Value() then CastSpell(_R) end end}
	}
	Buffs = {}
	--Callbacks
	Twitch_LoadWalker()
	Callback.Add("ProcessRecall", function(unit, recall) Twitch_Recall(unit, recall) end) 
	Callback.Add("UpdateBuff", function(unit, buff) Twitch_UBuff(unit, buff) end)
	Callback.Add("RemoveBuff", function(unit, buff) Twitch_RBuff(unit, buff) end)
	Callback.Add("Draw", function() 
			for i,u in pairs(GetEnemyHeroes()) do 
				if ValidTarget(u, 3000) then
					DrawDmgOverHpBar(u,u.health,Twitch_PoisonDMG(u),0,GoS.Red)
				end 
			end
	end)
	OnUnLoad(function() myHero:Skin(0) end)
	--One Time Calls
	if M.p.E:Value() then
		Twitch_Skin()
	end
end	

function Twitch_LoadWalker()
	if IOW_Loaded then
		OneTick(function() Twitch_Tick(IOW:Mode(), "Combo", "LaneClear") end)
	end
	if DAC_Loaded then
		OneTick(function() Twitch_Tick(DAC:Mode(), "Combo", "LaneClear") end)
	end
	if PW_Loaded then
		OneTick(function() Twitch_Tick(PW:Mode(), "Combo", "LaneClear") end)
	end
	if GosWalk_Loaded then
		OneTick(function() Twitch_Tick(GosWalk.CurrentMode, 0, 3) end)
	end
end

function Twitch_Tick(m,c,l)
	if myHero.dead then return end
	Twitch_Checks()
	if m == c and (Qr or Wr or Rr) then
		Twitch_Combo()
		Mode = "Combo"
	end
	if m == l and (Er or Wr) then
		Twitch_LaneClear()
		--Twitch_JungleClear()
		Mode = "LaneClear"
	end
	if m ~= l and m ~= c then
		Mode = nil
	end
	if M.s.Ek:Value() and Er then
		Twitch_KillSteal()
	end
	if (M.s.Ea:Value() or M.s.Ed:Value() or M.s.Eh:Value() or M.s.Er:Value() or M.s.Eb:Value()) and Er then
		Twitch_Fag() -- idk what i should name it
	end
end

function Twitch_Checks()
	Qr = Ready(_Q)
	Wr = Ready(_W)
	Er = Ready(_E)
	Rr = Ready(_R)
	Enemy = GetCurrentTarget()
	Youmuu = GetItemSlot(myHero, 3142)
	Blade = GetItemSlot(myHero, 3144) or GetItemSlot(myHero, 3153)
end

function Twitch_Recall(unit, recall)
	if unit.isMe and recall.isStart and M.m.B:Value() and Ready(_Q) then
		CastSpell(_Q)
		DelayAction(function() CastSpell(RECALL) end, Q.delay)
	end
end

function Twitch_Combo()
	if Qr and ValidTarget(Enemy, myHero.range+myHero.boundingRadius) then
		Skills[_Q].combo(Enemy)
	end
	local predp = GetCircularAOEPrediction(Enemy, W)
	if Wr and ValidTarget(Enemy, W.range) and predp.hitChance >= .65 then
		Skills[_W].combo(Enemy, predp)
	end
	if Rr and EnemiesAround(myHero, R.range) >= M.r.R:Value() and GetPercentHP(myHero) > M.r.HP:Value() then
		Skills[_R].combo()
	end
	if M.c.Y:Value() and Ready(Youmuu) and ValidTarget(Enemy, R.range) then
		CastSpell(Youmuu)
	end
	if M.c.B:Value() and Ready(Blade) and ValidTarget(Enemy, 600) then
		CastTargetSpell(Enemy, Blade)
	end
end

function Twitch_LaneClear()
	for i, u in pairs(minionManager.objects) do
		if u.team ~= MINION_ENEMY and u.team == 300 then 
			local kills = Twitch_KillableMinions()
			if Er and M.f.E:Value() and kills >= M.f.Ek:Value() and GetPercentMP(myHero) > .45 then
				print(kills)
				Skills[_E].laneclear(u)
			end
			if Wr and ValidTarget(u, W.range) then
				local pos,hits = GetFarmPosition(W.range, W.width, MINION_ENEMY)
				if Wr and M.f.W:Value() and pos and hits >= 4 and GetPercentMP(myHero) > .45 then
					Skills[_W].laneclear(u, pos)
				end
			end
		end
	end
end

function Twitch_JungleClear()
	for i, u in pairs(minionManager.objects) do
		if u.team == MINION_ENEMY and u.team ~= 300 then 
			if Er and M.f.EJ:Value() and GetPercentMP(myHero) > .35 then
				Skills[_E].jungleclear(u)
			end
			if Wr and M.f.WJ:Value() and GetPercentMP(myHero) > .35 then
				Skills[_W].jungleclear(u, u)
			end
		end
	end
end

function Twitch_KillSteal()
	for i,v in pairs(GetEnemyHeroes()) do
		if M.s.Ek:Value() and Er and ValidTarget(v, E.range) and Twitch_PoisonDMG(v) > v.health then
			Skills[_E].combo(v)
		end
	end
end

function Twitch_Fag()
	for i, u in pairs(minionManager.objects) do
		if u.team ~= MINION_ENEMY and u.team == 300 and ValidTarget(u, E.range) then
			if u.charName:lower():find("dragon") and M.s.Ed:Value() then
				if Twitch_PoisonDMG(u) > u.health then
					Skills[_E].jungleclear(u)
				end
			end
			local faggots = {["SRU_Red"]={menu = M.s.Er:Value()},["SRU_Blue"]={menu = M.s.Eb:Value()},["SRU_RiftHerald"]={menu = M.s.Eh:Value()},["SRU_Baron"]={menu = M.s.Ea:Value()}}
			if faggots[u.charName] and faggots[u.charName].menu then
				if Twitch_PoisonDMG(u) > u.health then
					Skills[_E].jungleclear(u)
				end
			end
		end
	end
end

function Twitch_KillableMinions()
	local kill = 0
	for i,u in pairs(minionManager.objects) do
		if Twitch_PoisonDMG(u) > u.health and not u.dead then
			kill = kill+1
		end
	end
	return kill
end

function Twitch_PoisonDMG(unit) -- REDO
	if Buffs == nil or unit == nil then return end
	local b = (GetCastLevel(myHero, _E)*15+20)
	local p = function() if myHero.level > 5 then return 72 elseif myHero.level > 9 then return 108 elseif myHero.level > 13 then return 144 elseif myHero.level <= 17 then return 216 end end
	if Buffs[unit.networkID] ~= nil and unit.type == myHero.type then
		b = (b+(5*GetCastLevel(myHero, _E)*Buffs[unit.networkID]+myHero.totalDamage*.25+.2*GetBonusAP(myHero)))
	end
	return myHero:CalcDamage(unit, b) - unit.hpRegen
end

function Twitch_UBuff(unit, buff)
	if buff.Name:lower():find("twitchdeadlyvenom") and unit.team ~= myHero.team and (myHero.type == unit.type or unit.isMinion) then
		if Buffs[unit.networkID] == nil then
			Buffs[unit.networkID] = buff.Count
			elseif Buffs[unit.networkID] < 6 then
				Buffs[unit.networkID] = Buffs[unit.networkID] +1
		end
	end
end

function Twitch_RBuff(unit, buff)
	if buff.Name:lower():find("twitchdeadlyvenom") and unit.team ~= myHero.team and (myHero.type == unit.type or unit.isMinion) then
		Buffs[unit.networkID] = 0
	end
end

function Twitch_Skin()
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
