require("OpenPredict")
require("DamageLib")
local ver = "1.0"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New version found! " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Kench.lua", SCRIPT_PATH .. "Kench.lua", function() PrintChat("<font color=\"#cd0fc8\"><b>[Kench OnS]:</b></font><font color=\"#FFFFFF\"> Update Complete, please 2x F6!</font>") return end)
    else
       PrintChat("<font color=\"#cd0fc8\"><b>[Kench OnS]:</b></font><font color=\"#FFFFFF\"> No Updates Found!</font>")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Cloudhax23/GoS/master/Common/Kench.version", AutoUpdate)

Callback.Add("Load", function() if myHero.charName == "TahmKench" then Kench_Load() end end)

function Kench_Load()
	Q = { delay = 0.25, speed = 2000, width = 70, range = 800}
	W = { delay = 0.25, speed = math.huge, width = 0, range = 300}
	Ws = { delay = 0.50, speed = 950, width = 70, range = 650}
	E = { delay = 0.25, speed = math.huge, width = 0, range = 0}
	R = { delay = 0.25, speed = math.huge, width = 0, range = 0}
	Draw = {}
	M = MenuConfig("TahmKench", "Tahm Kench")
		M:Menu("c", "Combo")
			M.c:Boolean("Q", "Use Q", true)
			M.c:Boolean("W", "Use W", true)
	WBuff = { target = nil, count = 0}
	WBuff2 = { target = nil, count = 0}
	Kench_LoadWalker()
	Callback.Add("UpdateBuff", function(unit, buff) Kench_UBuff(unit, buff) end)
	Callback.Add("RemoveBuff", function(unit, buff) Kench_RBuff(unit, buff) end)
	Kench_RegisterSpells()
	print("<font color=\"#cd0fc8\"><b>[Kench OnS]:</b></font><font color=\"#FFFFFF\"> Loaded!</font>")
end

function Kench_LoadWalker()
	if IOW_Loaded then
		Callback.Add("Tick", function() Kench_Tick(IOW:Mode(), "Combo", "LaneClear") end)
	end
	if DAC_Loaded then
		Callback.Add("Tick", function() Kench_Tick(DAC:Mode(), "Combo", "LaneClear") end)
	end
	if PW_Loaded then
		Callback.Add("Tick", function() Kench_Tick(PW:Mode(), "Combo", "LaneClear") end)
	end
	if GoSWalk_Loaded then
		Callback.Add("Tick", function() Kench_Tick(GoSWalk:GetCurrentMode(), 0, 3) end)
	end
	if _G.AutoCarry_Loaded then
		Callback.Add("Tick", function() Kench_Tick(DACR:Mode(), "Combo", "LaneClear") end)
	end
end

function Kench_Tick(m,c,l)
	if myHero.dead == true then return end
	local unit = GetCurrentTarget()
	if m == c and Ready(_Q) and M.c.Q:Value() and ValidTarget(unit, Q.range) then
		Kench_Q(unit)
	end
	if m == c and Ready(_W) and M.c.W:Value() then
		Kench_W(unit)
	end
end

function Kench_UBuff(unit, buff)
	if unit and unit ~= myHero and unit ~= Obj_AI_Minion and buff.Name == "tahmkenchpdevourable" then
		WBuff.target = unit 
		WBuff.count = buff.Count
	end
	if unit and unit ~= myHero and buff.Name == "tahmkenchwdevoured" then
		WBuff2.target = unit 
		WBuff2.count = buff.Count
	end
end 

function Kench_RBuff(unit, buff)
	if unit and unit ~= myHero and buff.Name == "tahmkenchpdevourable" then
		WBuff.target = nil 
		WBuff.count = buff.Count
	end
	if unit and unit ~= myHero and buff.Name == "tahmkenchwdevoured" then
		WBuff2.target = unit 
		WBuff2.count = buff.Count
	end
end

function Kench_Q(target)
	local QPred = GetPrediction(target, Q)
	if QPred.hitChance >= .65 and not QPred:mCollision(1) then
		CastSkillShot(_Q, QPred.castPos)
	end
end

function Kench_W(target)
	if WBuff.count >= 1 and ValidTarget(target, W.range) then
		CastTargetSpell(target, _W)
	end
	if ValidTarget(target, Ws.range) and GetCastName(myHero, _W) == "TahmKenchW" and not ValidTarget(target, W.range) then 
		local minion = ClosestMinion(myHero)
		if minion ~= nil and ValidTarget(minion, W.range) then
			CastTargetSpell(minion, _W)
		end
	end
	if WBuff2.target ~= nil and GetCastName(myHero, _W) == "TahmKenchWSpitReady" and WBuff2.target.team ~= myHero.team then
		local WPred = GetPrediction(target, Ws)
		if WPred.hitChance >= .45 and not WPred:mCollision(1) then
			CastSkillShot(_W, WPred.castPos)
		end
	end 
end

