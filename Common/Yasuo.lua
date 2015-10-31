require("Inspired")
if GetObjectName(myHero) ~= "Yasuo" then return end
-- Global stuff
KnockedUnits = {}

WALL_SPELLS = { -- Yea boiz and grillz its all right here.......
    ["FizzMarinerDoom"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["AhriOrbofDeception"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["AhriFoxFire"]                      = {Spellname ="AhriFoxFire",Name = "Ahri", Spellslot =_W},
    ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
    ["AhriTumble"]                      = {Spellname ="AhriTumble",Name = "Ahri", Spellslot =_R},
    ["FlashFrost"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
    ["Anivia2"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
    ["Disintegrate"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
    ["Volley"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
    ["EnchantedCrystalArrow"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
    ["BandageToss"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
    ["RocketGrabMissile"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
    ["BrandBlaze"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
    ["BrandWildfire"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
    ["BraumQ"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
    ["BraumRWapper"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
    ["CaitlynPiltoverPeacemaker"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
    ["CaitlynEntrapment"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
    ["CaitlynAceintheHole"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
    ["CassiopeiaMiasma"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopiea",Spellslot =_W},
    ["CassiopeiaTwinFang"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopiea",Spellslot =_E},
    ["PhosphorusBomb"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
    ["MissileBarrage"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
    ["DianaArc"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
    ["InfectedCleaverMissileCast"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
    ["dravenspinning"]                      = {Spellname ="dravenspinning",Name ="Draven",Spellslot =_Q},
    ["DravenDoubleShot"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
    ["DravenRCast"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
    ["EliseHumanQ"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
    ["EliseHumanE"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
    ["EvelynnQ"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
    ["EzrealMysticShot"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
    ["EzrealEssenceFlux"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
    ["EzrealArcaneShift"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
    ["GalioRighteousGust"]                      = {Spellname ="GalioRighteousGust",Name ="Galio",Spellslot =_E},
    ["GalioResoluteSmite"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
    ["Parley"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
    ["GnarQ"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
    ["GravesClusterShot"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
    ["GravesChargeShot"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
    ["HeimerdingerW"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
    ["IreliaTranscendentBlades"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
    ["HowlingGale"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
    ["JayceToTheSkies"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["jayceshockblast"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["JinxW"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
    ["JinxR"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
    ["KalistaMysticShot"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
    ["KarmaQ"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
    ["NullLance"]                      = {Spellname ="NullLance",Name ="Kassidan",Spellslot =_Q},
    ["KatarinaR"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
    ["LeblancChaosOrb"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
    ["LeblancSoulShackle"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["LeblancSoulShackleM"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["BlindMonkQOne"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
    ["LeonaZenithBladeMissle"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
    ["LissandraE"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
    ["LucianR"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R}, 
    ["LuxLightBinding"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
    ["LuxLightStrikeKugel"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
    ["MissFortuneBulletTime"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
    ["DarkBindingMissile"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
    ["NamiR"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
    ["JavelinToss"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
    ["NocturneDuskbringer"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
    ["Pantheon_Throw"]                      = {Spellname ="Pantheon_Throw",Name ="Pantheon",Spellslot =_Q},
    ["QuinnQ"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
    ["RengarE"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
    ["rivenizunablade"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
    ["Overload"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
    ["SpellFlux"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
    ["SejuaniGlacialPrisonStart"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
    ["SivirQ"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
    ["SivirE"]                      = {Spellname ="SivirE",Name ="Sivir",Spellslot =_E},
    ["SkarnerFractureMissileSpell"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
    ["SonaCrescendo"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
    ["SwainDecrepify"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
    ["SwainMetamorphism"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
    ["SyndraE"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
    ["SyndraR"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
    ["TalonRake"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
    ["TalonShadowAssault"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
    ["BlindingDart"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
    ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
    ["BusterShot"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
    ["VarusQ"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
    ["VarusR"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
    ["VayneCondemm"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
    ["VeigarPrimordialBurst"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
    ["WildCards"]                      = {Spellname ="WildCards",Name ="Twistedfate",Spellslot =_Q},
    ["VelkozQ"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
    ["VelkozW"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
    ["ViktorDeathRay"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
    ["XerathArcanoPulseChargeUp"]                      = {Spellname ="XerathArcanoPulseChargeUp",Name ="Xerath",Spellslot =_Q},
    ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
    ["ZiggsR"]                      = {Spellname ="ZiggsR",Name ="Ziggs",Spellslot =_R},
    ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
    ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
}

OnProcessSpell(function(unit, spell)
myHero = GetMyHero()
if Yasuo.Wall.W:Value() and WALL_SPELLS[spell.name] and Yasuo.Wall[GetObjectName(unit).."Wall"]:Value()  then
if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
unispells = WALL_SPELLS[GetObjectName(unit)]
if myHero == spell.target and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
local wPos = GetOrigin(unit)
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
elseif spell.endPos and not spell.name:lower():find("attack") then
local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
local wPos = GetOrigin(unit)
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
end
end
end
end
end)
DelayAction(function() --Deftsu

  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

  for i, spell in pairs(WALL_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
            Yasuo.Wall:Boolean(GetObjectName(k).."Wall", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
		
end, 1)


class "Yasuo"
function Yasuo:__init()
  OnTick(function(myHero) self:Loop(myHero) end)
  Yasuo = MenuConfig("Yasuo", "Yasuo")
    Yasuo:Menu("c", "Combo")
      Yasuo.c:Boolean("Q", "Use Q", true)
      Yasuo.c:Boolean("E", "Use E", true)
      Yasuo.c:Boolean("R", "Use R HP", true)
      Yasuo.c:Slider("RP", " R HP Enemy", 45, 1, 100, 1)
      PermaShow(Yasuo.c.R)

    Yasuo:Menu("f", "Farm")
      Yasuo.f:Menu("l", "LaneClear")
      Yasuo.f.l:Boolean("Q", "Use Q", true)
      Yasuo.f.l:Boolean("E", "Use E", true)

    Yasuo.f:Menu("h", "LastHit")
      Yasuo.f.h:Boolean("Q", "Use Q", true)
      Yasuo.f.h:Boolean("E", "Use E", true)

    Yasuo.f:Menu("j", "JungleClear")
      Yasuo.f.j:Boolean("Q", "Use Q", true)
      Yasuo.f.j:Boolean("E", "Use E", true)

    Yasuo:Menu("j", "JungleSteal")
      Yasuo.j:Boolean("Q", "Use Q", true)
      Yasuo.j:Boolean("E", "Use E", true)


    Yasuo:Menu("m", "Misc")
      Yasuo.m:KeyBinding("ma", "DashForce", 71)
      Yasuo.m:Boolean("tfra", "R Team Fight", true)
      Yasuo.m:Slider("tfr", " R X Enemies", 3, 0, 5, 1)
      PermaShow(Yasuo.m.ma)
      PermaShow(Yasuo.m.tfra)

    --Yasuo:Menu("ks", "KillSteal")
      --Yasuo.ks:Boolean("Q", "Use Q", true)
      --Yasuo.ks:Boolean("E", "Use E", true)
      --Yasuo.ks:Boolean("R", "Use R", true)

    Yasuo:Menu("Wall", "Wall")
      Yasuo.Wall:Boolean("W", "Use W", true)

    Yasuo:Info("Made", "Script by Cloud") 
end

function Yasuo:Loop(myHero)
    self:Checks()
    if IOW:Mode() == "Combo" then
      self:Combo()
    end
    if IOW:Mode() == "LaneClear" then
      self:LaneClear()
    end
    if IOW:Mode() == "LaneClear" then
      self:JungleClear()
    end
    if IOW:Mode() == "LastHit" then
      self:LastHit()
    end
    self:YasuoRinCombo()
    --self:KillSteal()
    self:AutoUlt()
    self:YasuoDash2minion()
end

function Yasuo:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  EnemyPos2 = GetOrigin(unit)
  target = GetCurrentTarget()
  unit = GetCurrentTarget()
end

function Yasuo:Combo()
if Yasuo.c.Q:Value() then
    self:CastQ(unit)
    end
if Yasuo.c.E:Value() then
    self:CastE(unit)
    end
end

function Yasuo:CastQ(unit)
if target or unit then
local QWPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),1500,250,425,90,false,false)
local Q3Pred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1000,90,false,false)
if CanUseSpell(myHero, _Q) == READY and Yasuo.c.Q:Value() and QWPred.HitChance == 1 and GetCastName(myHero,_Q) ~= "yasuoq3w" then
CastSkillShot(_Q,QWPred.PredPos.x,QWPred.PredPos.y,QWPred.PredPos.z)
end

if CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and Q3Pred.HitChance == 1 and Yasuo.c.Q:Value() then
CastSkillShot(_Q,Q3Pred.PredPos.x,Q3Pred.PredPos.y,Q3Pred.PredPos.z)
end
end
end

function Yasuo:CastE(unit)
if CanUseSpell(myHero,_E) == READY and ValidTarget(unit, 475) and Yasuo.c.E:Value() then
CastTargetSpell(unit,_E)
end
end

function Yasuo:YasuoRinCombo()
if target or unit then
if CanUseSpell(myHero,_R) == READY and Yasuo.c.R:Value() and (GetCurrentHP(unit)/GetMaxHP(unit))*100 <= Yasuo.c.RP:Value() then
DelayAction(function()
CastSpell(_R)
end, 2 - GetLatency()/2000)
end
end
end


function Yasuo:KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
if target or unit  and  ValidTarget(unit, 1200) then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(enemy)
local Dmg = CalcDamage(myHero, enemy, z)

local y = (GetCastLevel(myHero,_E)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(enemy)
local Dmgq = CalcDamage(myHero, enemy, y)

local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)+(GetBaseDamage(myHero))
local Dmgr = CalcDamage(myHero, enemy, ult)

local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1025,90,false,false)
if CanUseSpell(myHero, _Q) == READY and ValidTarget(EnemyPos2, 475) and GetCastName(myHero,_Q) == "YasuoQW" or "yasuoq2w" and Dmg > hp and Yasuo.ks.Q:Value() then
CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
elseif CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and QPred.HitChance == 1 and Yasuo.ks.Q:Value() and Dmg > hp then
CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end

if GetCastName(myHero, _E) == "YasuoDashWrapper" and GotBuff(unit, "YasuoDashWrapper") == 0 and Dmg > hp and Yasuo.ks.E:Value() then
CastTargetSpell(enemy, _E)
end

if CanUseSpell(myHero, _R) == READY and Dmgr > hpq and Yasuo.ks.R:Value() then
DelayAction(function()
CastSpell(_R)
end, 2 - GetLatency()/1000)
end

end
end
end

function Yasuo:LaneClear()
local towerPos = GetOrigin(objectManager2.turrents) 
for _,Q in pairs(minionManager.objects) do
if ValidTarget(Q, 475) then

EnemyPos3 = GetOrigin(Q)
if CanUseSpell(myHero, _E) == READY and Yasuo.f.l.E:Value() and UnderTower(myHero) == false then
CastTargetSpell(Q, _E)
end

if CanUseSpell(myHero, _Q) == READY and Yasuo.f.l.Q:Value() then
CastSkillShot(_Q,EnemyPos3.x,EnemyPos3.y,EnemyPos3.z)
end
end
end
end

function Yasuo:JungleClear()

for _,Q in pairs(minionManager.objects) do
if ValidTarget(Q, 475) then

local EnemyPos = GetOrigin(Q)
if CanUseSpell(myHero, _Q) == READY and Yasuo.f.j.Q:Value() then
CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
if CanUseSpell(myHero, _E) == READY and Yasuo.f.j.E:Value() then
CastTargetSpell(Q, _E)
end
end
end
end

function Yasuo:LastHit()
	
for _,M in pairs(minionManager.objects) do
if ValidTarget(M, 475) then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(M)
local Dmg = CalcDamage(myHero, M, z)

local y = (GetCastLevel(myHero,_Q)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(M)
local Dmgq = CalcDamage(myHero, M, y)

local towerPos = GetOrigin(objectManager2.turrents) 

if CanUseSpell(myHero, _E) == READY and Dmg > hp and Yasuo.f.h.E:Value() and UnderTower(myHero) == false then
CastTargetSpell(M, _E)
end
local EnemyPos3 = GetOrigin(M)
if CanUseSpell(myHero, _Q) == READY and Dmgq > hpq and Yasuo.f.h.Q:Value() then
CastSkillShot(_Q,EnemyPos3.x,EnemyPos3.y,EnemyPos3.z)
end
end
end
end

function Yasuo:JungleSteal()

for _,js in pairs(minionManager.objects) do

local y = (GetCastLevel(myHero,_Q)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(M)
local Dmgq = CalcDamage(myHero, js, y)
local EnemyPos4 = GetOrigin(js)

local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local Dmg = CalcDamage(myHero, js, z)
if ValidTarget(js, 475) and IsInDistance(js, GetCastRange(myHero,_Q)) then  
if CanUseSpell(myHero, _Q) == READY and  Dmgq > GetCurrentHp(js) and GetObjectName(js) == "SRU_Baron" and Yasuo.j.Q:Value() then
CastSkillShot(_Q,EnemyPos4.x,EnemyPos4.y,EnemyPos4.z)
elseif CanUseSpell(myHero, _Q) == READY and  Dmgq > GetCurrentHp(js) and GetObjectName(js) == "SRU_Dragon" and Yasuo.j.Q:Value() then
CastSkillShot(_Q,EnemyPos4.x,EnemyPos4.y,EnemyPos4.z)
elseif CanUseSpell(myHero, _E) == READY and  Dmg > GetCurrentHp(js) and GetObjectName(js) == "SRU_Baron" and Yasuo.j.E:Value() then
CastTargetSpell(js, _E)
elseif CanUseSpell(myHero, _E) == READY and  Dmg > GetCurrentHp(js) and GetObjectName(js) == "SRU_Dragon" and Yasuo.j.E:Value() then
CastTargetSpell(js, _E)
end
end
end
end

function Yasuo:YasuoDash2minion()
for _,Q in pairs(minionManager.objects) do
if ValidTarget(Q, 375) then
if GetCastName(myHero, _E) == "YasuoDashWrapper" and CanUseSpell(myHero, _E) == READY and Yasuo.m.ma:Value() and not ValidTarget(unit, 475) then
CastTargetSpell(Q,_E)
end
end
end
end

function GenerateWallPos(unitPos)
local mydpos = GetOrigin(myHero)
local tV = {x = (unitPos.x-mydpos.x), z = (unitPos.z-mydpos.z)}
local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
return {x = mydpos.x + 400 * tV.x / len, y = 0, z = mydpos.z + 400 * tV.z / len}
end

function GenerateSpellPos(unitPos, spellPos, range)
local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end

function UnderTower(p1)
local p1 = GetOrigin(p1) or p1
for i,turrent in pairs(objectManager2.turrets) do
if GetTeam(turrent) ~= GetTeam(myHero) and ValidTarget(turrent, 1450) then
local turretPos = GetOrigin(turrent)
if GetDistance(myHero, turrentPos) <= 1140 then
	return true
end
end
end
	return false
end

function MinionsAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GetAllMinions(MINION_ALLY)) do 
        if v and ValidTarget(v) and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
            c = c + 1
        end
    end
    return c
end


function Yasuo:AutoUlt()
     if Yasuo.m.tfra:Value() and Yasuo.m.tfr:Value() > 0 and #EnemiesKnocked() >= Yasuo.m.tfr:Value() then
        CastR(unit)
    end
end

function CastR(unit)
  if target then
    if CanUseSpell(myHero, _R) == READY and KnockedUnits[GetNetworkID(unit)] ~= nil then
        CastSpell(_R)
    end
  end
end

function EnemiesKnocked()
    local Knockeds = {}
    for i, enemy in ipairs(GetEnemyHeroes()) do
        if target and KnockedUnits[GetNetworkID(enemy)] ~= nil then table.insert(Knockeds, enemy) end
    end
    return Knockeds
end

do
  _G.objectManager2 = {}
  objectManager2.maxObjects = 0
  objectManager2.objects = {}
  objectManager2.spawnpoints = {}
  objectManager2.camps = {}
  objectManager2.barracks = {}
  objectManager2.heroes = {}
  objectManager2.minions = {}
  objectManager2.turrets = {}
  objectManager2.missiles = {}
  objectManager2.shops = {}
  objectManager2.wards = {}
  objectManager2.unknown = {}
  OnObjectLoop(function(object, myHero)
    objectManager2.objects[GetNetworkID(object)] = object
  end)
  OnTick(function(myHero)
    objectManager2.maxObjects = 0
    for _, obj in pairs(objectManager2.objects) do
      objectManager2.maxObjects = objectManager2.maxObjects + 1
      local type = GetObjectType(obj)
      if type == Obj_AI_SpawnPoint then
        objectManager2.spawnpoints[_] = obj
      elseif type == Obj_AI_Camp then
        objectManage2r.camps[_] = obj
      elseif type == Obj_AI_Barracks then
        objectManager2.barracks[_] = obj
      elseif type == Obj_AI_Hero then
        objectManager2.heroes[_] = obj
      elseif type == Obj_AI_Minion then
        objectManager2.minions[_] = obj
      elseif type == Obj_AI_Turret then
        objectManager2.turrets[_] = obj
      elseif type == Obj_AI_LineMissle then
        objectManager2.missiles[_] = obj
      elseif type == Obj_AI_Shop then
        objectManager2.shops[_] = obj
      else
        local objName = GetObjectBaseName(obj)
        if objName:lower():find("ward") or objName:lower():find("totem") then
          objectManager2.wards[_] = obj
        else
          objectManager2.unknown[_] = obj
        end
      end
    end
  end)
  DelayAction(function() EmptyObjManager() end, 60000)
end

function EmptyObjManager()
  _G.objectManager2 = {}
  objectManager2.maxObjects = 0
  objectManager2.objects = {}
  objectManager2.spawnpoints = {}
  objectManager2.camps = {}
  objectManager2.barracks = {}
  objectManager2.heroes = {}
  objectManager2.minions = {}
  objectManager2.turrets = {}
  objectManager2.missiles = {}
  objectManager2.shops = {}
  objectManager2.wards = {}
  objectManager2.unknown = {}
  collectgarbage()
  DelayAction(function() EmptyObjManager() end, 60000)
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end

PrintChat(string.format("<font color='#1244EA'>Yasuo:</font> <font color='#FFFFFF'> By Cloud Loaded \nRecommended usage with Platypus Activator </font>"))
