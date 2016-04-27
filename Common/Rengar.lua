-- Bby Zwei this is for your playlist. 
-- Not being released on forum, who ever finds this, finds the secret Rengar :) Sneaky Sneaky KAPPA
require("OpenPredict")
--[[
 ▄████████    ▄████████ ███▄▄▄▄      ▄██████▄     ▄████████    ▄████████ 
  ███    ███   ███    ███ ███▀▀▀██▄   ███    ███   ███    ███   ███    ███ 
  ███    ███   ███    █▀  ███   ███   ███    █▀    ███    ███   ███    ███ 
 ▄███▄▄▄▄██▀  ▄███▄▄▄     ███   ███  ▄███          ███    ███  ▄███▄▄▄▄██▀ 
▀▀███▀▀▀▀▀   ▀▀███▀▀▀     ███   ███ ▀▀███ ████▄  ▀███████████ ▀▀███▀▀▀▀▀   
▀███████████   ███    █▄  ███   ███   ███    ███   ███    ███ ▀███████████ 
  ███    ███   ███    ███ ███   ███   ███    ███   ███    ███   ███    ███ 
  ███    ███   ██████████  ▀█   █▀    ████████▀    ███    █▀    ███    ███ 
  ███    ███                                                    ███    ███ 
]]
local Stacks = myHero.mana
local Passive = function() return GotBuff(myHero, "rengarpassivebuff") >= 1 end
local RBuff = function() return GotBuff(myHero, "RengarR") >= 1 end
local version = "1"
local ignite, ignitedamage = function() local summonerNameOne = myHero:GetSpellData(SUMMONER_1).name local summonerNameTwo = myHero:GetSpellData(SUMMONER_2).name (summonerNameOne:lower():find("summonerdot") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerdot") and SUMMONER_2 or nil)) end, function() if ignite ~= nil then return 70 + 20*GetLevel(myHero) end end
local smitetable = {"s5_summonersmiteplayerganker", "s5_summonersmiteduel", "summonersmite"}
local Smite = function() for i, u in pairs(smitetable) do local summonerNameOne = myHero:GetSpellData(SUMMONER_1).name local summonerNameTwo = myHero:GetSpellData(SUMMONER_2).name return (summonerNameOne:lower():find(u) and SUMMONER_1 or (summonerNameTwo:lower():find(u) and SUMMONER_2 or nil)) end end
local SwitchTime = 0
local LastAttack, LastQAA = 0, 0
local LastQ, LastW, LastE, LastSpell = 0, 0, 0, 0
local Youmuu = GetItemSlot(myHero, 3142)
local Tiamat = GetItemSlot(myHero, 3077)
local Hydra = GetItemSlote(myHero, 3074)
local Titanic = GetItemSlot(myHero, 3053)
local Enemy = nil

class "Rengar"
function Rengar:__init()
	Q = { delay = 0.25, speed = math.huge, width = 0, range = GetRange(myHero)+100}
	W = { delay = 0.25, speed = math.huge, width = 490, range = myHero.boundingRadius+500, damage = function() return 80+30*GetCastLevel(myHero, _Q) + .8*GetBonusAP(myHero) end}
	E = { delay = 0.25, speed = 1225, width = 80, range = myHero.boundingRadius+1000}
	R = { delay = 0.25, speed = math.huge, width = 0, range = 2000}
	Callback.Add("Load", function() self:Load() end)
end

function Rengar:Selector(Msg, Key)
	if Msg ~= WM_LBUTTONDOWN then return end
	local Target = function() for i, u in pairs(GetEnemyHeroes()) do if u.valid and GetDistance(u, GetCursorPos()) < u.boundingRadius+80 then return u end end end
	if Target() ~= nil then
		Enemy = Target()
		SelectedTarget = Target()
	end
end

function Rengar:Load()
	M = MenuConfig("Rengar", "Rengar")
		M:Menu("s", "Summoners")
			M.s:Boolean("i", "Use Ignite", true)
			M.s:Boolean("s", "Use Smite Combo", true)
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("W", "Use W", true)
			M.c:Boolean("E", "Use E", true)
			M.c:Boolean("SE", "Switch to Q after E", true)
			M.c:Boolean("SoE", "Use E out of range", false)
			M.c:DropDown("m", "Combo Mode", 2, {"E", "W", "Q"})
			M.c:KeyBinding("cm", "Change Combo Mode", string.byte("Z"))
			M.c:KeyBinding("TQ", "Triple Q", string.byte("A"))
		M:Menu("h", "Harass")
			M.h:Boolean("Q", "Use Q", true)
			M.h:Boolean("W", "Use W", true)
			M.h:Boolean("E", "Use E", true)
			M.h:DropDown("m", "Harass Mode", 1, {"E", "Q"})
		M:Menu("f", "LaneClear/ JunglerClear")
			M.f:Boolean("Q", "Use LC Q", true)
			M.f:Boolean("W", "Use LC W", true)
			M.f:Boolean("E", "Use LC E", true)
			M.f:Boolean("S", "Save Passive LC?", false)
			M.f:Boolean("QJ", "Use JC Q", true)
			M.f:Boolean("WJ", "Use JC W", true)
			M.f:Boolean("EJ", "Use JC E", true)
			M.f:Boolean("JM", "Movement in Jungle disabled?", false)
			M.f:Boolean("SJ", "Save Passive JC?", false)
		M:Menu("h", "Heal")
			M.h:Boolean("AH", "Auto Heal?", true)
			M.h:Slider("HP", "What Hp %?", 25, 1, 100, 1)
			M.h:Slider("AHI", "Heal On Incoming Damage %?", 20, 1, 100, 1)
		M:Menu("k", "KillSteal")
			M.k:Boolean("W", "Use W", true)
		M:Menu("b", "Beta Options")
			M.b:Boolean("Q", "Use Q BETA", true)
			M.b:Boolean("Y", "Youmuu Required?", true)
			M.b:Info("AS","Assassin search range")
			M.b:Slider("SR", "Search range?", 2000, 1000, 2500, 1)
			M.b:Slider("QR", "Q Cast range?", 1000, 500, 1500, 1)
			M.b:Boolean("SDR", "Draw Search Range?", true)
			M.b:Boolean("QDR", "Draw Q Cast Range?", true)
		M:Menu("m", "Misc")
			M.m:Boolean("DT", "Turn Of Draws?", false)
			M.m:Boolean("DE", "Draw exclamation mark range?", true)
			M.m:Boolean("DW", "Draw W Range?", true)
			M.m:Boolean("DER", "Draw E Range?", true)
			M.m:Boolean("DR", "Draw R Minimap?", true)

	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
	OnProcessSpellCast(function(unit,spell) self:PSC(unit, spell) end)
	OnDamage(function(sender,receiver,dmg) self:DMG(sender, receiver, dmg) end)
	PW:AddCallback(AFTER_ATTACK, self:AfterAttack())
	PW:AddCallback(BEFORE_ATTACK, self:BeforeAttack())
	Callback.Add("WndMsg", function(Msg, Key) self:Selector(Msg, Key) end)
	Callback.Add("Animation",function(unit,ani) self:OnJump(unit,ani) end)
end

function Rengar:AfterAttack()
	if (PW:Mode() == "Combo" or PW:Mode() == "Harass") and Ready(_Q) and ValidTarget(Enemy, Q.range) then
		CastSpell(_Q)
	end
	CastItems(Enemy)
end

function Rengar:DMG(sender, receiver, dmg)
	if not M.h.AH:Value() then return end
	if RBuff() or CanUseSpell(myHero, _W) ~= READY or GotBuff(myHero, "recall") > 0  or GotBuff(myHero, "teleport") or Stacks <= 4 then return end
	if (dmg/myHero.health) > M.h.AHI:Value() or GetPercentHP(myHero) < M.h.HP:Value() then
		CastSpell(_W)
	end
end

function Rengar:BeforeAttack()
	if PW:Mode() == "Combo" and Ready(_Q) and not (Passive() or Stacks == 5 or M.c.m:Value() == 1) then
		if ValidTarget(Enemy, GetRange(myHero)) then
			CastSpell(_Q)
		end
	end
end

function Rengar:KillSteal()
	for i, u in pairs(GetEnemyHeroes()) do
		if ValidTarget(u, W.range) and u.health < myHero:CalcMagicDamage(u, W.dmg()) and M.k.W:Value() then
			CastSpell(_W) 
		end
		if ValidTarget(u, 660) and ignite() ~= nil and u.health < ignitedamage() and M.s.i:Value() then
			CastTargetSpell(u, iginte())
		end
	end
end

function Rengar:OnJump(unit, ani)
	if unit and unit == myHero and ani == "Spell5" then
		if PW:Mode() == "Combo" and Stacks == 5 and ValidTarget(Enemy, 1500) then
			if  M.c.m:Value() == 1 and Ready(_E) then
				local prediction = GetPrediction(Enemy, E)
				CastSkillShot(_E, prediction.castPos)
				elseif  M.c.m:Value() == 2 then
					if Ready(_Q) and ValidTarget(Enemy, Q.range) then
						CastSpell(_Q)
					end
					if ValidTarget(Enemy, Q.range) and ValidTarget(Enemy, W.range) and Ready(_W) then
						CastSpell(_W)
					end
					CastSkillShot(_E, Enemy.pos)
					CastItems(Enemy)
			end
		end 
		if PW:Mode() == "Combo" then
			if  M.c.m:Value() == 1 and Ready(_E) then
				local prediction = GetPrediction(Enemy, E)
				CastSkillShot(_E, prediction.castPos)
				elseif  M.c.m:Value() == 2 and M.b.Q:Value() then
					CastSpell(_Q)
			end
			CastItems(Enemy)
		end
	end
end

function Rengar:Draw()
	if M.m.DT:Value() then return end
	if SelectedTarget ~= nil and SelectedTarget.visible and not SelectedTarget.dead then
		DrawCircle(SelectedTarget, 80, 2, 15, GoS.White)
	end
	if GetCastLevel(myHero, _R) > 0 then 
		DrawCircle(myHero, M.b.SDR:Value(), 2, 15, GoS.White)
		DrawCircle(myHero, M.b.QR:Value(), 2, 15, GoS.White)
	end
	if RBuff() and M.m.DE:Value() then
		DrawCircle(myHero, 1450, 2, 15, GoS.White)
	end
	if M.m.DW:Value() and myHero:CanUseSpell(_W) then
		DrawCircle(myHero, W.range, 2, 15, GoS.White)
	end
	if M.m.DER:Value() and myHero:CanUseSpell(_E) then
		DrawCircle(myHero, E.range, 2, 15, GoS.White)
	end
	if M.m.DR:Value() and not myHero.dead then
		DrawCircleMinimap(myHero, R.range, 1, 15, GoS.White)
	end
end

function Rengar:PSC(unit, spell)
	if unit and unit == myHero then
		if spell.name == "RengarR" then
			DelayAction(function() local Youmuu = GetItemSlot(myHero, 3142) if Youmuu ~= nil and Ready(Youmuu) then CastSpell(Youmuu) end end, 2000)
		end
		if spell.name == "RengarQ" then
			LastQ = GetTickCount()
		end
		if spell.name == "RengarE" then
			LastE = GetTickCount()
		end
		if spell.name == "RengarW" then
			LastW = GetTickCount()
		end
	end
end

function Rengar:Tick()
	if not myHero.dead then
		if PW:Mode() == "Combo" then
			self:Combo()
		end
		if PW:Mode() == "LaneClear" then
			self:LaneClear()
			self:JunglerClear()
		end
		if PW:Mode() == "Harass" then
			self:Harass()
		end
		SwitchCombo()
		Smite()
		Passive()
		RBuff()
		ignite()
		ignitedamage()
		if ValidTarget(Enemy, 1500) then
			self:KillSteal()
		end
		if M.c.TQ:Value() and ValidTarget(Enemy, E.range) then
			if RBuff() then
				if Stacks == 5 and Enemy.distance < Q.range then
					CastSpell(_Q)
				end
			else
				CastSpell(_Q)
			end
			if Stacks <= 4 then
				if Enemy.distance <= Q.range then
					CastSpell(_Q)
				end
				if Enemy.distance <= W.range then
					CastSpell(_W)
				end
				if Enemy.distance <= E.range then
					CastSkillShot(_E, Enemy.pos)
				end
			end
		end
		if M.b.Q:Value() then
			if M.b.Y:Value() and Youmuu == nil then return end
			if ValidTarget(Enemy, M.b.SR:Value()) then
				if Stacks == 5 and RBuff() then
					if target.distance <= M.b.QR:Value() then
						CastSpell(_Q)
					end
				end
			end
		end
		if Enemy == nil and SelectedTarget == nil then
			Enemy = GetCurrentTarget()
		end
	end
end

function Rengar:SwitchCombo()
	local Switch = GetTickCount() - SwitchTime
	if M.c.cm:Value() and Switch >= 350 then
		if M.c.m:Value() == 1 then 
			M.c.m:Value(2)
			print("Combo Mode: W") 
			SwitchTime = GetTickCount()
		end
		if M.c.m:Value() == 2 then
			M.c.m:Value(3)
			print("Combo Mode: Q")
			SwitchTime = GetTickCount()
		end
		if M.c.m:Value() == 3 then
			M.c.m:Value(1)
			print("Combo Mode: E")
			SwitchTime = GetTickCount()
		end
	end
end

function Rengar:Combo()
	if Enemy == nil then return end
	if Stacks <= 4 then
		if Ready(_Q) and ValidTarget(Enemy, Q.range) and M.c.Q:Value() then
			CastSpell(_Q)
		end
		if not RBuff() then
			CastItems(Enemy)
			if Ready(_E) and M.c.E:Value() not Passive() then
				self:CastE(Enemy)
				elseif Ready(_E) and M.c.E:Value() then
					self:CastE(Enemy)
			end
		end
		if Ready(_W) and M.c.W:Value() then
			self:CastW()
		end
	end
	if Stacks == 5 then
		if M.c.m:Value() == 1 and not RBuff() then
			if Ready(_E) and not Passive() then
				self:CastE(Enemy)
				if M.c.SE:Value() and GetTickCount() - LastE >= 500 and GetTickCount() - SwitchTime >= 350 then
					M.c.m:Value(3)
					SwitchTime = GetTickCount()
				end
			end
		elseif Ready(_E) and M.c.E:Value() then
			self:CastE(Enemy)
		end
		if M.c.m:Value() == 2 and Ready(_W) and M.c.W:Value() then
			self:CastW()
		end
		if M.c.m:Value() == 3 and Ready(_Q) and ValidTarget(Enemy, Q.range) then
			CastSpell(_Q)
		end
		if M.c.SoE:Value() and Ready(_E) not RBuff() then
			self:CastE(Enemy)
		end
	end
	if Youmuu ~= nil and Ready(Youmuu) and ValidTarget(Enemy, Q.range) then
		CastSpell(Youmuu)
	end
	if M.s.s:Value() and Smite() ~= nil and Ready(Smite()) and not RBuff() then
		CastTargetSpell(Enemy, Smite())
	end
	if M.s.i:Value() and ignite() ~= nil and ValidTarget(Enemy, 660) and ignitedamage() > Enemy.health then 
		CastTargetSpell(Enemy, ignite())
	end 
end

function Rengar:CastE(unit)
	if Ready(_E) and ValidTarget(unit, E.range) then
		local prediction = GetPrediction(unit, E)
		if prediction.hitChance >=.45 then
			CastSkillShot(_E, prediction.castPos)
		end
	end
end

function Rengar:CastW()
	if GetTickCount() - LastE <= 150 or not Ready(_W) then return end 
	if EnemiesAround(myHero, W.range) > 0 then
		CastSpell(_W)
	end
end

function Rengar:Harass()
	if ValidTarget(Enemy, E.range) then
		if Stacks == 5 then
			if M.h.m:Value() == 1 then
				if M.h.E:Value() and Ready(_E) and not Passive()
					self:CastE(Enemy)
				end
			end
			if M.h.m:Value() == 2 then
				if M.h.Q:Value() and Ready(_Q) and ValidTarget(Enemy, Q.range) then
					CastSpell(_Q)
				end
			end
		end
		if Stacks <= 4 then
			if M.h.Q:Value() and ValidTarget(Enemy, Q.range) then
				CastSpell(_Q)
			end
			if RBuff() then return end
			CastItems(Enemy)
			if M.h.E:Value() and Ready(_E) then
				self:CastE(Enemy)
			end
			if M.h.W:Value() and Ready(_W) then
				self:CastW()
			end
		end
	end
end

function Rengar:JunglerClear()
	for i, u in pairs(minionManager.objects) do
		if GetTeam(u) == GetTeam(MINION_JUNGLE) then
			if u ~= nil then
				CastItems(minion)
				if Stacks == 5 and M.f.SJ:Value() then
					if ValidTarget(u, W.range) and not Passive() then
						CastItems(u)
					end
					return
				end
				if M.f.Qj:Value() and Ready(_Q) and ValidTarget(u, Q.range) then
					CastSpell(_Q)
				end
				if M.f.Wj:Value() and Ready(_W) and ValidTarget(u, W.range) then
					CastSpell(_W)
				end
				if M.f.Ej:Value() and Ready(_E) and ValidTarget(u, E.range) then
					CastSkillShot(_E, u.pos)
				end
			end
		end
	end
end

function Rengar:LaneClear()
	for i, u in pairs(minionManager.objects) do
		if GetTeam(u) == GetTeam(MINION_ENEMY) and GetTeam(u) ~= GetTeam(MINION_JUNGLE) then
			if u ~= nil then
				CastItems(minion)
				if Stacks == 5 and M.f.S:Value() then
					if ValidTarget(u, W.range) and not Passive() then
						CastItems(u)
					end
					return
				end
				if M.f.Q:Value() and Ready(_Q) and ValidTarget(u, Q.range) then
					CastSpell(_Q)
				end
				if M.f.W:Value() and Ready(_W) and ValidTarget(u, W.range) then
					CastSpell(_W)
				end
				if M.f.E:Value() and Ready(_E) and ValidTarget(u, E.range) then
					CastSkillShot(_E, u.pos)
				end
			end
		end
	end
end

function Rengar:CastItems(unit)
	if not RBuff() then
		local Total = EnemiesAround(myHero, 385) + MinionsAround(myHero, 385)
		if Ready(Tiamat) and Total > 0 then 
			CastSpell(Tiamat)
		end
		if Ready(Hydra) and Total > 0 and not RBuff() then 
			CastSpell(Hydra)
		end
		if Ready(Titanic) and Total > 0 and not RBuff() then 
			CastSpell(Titanic)
		end 
		if PW:Mode() == "Combo" or PW:Mode() == "Harass" then 
			if Ready(Youmuu) then 
				CastSpell(Youmuu)
			end
		end 
	end
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