function Kench_RegisterSpells()
	local str = {[-4] = "R2", [-3] = "P", [-2] = "Q3", [-1] = "Q2", [_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
	M:Menu("SB","W Ally Settings")
		M.SB:Boolean("W", "Use W Save?", true)
		M.SB:Boolean("Wt", "Use W Targeted?", true)
		M.SB:Boolean("Ws", "Use W Skillshots?", true)
	skills = {
	
		["Aatrox"] = {
			[_Q] = { displayname = "Dark Flight", name = "AatroxQ", speed = 450, delay = 0.25, range = 650, width = 285, collision = false, aoe = true, type = "circular" , danger = 3, type2 = "gc"},
			[_E] = { displayname = "Blades of Torment", name = "AatroxE", objname = "AatroxEConeMissile", speed = 1250, delay = 0.25, range = 1075, width = 35, collision = false, aoe = false, type = "linear", danger = 1}
		},
		["Ahri"] = {
			[_Q] = { displayname = "Orb of Deception", name = "AhriOrbofDeception", objname = "AhriOrbMissile", speed = 2500, delay = 0.25, range = 1000, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Orb Return", name = "AhriOrbReturn", objname = "AhriOrbReturn", speed = 1900, delay = 0.25, range = 1000, width = 100, collision = false, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Charm", name = "AhriSeduce", objname = "AhriSeduceMissile", speed = 1550, delay = 0.25, range = 1000, width = 60, collision = true, aoe = false, type = "linear", danger = 4, type2 = "cc"},
		},
		["Akali"] = {
			[_E] = { displayname = "Crescent Slash", name = "CrescentSlash", speed = math.huge, delay = 0.125, range = 0, width = 325, collision = false, aoe = true, type = "circular", danger = 1}
		},
		["Alistar"] = {
			[_Q] = { displayname = "Pulverize", name = "Pulverize", speed = math.huge, delay = 0.25, range = 0, width = 365, collision = false, aoe = true, type = "circular", danger = 4, type2 = "cc"}
		},
		["Amumu"] = {
			[_Q] = { displayname = "Bandage Toss", name = "BandageToss", objname = "SadMummyBandageToss", speed = 725, delay = 0.25, range = 1000, width = 100, collision = true, aoe = false, type = "linear", danger = 4, type2 = "cc"}
		},
		["Anivia"] = {
			[_Q] = { displayname = "Flash Frost", name = "FlashFrostSpell", objname = "FlashFrostSpell", speed = 850, delay = 0.250, range = 1200, width = 110, collision = false, aoe = false, type = "linear", danger = 3, type2 = "cc"},
			[_R] = { displayname = "Glacial Storm", name = "GlacialStorm", speed = math.huge, delay = math.huge, range = 615, width = 350, collision = false, aoe = true, type = "circular", danger = 3}
		},
		["Annie"] = {
			[_Q] = { name = "Disintegrate", danger = 2},
			[_W] = { displayname = "Incinerate", name = "Incinerate", speed = math.huge, delay = 0.25, range = 625, width = 250, collision = false, aoe = true, type = "cone", danger = 3},
			[_R] = { displayname = "Tibbers", name = "InfernalGuardian", speed = math.huge, delay = 0.25, range = 600, width = 300, collision = false, aoe = true, type = "circular", ranger = 5, type2 = "cc"}
		},
		["Ashe"] = {
			[_W] = { displayname = "Volley", name = "Volley", objname = "VolleyAttack", speed = 902, delay = 0.25, range = 1200, width = 100, collision = true, aoe = false, type = "cone", danger = 2},
			[_R] = { displayname = "Enchanted Crystal Arrow", name = "EnchantedCrystalArrow", objname = "EnchantedCrystalArrow", speed = 1600, delay = 0.5, range = 25000, width = 100, collision = true, aoe = false, type = "linear", danger = 5, type2 = "cc"}
		},
		["AurelionSol"] = {
			[_Q] = { displayname = "Starsurge", name = "AurelionSolQ", objname = "AurelionSolQMissile", speed = 850, delay = 0.25, range = 1500, width = 150, collision = false, aoe = true, type = "linear", danger = 3, type2 = "cc"},
			[_R] = { displayname = "Voice of Light", name = "AurelionSolR", objname = "AurelionSolRBeamMissile", speed = 4600, delay = 0.3, range = 1420, width = 120, collision = false, aoe = true, type = "linear", danger = 4},
		},
		["Azir"] = {
			[_Q] = { displayname = "Conquering Sands", name = "AzirQ", speed = 2500, delay = 0.250, range = 880, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "Shifting Sands", name = "AzirE", range = 1100, delay = 0.25, speed = 1200, width = 60, collision = true, aoe = false, type = "linear", danger = 1},
			[_R] = { displayname = "Emperor's Divide", name = "AzirR", speed = 1300, delay = 0.2, range = 520, width = 600, collision = false, aoe = true, type = "linear", danger = 4, type2 = "cc"}
		},
		["Bard"] = {
			[_Q] = { displayname = "Cosmic Binding", name = "BardQ", objname = "BardQMissile", speed = 1100, delay = 0.25, range = 850, width = 108, collision = true, aoe = false, type = "linear", danger = 3, type2 = "cc"},
			[_R] = { displayname = "Tempered Fate", name = "BardR", objname = "BardR", speed = 2100, delay = 0.5, range = 3400, width = 350, collision = false, aoe = false, type = "circular", danger = 4, type2 = "cc"}
		},
		["Blitzcrank"] = {
			[_Q] = { displayname = "Rocket Grab", name = "RocketGrab", objname = "RocketGrabMissile", speed = 1800, delay = 0.250, range = 900, width = 70, collision = true, type = "linear", danger = 4, type2 = "cc"},
			[_R] = { displayname = "Static Field", name = "StaticField", speed = math.huge, delay = 0.25, range = 0, width = 500, collision = false, aoe = false, type = "circular", danger = 3}
		},
		["Brand"] = {
			[_Q] = { displayname = "Sear", name = "BrandBlaze", objname = "BrandBlazeMissile", speed = 1200, delay = 0.25, range = 1050, width = 80, collision = false, aoe = false, type = "linear", danger = 3, type2 = "cc"},
			[_W] = { displayname = "Pillar of Flame", name = "BrandFissure", speed = math.huge, delay = 0.625, range = 1050, width = 275, collision = false, aoe = false, type = "circular", danger = 2},
			[_E] = { displayname = "Conflagration", name = "Conflagration", range = 625, danger = 1},
			[_R] = { displayname = "Pyroclasm", name = "BrandWildfire", range = 750, danger = 4, type2 = "nuke"}
		},
		["Braum"] = {
			[_Q] = { displayname = "Winter's Bite", name = "BraumQ", objname = "BraumQMissile", speed = 1600, delay = 0.25, range = 1000, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[_R] = { displayname = "Glacial Fissure", name = "BraumR", objname = "braumrmissile", speed = 1250, delay = 0.5, range = 1250, width = 0, collision = false, aoe = false, type = "linear", danger = 5, type2 = "cc"}
		},
		["Caitlyn"] = {
			[_Q] = { displayname = "Piltover Peacemaker", name = "CaitlynPiltoverPeacemaker", objname = "CaitlynPiltoverPeacemaker", speed = 2200, delay = 0.625, range = 1300, width = 0, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "90 Caliber Net", name = "CaitlynEntrapment", objname = "CaitlynEntrapmentMissile",speed = 2000, delay = 0.400, range = 1000, width = 80, collision = false, aoe = false, type = "linear", danger = 1},
			[_R] = { displayname = "Ace in the Hole", name = "CaitlynAceintheHole", danger = 4, type2 = "nuke"}
		},
		["Cassiopeia"] = {
			[_Q] = { displayname = "Noxious Blast", name = "CassiopeiaNoxiousBlast", objname = "CassiopeiaNoxiousBlast", speed = math.huge, delay = 0.75, range = 850, width = 100, collision = false, aoe = true, type = "circular", danger = 2},
			[_W] = { displayname = "Miasma", name = "CassiopeiaMiasma", speed = 2500, delay = 0.5, range = 925, width = 90, collision = false, aoe = true, type = "circular", danger = 1},
			[_E] = { displayname = "Twin Fang", name = "CassiopeiaTwinFang", range = 700, danger = 2},
			[_R] = { displayname = "Petrifying Gaze", name = "CassiopeiaPetrifyingGaze", objname = "CassiopeiaPetrifyingGaze", speed = math.huge, delay = 0.5, range = 825, width = 410, collision = false, aoe = true, type = "cone", danger = 5, type2 = "cc"}
		},
		["Chogath"] = {
			[_Q] = { displayname = "Rupture", name = "Rupture", objname = "Rupture", speed = math.huge, delay = 0.25, range = 950, width = 300, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"},
			[_W] = { displayname = "Feral Scream", name = "FeralScream", speed = math.huge, delay = 0.5, range = 650, width = 275, collision = false, aoe = false, type = "linear", danger = 2},
			[_R] = { name = "", danger = 4, type2 = "nuke"}
		},
		["Corki"] = {
			[_Q] = { displayname = "Phosphorus Bomb", name = "PhosphorusBomb", objname = "PhosphorusBombMissile", speed = 700, delay = 0.4, range = 825, width = 250, collision = false, aoe = false, type = "circular", danger = 2},
			[_R] = { displayname = "Missile Barrage", name = "MissileBarrage", objname = "MissileBarrageMissile", speed = 2000, delay = 0.200, range = 1300, width = 60, collision = false, aoe = false, type = "linear",danger = 2},
			[-4]  = {displayname = "Missile Barrage Big", name = "MissileBarrageBig", objname = "MissileBarrageMissile2", speed = 2000, delay = 0.200, range = 1500, width = 80, collision = false, aoe = false, type = "linear", danger = 3},
		},
		["Darius"] = {
			[_Q] = { displayname = "Decimate", name = "DariusCleave", objname = "DariusCleave", speed = math.huge, delay = 0.75, range = 450, width = 450, type = "circular", danger = 3},
			[_W] = { displayname = "Crippling Strike", name = "DariusNoxianTacticsONH", range = 275, danger = 2},
			[_E] = { displayname = "Apprehend", name = "DariusAxeGrabCone", objname = "DariusAxeGrabCone", speed = math.huge, delay = 0.32, range = 570, width = 125, danger = 4, type = "cone"},
			[_R] = { displayname = "Noxian Guillotine", name = "DariusExecute", range = 460, danger = 4, type2 = "nuke"}
		},
		["Diana"] = {
			[_Q] = { displayname = "Crescent Strike", name = "DianaArc", objname = "DianaArcArc", speed = 1600, delay = 0.250, range = 835, width = 130, collision = false, aoe = false, type = "circular", danger = 3},
			[_W] = { displayname = "Pale Cascade", name = "PaleCascade", range = 250, danger = 1},
			[_E] = { displayname = "Moonfall", name = "DianaVortex", speed = math.huge, delay = 0.33, range = 0, width = 395, collision = false, aoe = false, type = "circular", danger = 3, type2 = "cc"},
			[_R] = { displayname = "Lunar Rush", name = "LunarRush", range = 825, danger = 4, type2 = "gc"}
		},
		["DrMundo"] = {
			[_Q] = { displayname = "Infected Cleaver", name = "InfectedCleaverMissile", objname = "InfectedCleaverMissile", speed = 2000, delay = 0.250, range = 1050, width = 75, collision = true, aoe = false, type = "linear", danger = 2}
		},
		["Draven"] = {
			[_E] = { displayname = "Stand Aside", name = "DravenDoubleShot", objname = "DravenDoubleShotMissile", speed = 1600, delay = 0.250, range = 1100, width = 130, collision = false, aoe = false, type = "linear", danger = 2, type2 = "cc"},
			[_R] = { displayname = "Whirling Death", name = "DravenRCast", objname = "DravenR", speed = 2000, delay = 0.5, range = 25000, width = 160, collision = false, aoe = false, type = "linear", danger = 4}
		},
		["Ekko"] = {
			[_Q] = { displayname = "Timewinder", name = "EkkoQ", objname = "ekkoqmis", speed = 1050, delay = 0.25, range = 925, width = 140, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { displayname = "Parallel Convergence", name = "EkkoW", objname = "EkkoW", speed = math.huge, delay = 3.25, range = 1600, width = 450, collision = false, aoe = true, type = "circular", danger = 3},
			[_E] = { displayname = "Phase Dive", name = "EkkoE", delay = 0.50, range = 350, danger = 1},
			[_R] = { displayname = "Chronobreak", name = "EkkoR", objname = "EkkoR", speed = math.huge, delay = 0.5, range = 0, width = 400, collision = false, aoe = true, type = "circular", danger = 4}
		},
		["Elise"] = {
			[_E] = { displayname = "Cocoon", name = "EliseHumanE", objname = "EliseHumanE", speed = 1450, delay = 0.250, range = 975, width = 70, collision = true, aoe = false, type = "linear", danger = 3, type2 = "cc"}
		},
		["Evelynn"] = {
			[_R] = { displayname = "Agony's Embrace", name = "EvelynnR", objname = "EvelynnR", speed = 1300, delay = 0.250, range = 650, width = 350, collision = false, aoe = true, type = "circular", danger = 2}
		},
		["Ezreal"] = {
			[_Q] = { displayname = "Mystic Shot", name = "EzrealMysticShot", objname = "EzrealMysticShotMissile", speed = 2000, delay = 0.25, range = 1200, width = 65, collision = true, aoe = false, type = "linear", danger = 2},
			[_W] = { displayname = "Essence Flux", name = "EzrealEssenceFlux", objname = "EzrealEssenceFluxMissile", speed = 1200, delay = 0.25, range = 900, width = 90, collision = false, aoe = false, type = "linear", danger = 1},
			--[_E] = { displayname = "Arcane Shift", name = "EzrealArcaneShift", range = 450},
			[_R] = { displayname = "Trueshot Barrage", name = "EzrealTrueshotBarrage", objname = "EzrealTrueshotBarrage", speed = 2000, delay = 1, range = 25000, width = 180, collision = false, aoe = false, type = "linear", danger = 3}
		},
		["Fiddlesticks"] = {
			[_Q] = { displayname = "Terrify", name = "Terrify", speed = math.huge, delay = 0.1, range = 575 , width = 65, collision = false, aoe = false, danger = 2, type2 = "cc"},
		},
		["Fiora"] = {
		},
		["Fizz"] = {
			[_R] = { displayname = "Chum the Waters", name = "FizzMarinerDoom", objname = "FizzMarinerDoomMissile", speed = 1350, delay = 0.250, range = 1150, width = 100, collision = false, aoe = false, type = "linear", danger = 3}
		},
		["Galio"] = {
			[_Q] = { displayname = "Resolute Smite", name = "GalioResoluteSmite", objname = "GalioResoluteSmite", speed = 1300, delay = 0.25, range = 900, width = 250, collision = false, aoe = true, type = "circular", danger = 3},
			[_E] = { displayname = "Righteous Gust", name = "GalioRighteousGust", speed = 1200, delay = 0.25, range = 1000, width = 200, collision = false, aoe = false, type = "linear", danger = 1}
		},
		["Gangplank"] = {
			[_Q] = { displayname = "Parrrley", name = "GangplankQWrapper", range = 900, danger = 2},
			--[_E] = { displayname = "Powder Keg", name = "GangplankE", speed = math.huge, delay = 0.25, range = 900, width = 250, collision = false, aoe = true, type = "circular", danger = },
			[_R] = { displayname = "Cannon Barrage", name = "GangplankR", speed = math.huge, delay = 0.25, range = 25000, width = 575, collision = false, aoe = true, type = "circular", danger = 1}
		},
		["Garen"] = {
			[_R] = { displayname = "Demacian Justice", name = "GarenR", range = 400, danger = 4, type2 = "nuke"},
		},
		["Gnar"] = {
			[_Q] = { displayname = "Boomerang Throw", name = "GnarQ", objname = "gnarqmissile", speed = 1225, delay = 0.125, range = 1200, width = 80, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Boomerang Throw Return", name = "GnarQReturn", objname = "GnarQMissileReturn", speed = 1225, delay = 0, range = 2500, width = 75, collision = false, aoe = false, type = "linear", danger = 2},
			[-2] = { displayname = "Boulder Toss", name = "GnarBigQ", speed = 2100, delay = 0,5, range = 2500, width = 90, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { displayname = "Wallop", name = "GnarBigW", objname = "GnarBigW", speed = math.huge, delay = 0.6, range = 600, width = 80, collision = false, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Hop", name = "GnarE", objname = "GnarE", speed = 900, delay = 0, range = 475, width = 150, collision = false, aoe = false, type = "circular", danger = 2, type2 = "gc"},
			[-5] = { displayname = "Crunch", name = "gnarbige", speed = 800, delay = 0, range = 475, width = 100, collision = false, aoe = false, type = "circular", danger = 2, type2 = "cc"},
			[_R] = { displayname = "GNAR!", name = "GnarR", speed = math.huge, delay = 250, range = 500, width = 500, collision = false, aoe = false, type = "circular", danger = 5, type2 = "cc"}
		},
		["Gragas"] = {
			[_Q] = { displayname = "Barrel Roll", name = "GragasQ", objname = "GragasQMissile", speed = 1000, delay = 0.250, range = 1000, width = 300, collision = false, aoe = true, type = "circular", danger = 1},
			[_E] = { displayname = "Body Slam", name = "GragasE", objname = "GragasE", speed = math.huge, delay = 0.250, range = 600, width = 50, collision = true, aoe = true, type = "circular", danger = 3, type2 = "gc"},
			[_R] = { displayname = "Explosive Cask", name = "GragasR", objname = "GragasRBoom", speed = 1000, delay = 0.250, range = 1050, width = 400, collision = false, aoe = true, type = "circular", danger = 4, type2 = "cc"}
		},
		["Graves"] = {
			[_Q] = { displayname = "End of the Line", name = "GravesQLineSpell", objname = "GravesQLineMis", speed = 1950, delay = 0.265, range = 750, width = 85, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { displayname = "Smoke Screen", name = "GravesSmokeGrenade", speed = 1650, delay = 0.300, range = 700, width = 250, collision = false, aoe = true, type = "circular", danger = 1},
			[_R] = { displayname = "Collateral Damage", name = "GravesChargeShot", objname = "GravesChargeShotShot", speed = 2100, delay = 0.219, range = 1000, width = 100, collision = false, aoe = false, type = "linear", danger = 4}
		},
		["Hecarim"] = {
			[_Q] = { displayname = "Rampage", name = "HecarimRapidSlash", speed = math.huge, delay = 0.250, range = 0, width = 350, collision = false, aoe = true, type = "circular", danger = 2},
			[_R] = { displayname = "Onslaught of Shadows", name = "HecarimUlt", speed = 1900, delay = 0.219, range = 1000, width = 200, collision = false, aoe = false, type = "linear", danger = 4, type2 = "gc"}
		},
		["Heimerdinger"] = {
		--	[_Q] = { displayname = "H-28G Evolution Turret", name = "HeimerdingerTurretEnergyBlast", speed = 1650, delay = 0.25, range = 1000, width = 50, collision = false, aoe = false, type = "linear", danger = 0},
		--	[-1] = { displayname = "H-28Q Apex Turret", name = "HeimerdingerTurretBigEnergyBlast", speed = 1650, delay = 0.25, range = 1000, width = 75, collision = false, aoe = false, type = "linear"},
			[_W] = { displayname = "Hextech Micro-Rockets", name = "Heimerdingerwm", objname = "HeimerdingerWAttack2", speed = 1800, delay = 0.25, range = 1500, width = 70, collision = true, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "CH-2 Electron Storm Grenade", name = "HeimerdingerE", objname = "HeimerdingerESpell", speed = 1200, delay = 0.25, range = 925, width = 100, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"}
		},
		["Illaoi"] = {
			[_Q] = { displayname = "Tentacle Smash", name = "IllaoiQ", objname = "", speed = math.huge, delay = 0.75, range = 850, width = 100, collision = false, aoe = true, type = "linear", danger = 2},
			[_E] = { displayname = "Test of Spirit", name = "IllaoiE", objname = "Illaoiemis", speed = 1900, delay = 0.25, range = 950, width = 50, collision = true, aoe = false, type = "linear", danger = 4},
			[_R] = { displayname = "Leap of Faith", name = "IllaoiR", objname = "", speed = math.huge, delay = 0.5, range = 0, width = 450, collision = false, aoe = true, type = "circular", danger = 5},
		},
		["Irelia"] = {
			[_E] = { displayname = "Irelia E", name = "IreliaEquilibriumStrike", danger = 3, type2 = "cc"},
			[_R] = { displayname = "Transcendent Blades", name = "IreliaTranscendentBlades", objname = "IreliaTranscendentBlades", speed = 1700, delay = 0.250, range = 1200, width = 25, collision = false, aoe = false, type = "linear", danger = 1}
		},
		["Janna"] = {
			[_Q] = { displayname = "Howling Gale", name = "HowlingGale", objname = "HowlingGaleSpell", speed = 1500, delay = 0.250, range = 1700, width = 150, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["JarvanIV"] = {
			[_Q] = { displayname = "Dragon Strike", name = "JarvanIVDragonStrike", speed = 1400, delay = 0.25, range = 770, width = 70, collision = false, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Demacian Standard", name = "JarvanIVDemacianStandard", objname = "JarvanIVDemacianStandard", speed = 1450, delay = 0.25, range = 850, width = 175, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Jax"] = {
			[_E] = { displayname = "Counter Strike", name = "", speed = math.huge, delay = 1.05, range = 0, width = 375, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"}
		},
		["Jayce"] = {
			[_Q] = { displayname = "Shock Blast", name = "jayceshockblast", objname = "JayceShockBlastMis", speed = 1450, delay = 0.15, range = 1750, width = 70, collision = true, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Shock Blast Acceleration", name = "JayceQAccel", objname = "JayceShockBlastWallMis", speed = 2350, delay = 0.15, range = 1300, width = 70, collision = true, aoe = false, type = "linear", danger = 3}
		},
		["Jhin"] = {
			[_W] = { displayname = "Deadly Flourish", name = "JhinW", objname = "JhinWMissile", speed = 5000, delay = 0.75, range = 2500, width = 40, collision = true, aoe = false, type = "linear", danger = 2, type2 = "cc"},
			[_R] = { displayname = "Curtain Call", name = "JhinR", objname = "JhinRShotMis", speed = 5000, delay = 0.25, range = 3000, width = 80, collision = true, aoe = false, type = "linear", danger = 3},
		},
		["Jinx"] = {
			[_W] = { displayname = "Zap!", name = "JinxW", objname = "JinxWMissile", speed = 3000, delay = 0.600, range = 1400, width = 60, collision = true, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Flame Chompers!", name = "JinxE", speed = 887, delay = 0.500, range = 830, width = 0, collision = false, aoe = true, type = "circular", danger = 3},
			[_R] = { displayname = "Super Mega Death Rocket!", name = "JinxR", objname = "JinxR", speed = 1700, delay = 0.600, range = 20000, width = 140, collision = false, aoe = true, type = "linear", danger = 4, type2 = "nuke"}
		},
		["Kalista"] = {
			[_Q] = { displayname = "Pierce", name = "KalistaMysticShot", objname = "kalistamysticshotmis", speed = 1700, delay = 0.25, range = 1150, width = 40, collision = true, aoe = false, type = "linear", danger = 2},
		},
		["Karma"] = {
			[_Q] = { displayname = "Inner Flame", name = "KarmaQ", objname = "KarmaQMissile", speed = 1700, delay = 0.25, range = 1050, width = 60, collision = true, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Soulflare", name = "KarmaQMantra", objname = "KarmaQMissileMantra", speed = 1700, delay = 0.25, range = 950, width = 80, collision = true, aoe = false, type = "linear", danger = 3}
		},
		["Karthus"] = {
			[_Q] = { displayname = "Lay Waste", name = "KarthusLayWaste", speed = math.huge, delay = 0.775, range = 875, width = 160, collision = false, aoe = true, type = "circular", danger = 2},
			[_W] = { displayname = "Wall of Pain", name = "KarthusWallOfPain", speed = math.huge, delay = 0.25, range = 1000, width = 160, collision = false, aoe = true, type = "circular", danger = 1},
			[_R] = { displayname = "Requiem", name = "KarthusFallenOne", range = math.huge, delay = 3, danger = 5, type2 = "nuke"}
		},
		["Kassadin"] = {
			[_E] = { displayname = "ForcePulse", name = "ForcePulse", speed = 2200, delay = 0.25, range = 650, width = 80, collision = false, aoe = false, type = "cone", danger = 3},
			[_R] = { displayname = "Riftwalk", name = "RiftWalk", objname = "RiftWalk", speed = math.huge, delay = 0.5, range = 500, width = 150, collision = false, aoe = true, type = "circular", danger = 2}
		},
		["Katarina"] = {
			[_Q] = { name ="", danger = 2},
		},
		["Kayle"] = {
			[_Q] = { name ="", danger = 3},
		},
		["Kennen"] = {
			[_Q] = { displayname = "Thundering Shuriken", name = "KennenShurikenHurlMissile1", speed = 1700, delay = 0.180, range = 1050, width = 70, collision = true, aoe = false, type = "linear", danger = 3}
		},
		["KhaZix"] = {
			[_W] = { displayname = "Void Spike", name = "KhazixW", objname = "KhazixWMissile", speed = 1700, delay = 0.25, range = 1025, width = 70, collision = true, aoe = false, type = "linear", danger = 2},
			[-7] = { displayname = "Evolved Void Spike", name = "khazixwlong", objname = "KhazixWMissile", speed = 1700, delay = 0.25, range = 1025, width = 70, collision = true, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "Leap", name = "KhazixE", objname = "KhazixE", speed = 400, delay = 0.25, range = 600, width = 325, collision = false, aoe = true, type = "circular", danger = 2, type2 = "gc"},
			[-5] = { displayname = "Evolved Leap", name = "KhazixE", objname = "KhazixE", speed = 400, delay = 0.25, range = 600, width = 325, collision = false, aoe = true, type = "circular", danger = 2, type2 = "cc"}
		},
		["KogMaw"] = {
			[_Q] = { displayname = "Caustic Spittle", name = "KogMawQ", objname = "KogMawQ", speed = 1600, delay = 0.25, range = 975, width = 80, type = "linear", danger = 2},
			[_E] = { displayname = "Void Ooze", name = "KogMawVoidOoze", objname = "KogMawVoidOozeMissile", speed = 1200, delay = 0.25, range = 1200, width = 120, collision = false, aoe = false, type = "linear", danger = 1},
			[_R] = { displayname = "Living Artillery", name = "KogMawLivingArtillery", objname = "KogMawLivingArtillery", speed = math.huge, delay = 1.1, range = 2200, width = 250, collision = false, aoe = true, type = "circular", danger = 3}
		},
		["LeBlanc"] = {
			[_Q] = { displayname = "Sigil of Malice", range = 700, danger = 3},
			[_W] = { displayname = "Distortion", name = "LeblancSlide", objname = "LeblancSlide", speed = 1300, delay = 0.250, range = 600, width = 250, collision = false, aoe = false, type = "circular", danger = 2, type2 = "gc"},
			[_E] = { displayname = "Ethereal Chains", name = "LeblancSoulShackle", objname = "LeblancSoulShackle", speed = 1300, delay = 0.250, range = 950, width = 55, collision = true, aoe = false, type = "linear", danger = 3},
			[_R] = { displayname = "Mimic", range = 700, danger = 3}
		},
		["LeeSin"] = {
			[_Q] = { displayname = "Sonic Wave", name = "BlindMonkQOne", objname = "BlindMonkQOne", speed = 1750, delay = 0.25, range = 1000, width = 70, collision = true, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Tempest", name = "BlindMonkEOne", speed = math.huge, delay = 0.25, range = 0, width = 450, collision = false, aoe = false, type = "circular", danger = 2},
			[_R] = { displayname = "Intervention", name = "Dragon's Rage", speed = 2000, delay = 0.25, range = 375, width = 150, collision = false, aoe = false, type = "linear", danger = 4, type2 = "nuke"}
		},
		["Leona"] = {
			[_E] = { displayname = "Zenith Blade", name = "LeonaZenithBlade", objname = "LeonaZenithBladeMissile", speed = 2000, delay = 0.250, range = 875, width = 80, collision = false, aoe = false, type = "linear", danger = 3},
			[_R] = { displayname = "Solar Flare", name = "LeonaSolarFlare", objname = "LeonaSolarFlare", speed = 2000, delay = 0.250, range = 1200, width = 300, collision = false, aoe = true, type = "circular", danger = 4, type2 = "cc"}
		},
		["Lissandra"] = {
			[_Q] = { displayname = "Ice Shard", name = "LissandraQ", objname = "LissandraQMissile", speed = 2200, delay = 0.25, range = 700, width = 75, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Ice Shard Shattered", name = "LissandraQShards", objname = "lissandraqshards", speed = 2200, delay = 0.25, range = 700, width = 90, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "Glacial Path", name = "LissandraE", objname = "LissandraEMissile", speed = 850, delay = 0.25, range = 1025, width = 125, collision = false, aoe = false, type = "linear", danger = 2},
		},
		["Lucian"] = {
			[_Q] = { displayname = "Piercing Light", name = "LucianQ", objname = "LucianQ", speed = math.huge, delay = 0.5, range = 1300, width = 65, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { displayname = "Ardent Blaze", name = "LucianW", objname = "lucianwmissile", speed = 800, delay = 0.3, range = 1000, width = 80, collision = true, aoe = false, type = "linear", danger = 1},
			[_R] = { displayname = "The Culling", name = "LucianRMis", objname = "lucianrmissileoffhand", speed = 2800, delay = 0.5, range = 1400, width = 110, collision = true, aoe = false, type = "linear", danger = 2},
			[-6] = { displayname = "The Culling 2", name = "LucianRMis", objname = "lucianrmissile", speed = 2800, delay = 0.5, range = 1400, width = 110, collision = true, aoe = false, type = "linear", danger = 2}
		},
		["Lulu"] = {
			[_Q] = { displayname = "Glitterlance", name = "LuluQ", objname = "LuluQMissile", speed = 1500, delay = 0.25, range = 950, width = 60, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { displayname = "Glitterlance (Pix)", name = "LuluQPix", objname = "LuluQMissileTwo", speed = 1450, delay = 0.25, range = 950, width = 60, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Lux"] = {
			[_Q] = { displayname = "Light Binding", name = "LuxLightBinding", objname = "LuxLightBindingMis", speed = 1200, delay = 0.25, range = 1300, width = 130, collision = true, type = "linear", danger = 3, type2 = "cc"},
			[_E] = { displayname = "Lucent Singularity", name = "LuxLightStrikeKugel", objname = "LuxLightStrikeKugel", speed = 1300, delay = 0.25, range = 1100, width = 345, collision = false, type = "circular", danger = 4},
			[_R] = { displayname = "Final Spark", name = "LuxMaliceCannon", objname = "LuxMaliceCannon", speed = math.huge, delay = 1, range = 3340, width = 250, collision = false, type = "linear", danger = 4, type2 = "nuke"}
		},
		["Malphite"] = {
			[_R] = { displayname = "Unstoppable Force", name = "UFSlash", objname = "UFSlash", speed = 1600, delay = 0.5, range = 900, width = 500, collision = false, aoe = true, type = "circular", danger = 5, type2 = "cc"}
		},
		["Malzahar"] = {
			[_Q] = { displayname = "Call of the Void", name = "AlZaharCalloftheVoid", objname = "AlZaharCalloftheVoid", speed = math.huge, delay = 1, range = 900, width = 100, collision = false, aoe = false, type = "linear", danger = 3},
			--[_W] = { displayname = "Null Zone", name = "AlZaharNullZone", speed = math.huge, delay = 0.5, range = 800, width = 250, collision = false, aoe = false, type = "circular", danger = 1},
			[_R] = { displayname = "Nether Grasp", name = "AlZaharNetherGrasp", speed = math.huge, delay = 0, range = 700, danger = 5},

		},
		["Maokai"] = {
			[_W] = { name = "", speed = 2000, delay = .1, danger = 3, type2 = "5"},
			[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 600, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { displayname = "Sapling Toss", name = "", speed = 1500, delay = 0.25, range = 1100, width = 175, collision = false, aoe = false, type = "circular", danger = 2},
		},
		["MissFortune"] = {
			[_E] = { name = "MissFortuneScattershot", speed = math.huge, delay = 3.25, range = 800, width = 400, collision = false, aoe = true, type = "circular", danger = 1},
			[_R] = { displayname = "Bullet Time", name = "MissFortuneBulletTime", speed = math.huge, delay = 0.25, range = 1400, width = 700, collision = false, aoe = true, type = "cone", danger = 2}
		},
		["Mordekaiser"] = {
			[_E] = { name = "", speed = math.huge, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "cone", danger = 3}
		},
		["Morgana"] = {
			[_Q] = { displayname = "Dark Binding", name = "DarkBindingMissile", objname = "DarkBindingMissile", speed = 1200, delay = 0.250, range = 1300, width = 80, collision = true, aoe = false, type = "linear", danger = 3, type2 = "cc"}
		},
		["Nami"] = {
			[_Q] = { displayname = "Aqua Prison", name = "NamiQ", objname = "namiqmissile", speed = math.huge, delay = 0.95, range = 1625, width = 150, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"},
			[_R] = { name = "NamiR", objname = "NamiRMissile", speed = 850, delay = 0.5, range = 2750, width = 260, collision = false, aoe = true, type = "linear", danger = 4, type2 = "cc"}
		},
		["Nasus"] = {
			[_W] = { displayname = "Wither", name = "", delay = 0.2, danger = 3, type2 = "cc"},
			[_E] = { name = "", speed = math.huge, delay = 0.25, range = 450, width = 250, collision = false, aoe = true, type = "circular", danger = 1}
		},
		["Nautilus"] = {
			[_Q] = { name = "NautilusAnchorDrag", objname = "NautilusAnchorDragMissile", speed = 2000, delay = 0.250, range = 1080, width = 80, collision = true, aoe = false, type = "linear", danger = 3, type2 = "cc"},
			[_R] = { name = "", speed = 1500, delay = .2, danger = 4, type2 = "cc"},
		},
		["Nidalee"] = {
			[_Q] = { displayname = "Javelin Toss", name = "JavelinToss", objname = "JavelinToss", speed = 1300, delay = 0.25, range = 1500, width = 40, collision = true, type = "linear", danger = 3}
		},
		["Nocturne"] = {
			[_Q] = { displayname = "Duskbringer", name = "NocturneDuskbringer", objname = "NocturneDuskbringer", speed = 1400, delay = 0.250, range = 1125, width = 80, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Olaf"] = {
			[_Q] = { name = "OlafAxeThrowCast", objname = "olafaxethrow", speed = 1600, delay = 0.25, range = 1000, width = 90, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { name = "", delay = .1, danger = 2},
		},
		["Orianna"] = {
			[_Q] = { name = "OriannasQ", objname = "orianaizuna", speed = 1200, delay = 0, range = 1500, width = 80, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { name = "OriannaQend", speed = 1200, delay = 0, range = 1500, width = 80, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { name = "OrianaDissonanceCommand", objname = "OrianaDissonanceCommand", speed = math.huge, delay = 0.25, range = 0, width = 255, collision = false, aoe = true, type = "circular", danger = 2},
			[_R] = { name = "OrianaDetonateCommand", objname = "OrianaDetonateCommand", speed = math.huge, delay = 0.250, range = 0, width = 410, collision = false, aoe = true, type = "circular", danger = 5, type2 = "cc"}
		},
		["Pantheon"] = {
			[_Q] = { name = "", speed = 1500, delay = .15, danger = 2},
			[_E] = { name = "", speed = math.huge, delay = 0.250, range = 400, width = 100, collision = false, aoe = true, type = "cone", danger = 2},
		},
		["Quinn"] = {
			[_Q] = { name = "QuinnQ", objname = "QuinnQ", speed = 1550, delay = 0.25, range = 1050, width = 80, collision = true, aoe = true, type = "linear", danger = 3}
		},
		["RekSai"] = {
			[_Q] = { name = "reksaiqburrowed", objname = "RekSaiQBurrowedMis", speed = 1550, delay = 0.25, range = 1050, width = 180, collision = true, aoe = false, type = "linear", danger = 1}
		},
		["Renekton"] = {
			[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 450, collision = false, aoe = true, type = "circular", danger = 2},
			[_E] = { name = "", speed = 1225, delay = 0.25, range = 450, width = 150, collision = false, aoe = false, type = "linear", danger = 2, type2 = "gc"}
		},
		["Rengar"] = {
			[_W] = { name = "RengarW", speed = math.huge, delay = 0.25, range = 0, width = 490, collision = false, aoe = true, type = "circular", danger = 1},
			[_E] = { name = "RengarE", objname = "RengarEFinal", speed = 1225, delay = 0.25, range = 1000, width = 80, collision = true, aoe = false, type = "linear", danger = 3},
		},
		["Riven"] = {
			[_Q] = { name = "RivenTriCleave", speed = math.huge, delay = 0.250, range = 310, width = 225, collision = false, aoe = true, type = "circular", danger = 2},
			[_W] = { name = "RivenMartyr", speed = math.huge, delay = 0.250, range = 0, width = 265, collision = false, aoe = true, type = "circular", danger = 3},
			[_R] = { name = "rivenizunablade", objname = "RivenLightsaberMissile", speed = 2200, delay = 0.5, range = 1100, width = 200, collision = false, aoe = false, type = "cone", ranger = 5, type2 = "nuke"}
		},
		["Rumble"] = {
			[_Q] = { name = "RumbleFlameThrower", speed = math.huge, delay = 0.250, range = 600, width = 500, collision = false, aoe = false, type = "cone", danger = 1},
			[_E] = { name = "RumbleGrenade", objname = "RumbleGrenade", speed = 1200, delay = 0.250, range = 850, width = 90, collision = true, aoe = false, type = "linear", danger = 2},
			[_R] = { name = "RumbleCarpetBombM", objname = "RumbleCarpetBombMissile", speed = 1200, delay = 0.250, range = 1700, width = 90, collision = false, aoe = false, type = "linear", danger = 3}
		},
		["Ryze"] = {
			[_Q] = { name = "RyzeQ", objname = "RyzeQ", speed = 1700, delay = 0.25, range = 900, width = 50, collision = true, aoe = false, type = "linear", danger = 2},
			[-1] = { name = "ryzerq", objname = "ryzerq", speed = 1700, delay = 0.25, range = 900, width = 50, collision = true, aoe = false, type = "linear", danger = 2}
		},
		["Sejuani"] = {
			[_Q] = { name = "SejuaniArcticAssault", speed = 1600, delay = 0, range = 900, width = 70, collision = true, aoe = false, type = "linear", danger = 3, type2 = "gc"},
			[_R] = { name = "SejuaniGlacialPrisonStart", objname = "sejuaniglacialprison", speed = 1600, delay = 0.25, range = 1200, width = 110, collision = false, aoe = false, type = "linear", danger = 5}
		},
		["Shen"] = {
			[_E] = { name = "ShenShadowDash", objname = "ShenShadowDash", speed = 1200, delay = 0.25, range = 600, width = 40, collision = false, aoe = false, type = "linear", danger = 4, type2 = "gc"}
		},
		["Shyvana"] = {
			[_E] = { name = "ShyvanaFireball", objname = "ShyvanaFireballMissile", speed = 1500, delay = 0.250, range = 925, width = 60, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Sivir"] = {
			[_Q] = { name = "SivirQ", objname = "SivirQMissile", speed = 1330, delay = 0.250, range = 1075, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { name = "SivirQReturn", objname = "SivirQMissileReturn", speed = 1330, delay = 0.250, range = 1075, width = 0, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Skarner"] = {
			[_E] = { name = "SkarnerFracture", objname = "SkarnerFractureMissile", speed = 1200, delay = 0.600, range = 350, width = 60, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Sona"] = {
			[_R] = { displayname = "Cresendo", name = "SonaR", objname = "SonaR", speed = 2400, delay = 0.5, range = 900, width = 160, collision = false, aoe = false, type = "linear", danger = 5, type2 = "cc"}
		},
		["Soraka"] = {
			[_Q] = { displayname = "Starcall", name = "SorakaQ", speed = 1000, delay = 0.25, range = 900, width = 260, collision = false, aoe = true, type = "circular", danger = 2},
			[_E] = { name = "SorakaE", speed = math.huge, delay = 1.75, range = 900, width = 310, collision = false, aoe = true, type = "circular", danger = 1}
		},
		["Swain"] = {
			[_W] = { name = "SwainShadowGrasp", objname = "SwainShadowGrasp", speed = math.huge, delay = 0.850, range = 900, width = 125, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"}
		},
		["Syndra"] = {
			[_Q] = { name = "SyndraQ", objname = "SyndraQ", speed = math.huge, delay = 0.67, range = 790, width = 125, collision = false, aoe = true, type = "circular", danger = 2},
			[_W] = { name = "syndrawcast", objname = "syndrawcast" ,speed = math.huge, delay = 0.8, range = 925, width = 190, collision = false, aoe = true, type = "circular", danger = 2},
			[_E] = { name = "SyndraE", objname = "SyndraE", speed = 2500, delay = 0.25, range = 730, width = 45, collision = false, aoe = true, type = "cone", danger = 3, type2 = "cc"},
			[_R] = { danger = 5, type2 = "nuke"},
		},
		["Talon"] = {
			[_W] = { name = "TalonRake", objname = "talonrakemissileone", speed = 900, delay = 0.25, range = 600, width = 200, collision = false, aoe = false, type = "cone", danger = 3},
			[_R] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 650, collision = false, aoe = false, type = "circular", danger = 4, type2 = "nuke"}
		},
		["Taric"] = {
			[_E] = { name = "TaricE", speed = math.huge, delay = 1, range = 650, width = 300, collision = false, aoe = false, type = "circular", danger = 3}
		},
		["Teemo"] = {
			[_Q] = { name = "", danger = 3}
		},
		["Thresh"] = {
			[_Q] = { displayname = "Death Sentence", name = "ThreshQ", objname = "ThreshQMissile", speed = 1825, delay = 0.25, range = 1050, width = 70, collision = true, aoe = false, type = "linear", danger = 3},
			[_E] = { displayname = "Flay", name = "ThreshE", objname = "ThreshEMissile1", speed = 2000, delay = 0.25, range = 450, width = 110, collision = false, aoe = false, type = "linear", danger = 3}
		},
		["TahmKench"] = {
			[_Q] = { displayname = "Tongue Lash", name = "TahmKenchQ", objname = "TahmkenchQMissile", speed = 2000, delay = 0.25, range = 951, width = 70, collision = true, aoe = false, type = "linear", danger = 3},
		},
		["Tristana"] = {
			[_W] = { displayname = "Rocket Jump", name = "RocketJump", objname = "RocketJump", speed = 2100, delay = 0.25, range = 900, width = 125, collision = false, aoe = false, type = "circular", danger = 2}
		},
		["Trundle"] = {
			[_R] = { name = "", danger = 3},
		},
		["Tryndamere"] = {
			[_E] = { name = "slashCast", objname = "slashCast", speed = 1500, delay = 0.250, range = 650, width = 160, collision = false, aoe = false, type = "linear", danger = 2, type2 = "gc"}
		},
		["TwistedFate"] = {
			[_Q] = { displayname = "WildCards", name = "WildCards", objname = "SealFateMissile", speed = 1500, delay = 0.250, range = 1200, width = 80, collision = false, aoe = false, type = "linear"},
			[_W] = { displayname = "Gold Card", name = "goldcardpreattack", danger = 3, type2 = "cc"}
		},
		["Twitch"] = {
			[_W] = { name = "TwitchVenomCask", objname = "TwitchVenomCaskMissile", speed = 1750, delay = 0.250, range = 950, width = 275, collision = false, aoe = true, type = "circular", danger = 2}
		},
		["Urgot"] = {
			[_Q] = { name = "UrgotHeatseekingLineMissile", objname = "UrgotHeatseekingLineMissile", speed = 1575, delay = 0.175, range = 1000, width = 80, collision = true, aoe = false, type = "linear", danger = 2},
			[_E] = { name = "UrgotPlasmaGrenade", objname = "UrgotPlasmaGrenadeBoom", speed = 1750, delay = 0.25, range = 890, width = 200, collision = false, aoe = true, type = "circular", danger = 3},
			[-9] = { name = "UrgotHeatseekingHomeMissile", speed = 1575, delay = 0.175, range = 1200, width = 80, collision = false, aoe = false, danger = 2},
		},
		["Varus"] = {
			[_Q] = { displayname = "Piercing Arrow", name = "VarusQMissilee", objname = "VarusQMissile", speed = 1500, delay = 0.5, range = 1475, width = 100, collision = false, aoe = false, type = "linear", danger = 3},
			[_E] = { name = "VarusE", objname = "VarusE", speed = 1750, delay = 0.25, range = 925, width = 235, collision = false, aoe = true, type = "circular", danger = 2},
			[_R] = { displayname = "Chains of Corruption" ,name = "VarusR", objname = "VarusRMissile", speed = 1200, delay = 0.5, range = 800, width = 100, collision = false, aoe = false, type = "linear", danger = 4, type2 = "cc"}
		},
		["Vayne"] = {
		},
		["Veigar"] = {
			[_Q] = { displayname = "Baleful Strike", name = "VeigarBalefulStrike", objname = "VeigarBalefulStrikeMis", speed = 1200, delay = 0.25, range = 900, width = 70, collision = true, aoe = false, type = "linear"},
			[_W] = { displayname = "Dark Matter",name = "VeigarDarkMatter", speed = math.huge, delay = 1.2, range = 900, width = 225, collision = false, aoe = false, type = "circular"},
			[_E] = { displayname = "Event Horizon",name = "VeigarEvenHorizon", speed = math.huge, delay = 0.75, range = 725, width = 275, collision = false, aoe = false, type = "circular"},
			[_R] = { displayname = "Primordial Burst",name = "", danger = 5, type2 = "nuke"}
		},
		["Velkoz"] = {
			[_Q] = { name = "VelKozQ", objname = "VelkozQMissile", speed = 1300, delay = 0.25, range = 1100, width = 50, collision = true, aoe = false, type = "linear", danger = 2},
			[-1] = { name = "VelkozQSplit", objname = "VelkozQMissileSplit", speed = 2100, delay = 0.25, range = 1100, width = 55, collision = true, aoe = false, type = "linear", danger = 2},
			[_W] = { name = "VelKozW", objname = "VelkozWMissile", speed = 1700, delay = 0.064, range = 1050, width = 80, collision = false, aoe = false, type = "linear", danger = 2},
			[_E] = { name = "VelKozE", objname = "VelkozEMissile", speed = 1500, delay = 0.333, range = 850, width = 225, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"},
			[_R] = { name = "VelKozR", speed = math.huge, delay = 0.333, range = 1550, width = 50, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Vi"] = {
			[_Q] = { name = "Vi-q", objname = "ViQMissile", speed = 1500, delay = 0.25, range = 715, width = 55, collision = false, aoe = false, type = "linear", danger = 3}
		},
		["Viktor"] = {
			[_W] = { name = "ViktorGravitonField", speed = 750, delay = 0.6, range = 700, width = 125, collision = false, aoe = true, type = "circular", danger = 1},
			[_E] = { name = "Laser", objname = "ViktorDeathRayMissile", speed = 1200, delay = 0.25, range = 1200, width = 0, collision = false, aoe = false, type = "linear", danger = 2},
			[_R] = { name = "ViktorChaosStorm", speed = 1000, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "circular", danger = 2}
		},
		["Vladimir"] = {
			[_R] = { displayname = "Hemoplague" ,name = "VladimirR", speed = math.huge, delay = 0.25, range = 700, width = 175, collision = false, aoe = true, type = "circular", danger = 4}
		},
		["Xerath"] = {
			[_Q] = { name = "xeratharcanopulse2", objname = "xeratharcanopulse2", speed = math.huge, delay = 1.75, range = 750, width = 100, collision = false, aoe = false, type = "linear", danger = 2},
			[_W] = { name = "XerathArcaneBarrage2", objname = "XerathArcaneBarrage2", speed = math.huge, delay = 0.25, range = 1100, width = 100, collision = false, aoe = true, type = "circular", danger = 3},
			[_E] = { name = "XerathMageSpear", objname = "XerathMageSpearMissile", speed = 1600, delay = 0.25, range = 1050, width = 70, collision = true, aoe = false, type = "linear", danger = 4, type2 = "cc"},
			[_R] = { name = "xerathrmissilewrapper", objname = "xerathrmissilewrapper", speed = math.huge, delay = 0.75, range = 3200, width = 245, collision = false, aoe = true, type = "circular", danger = 3}
		},
		["XinZhao"] = {
			[_R] = { name = "XenZhaoParry", speed = math.huge, delay = 0.25, range = 275, width = 375, collision = false, aoe = true, type = "circular", danger = 3, type2 = "cc"}
		},
		["Yasuo"] = {
			[_Q] = { name = "yasuoq", objname = "yasuoq", speed = math.huge, delay = 0.25, range = 475, width = 40, collision = false, aoe = false, type = "linear", danger = 2},
			[-1] = { name = "yasuoq2", objname = "yasuoq2", speed = math.huge, delay = 0.25, range = 475, width = 40, collision = false, aoe = false, type = "linear", danger = 2},
			[-2] = { name = "yasuoq3w", objname = "yasuoq3w", range = 1200, speed = 1200, delay = 0.125, width = 65, collision = false, aoe = false, type = "linear", danger = 3, type2 = "cc"}
		},
		["Yorick"] = {
			[_W] = { name = "YorickDecayed", speed = math.huge, delay = 0.25, range = 600, width = 175, collision = false, aoe = true, type = "circular", danger = 2},
		},
		["Zac"] = {
			[_Q] = { name = "ZacQ", objname = "ZacQ", speed = 2500, delay = 0.110, range = 500, width = 110, collision = false, aoe = false, type = "linear", danger = 2}
		},
		["Zed"] = {
			[_Q] = { name = "ZedQ", objname = "ZedQMissile", speed = 1700, delay = 0.25, range = 900, width = 50, collision = false, aoe = false, type = "linear", danger = 3},
			[_E] = { name = "ZedE", speed = math.huge, delay = 0.25, range = 0, width = 300, collision = false, aoe = true, type = "circular", danger = 2}
		},
		["Ziggs"] = {
			[_Q] = { name = "ZiggsQ", objname = "ZiggsQSpell", speed = 1750, delay = 0.25, range = 1400, width = 155, collision = true, aoe = false, type = "linear", danger = 3},
			[_W] = { name = "ZiggsW", objname = "ZiggsW", speed = 1800, delay = 0.25, range = 970, width = 275, collision = false, aoe = true, type = "circular", danger = 2},
			[_E] = { name = "ZiggsE", objname = "ZiggsE", speed = 1750, delay = 0.12, range = 900, width = 350, collision = false, aoe = true, type = "circular", danger = 1},
			[_R] = { name = "ZiggsR", objname = "ZiggsR", speed = 1750, delay = 0.14, range = 5300, width = 525, collision = false, aoe = true, type = "circular", danger = 4, type2 = "nuke"}
		},
		["Zilean"] = {
			[_Q] = { displayname = "Time Bomb", name = "ZileanQ", objname = "ZileanQMissile", speed = math.huge, delay = 0.5, range = 900, width = 150, collision = false, aoe = true, type = "circular", danger = 3}
		},
		["Zyra"] = {
			--[-8] = { name = "zyrapassivedeathmanager", objname = "zyrapassivedeathmanager", speed = 1900, delay = 0.5, range = 1475, width = 70, collision = false, aoe = false, type = "linear", danger = 3},
			[_Q] = { name = "ZyraQFissure", objname = "ZyraQFissure", speed = math.huge, delay = 0.7, range = 800, width = 85, collision = false, aoe = true, type = "circular", danger = 2},
			[_E] = { name = "ZyraGraspingRoots", objname = "ZyraGraspingRoots", speed = 1150, delay = 0.25, range = 1100, width = 200, collision = false, aoe = true, type = "linear", danger = 3, type2 = "cc"},
			[_R] = { name = "ZyraBrambleZone", speed = math.huge, delay = 1, range = 1100, width = 500, collision=false, aoe = true, type = "circular", danger = 4, type2 = "nuke"}
		}
	}
	M.SB:Menu("Spells", "Spells")

		DelayAction(function()
        for _,k in pairs(GetEnemyHeroes()) do
		 if skills[GetObjectName(k)] then
          for m,p in pairs(skills[GetObjectName(k)]) do
			if p.name == "" and GetCastName(k,m) then p.name = GetCastName(k,m) end
			if not p.type then p.type = "target" end
            if p and p.name ~= "" and p.type then
			  if not M.SB.Spells[GetObjectName(k)] then M.SB.Spells:Menu(GetObjectName(k), GetObjectName(k)) end
              M.SB.Spells[GetObjectName(k)]:Boolean(m, (str[m] or "?").. " - "..(p.displayname or p.name or "?"), true)
            end
		   end
          end
        end
	Callback.Add("ProcessSpell", function(unit, spell) Kench_SpellCast(unit, spell) end)
    end, .001)
end
function Kench_SpellCast(unit, spell)
	if M.SB.W:Value() and M.SB.Wt:Value() and Ready(_W) then
		for i =0,3 do 
			if unit and unit.team ~= myHero.team and spell.target ~= myHero and GetObjectType(unit) ~= Obj_AI_Minion and GetCastName(unit,i) == spell.name and spell.target ~= nil and GetCastName(myHero, _W) == "TahmKenchW" and spell.target.team == myHero.team and spell.target ~= Obj_AI_Minion and spell.target ~= nil and spell.target ~= myHero then
				local caster = ClosestEnemy(spell.startPos)
				local str = {[_Q] = "Q", [_W] = "W", [_E]= "E", [_R]="R"}
				if caster.valid and (getdmg(str[i],spell.target,caster,GetCastLevel(caster, i))+150 > spell.target.health or getdmg(str[i],spell.target,caster,GetCastLevel(caster, i))+150 > spell.target.maxHealth/2) and GetDistance(myHero, spell.target) < 400 then
					CastTargetSpell(spell.target, _W)
				end
			end
		end
		local attacks = {"caitlynheadshotmissile", "frostarrow", "garenslash2", "kennenmegaproc", "masteryidoublestrike", "quinnwenhanced", "renektonexecute", "renektonsuperexecute", "rengarnewpassivebuffdash", "trundleq", "xenzhaothrust", "xenzhaothrust2", "xenzhaothrust3", "viktorqbuff", "lucianpassiveshot"} 
        if unit and unit.team ~= myHero.team and spell.target ~= myHero and GetObjectType(unit) ~= Obj_AI_Minion and spell.name:lower():find("attack")  and spell.target ~= nil and GetCastName(myHero, _W) == "TahmKenchW" and spell.target.team == myHero.team and spell.target ~= Obj_AI_Minion then
			if unit.totalDamage+120 > spell.target.health and GetDistance(myHero, spell.target) < 400 then
				CastTargetSpell(spell.target, _W) 
			end
		end
	end
	if M.SB.W:Value() and M.SB.Ws:Value() and Ready(_W) then
		for f =0,3 do 
			if skills[GetObjectName(unit)] and GetTeam(unit) == MINION_ENEMY and GetObjectType(unit) ~= Obj_AI_Minion then
				for d,i in pairs(skills[GetObjectName(unit)]) do
					if M.SB.Spells[GetObjectName(unit)] and M.SB.Spells[GetObjectName(unit)][d] and M.SB.Spells[GetObjectName(unit)][d]:Value() and ((i.name and i.name:lower() == spell.name:lower()) or (i.name == "" and d >= 0 and GetCastName(unit,d) == spell.name)) and GetCastName(unit, f) == i.name then
						local str = {[_Q] = "Q", [_W] = "W", [_E]= "E", [_R]="R"}
						local ally = ClosestAlly(spell.endPos)
						local caster = ClosestEnemy(spell.startPos)
						if GetCastName(myHero, _W) == "TahmKenchW" and ally ~= nil then
							if i.type and (i.type == "linear" or i.type == "cone") and (getdmg(str[f],ally,caster,GetCastLevel(caster,f))+150 > ally.health or getdmg(str[f],ally,caster,GetCastLevel(caster, f))+150 > ally.maxHealth/2) and GetDistance(myHero, ally) < 400 and AlliesAround(GetOrigin(spell), i.width*1.5*2+GetHitBox(ally)) then
								CastTargetSpell(ally, _W) 
							end
							if i.type and i.type == "circular" and (getdmg(str[f],ally,caster,GetCastLevel(caster,f))+150 > ally.health or getdmg(str[f],ally,caster,GetCastLevel(caster, f))+150 > ally.maxHealth/2) and GetDistance(myHero, ally) < 400 and AlliesAround(GetOrigin(spell), i.radius*1.5*2+GetHitBox(ally)) then
								CastTargetSpell(ally, _W) 
							end
						end
					end
				end
			end
		end
	end
end  
	
