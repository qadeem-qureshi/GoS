require("Inspired")

-- Global stuff
KnockedUnits = {}
Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))

WALL_SPELLS = { -- Yea boiz and grillz its all right here.......
    ["Fizz"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["Aatrox"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["Ahri"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["Ahri2"]                      = {Spellname ="AhriFoxFire",Name = "Ahri", Spellslot =_W},
    ["Ahri3"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
    ["Ahri3"]                      = {Spellname ="AhriTumble",Name = "Ahri", Spellslot =_R},
    ["Anivia"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
    ["Anivia2"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
    ["Annie"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
    ["Ashe"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
    ["Ashe2"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
    ["Amumu"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
    ["Blitzcrank"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
    ["Brand"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
    ["Brand2"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
    ["Braum"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
    ["Braum2"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
    ["Caitlyn"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
    ["Caitlyn2"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
    ["Caitlyn3"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
    ["Cassiopiea"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopiea",Spellslot =_W},
    ["Cassiopiea2"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopiea",Spellslot =_E},
    ["Corki"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
    ["Corki2"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
    ["Diana"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
    ["DrMundo"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
    ["Draven"]                      = {Spellname ="dravenspinning",Name ="Draven",Spellslot =_Q},
    ["Draven2"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
    ["Draven3"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
    ["Elise"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
    ["Elise2"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
    ["Evelynn"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
    ["Ezreal"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
    ["Ezreal2"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
    ["Ezreal3"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
    ["Galio"]                      = {Spellname ="GalioRighteousGust",Name ="Galio",Spellslot =_E},
    ["Galio2"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
    ["Gangplank"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
    ["Gnar"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
    ["Graves"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
    ["Graves2"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
    ["Heimerdinger"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
    ["Irelia"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
    ["Janna"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
    ["Jayce"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["Jinx"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
    ["Jinx2"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
    ["Kalista"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
    ["Karma"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
    ["Kassidan"]                      = {Spellname ="NullLance",Name ="Kassidan",Spellslot =_Q},
    ["Katarina"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
    ["Leblanc"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
    ["Leblanc2"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["Leesin"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
    ["Leona"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
    ["Lissandra"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
    ["Lucian"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R}, 
    ["Lux"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
    ["Lux2"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
    ["Missfortune"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
    ["Morgana"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
    ["Nami"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
    ["Nidalee"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
    ["Nocturne"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
    ["Pantheon"]                      = {Spellname ="Pantheon_Throw",Name ="Pantheon",Spellslot =_Q},
    ["Quinn"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
    ["Rengar"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
    ["Riven"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
    ["Ryze"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
    ["Ryze2"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
    ["Sejuani"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
    ["Sivir"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
    ["Sivir2"]                      = {Spellname ="SivirE",Name ="Sivir",Spellslot =_E},
    ["Skarner"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
    ["Sona"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
    ["Swain"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
    ["Swain2"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
    ["Syndra"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
    ["Syndra2"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
    ["Talon"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
    ["Talon2"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
    ["Teemo"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
    ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
    ["Tristana"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
    ["Varus"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
    ["Varus2"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
    ["Vayne"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
    ["Veigar"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
    ["Twistedfate"]                      = {Spellname ="WildCards",Name ="Twistedfate",Spellslot =_Q},
    ["Velkoz"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
    ["Velkoz2"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
    ["Viktor"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
    ["Xerath"]                      = {Spellname ="XerathArcanoPulseChargeUp",Name ="Xerath",Spellslot =_Q},
    ["Zed"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
    ["Ziggs"]                      = {Spellname ="ZiggsR",Name ="Ziggs",Spellslot =_R},
    ["Ziggs2"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
    ["Zyra"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
}

OnProcessSpell(function(unit, spell)
myHero = GetMyHero()
if Yasuo.Wall.W:Value() then
if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GoS:GetDistance(unit) < 1500 then
unispells = WALL_SPELLS[GetObjectName(unit)]
if myHero == spell.target and GetRange(unit) >= 450 and GoS:CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
local wPos = GetOrigin(unit)
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
elseif spell.endPos and not spell.name:lower():find("attack") then
local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GoS:GetDistance(unit, myHero))
if GoS:GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GoS:GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
local wPos = GetOrigin(unit)
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
end
end
end
end
end)
GoS:DelayAction(function() --Deftsu

  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

  for i, spell in pairs(WALL_SPELLS) do
    for _,k in pairs(GoS:GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
            Yasuo.Wall:Boolean(GetObjectName(k).."Wall", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
		
end, 1)


class "Yasuo"
function Yasuo:__init()
  OnLoop(function(myHero) self:Loop(myHero) end)
  Yasuo = Menu("Yasuo", "Yasuo")
    Yasuo:SubMenu("c", "Combo")
      Yasuo.c:Boolean("Q", "Use Q", true)
      Yasuo.c:Boolean("E", "Use E", true)
      Yasuo.c:Boolean("R", "Use R", true)
      Yasuo.c:Slider("RP", " R HP Enemy", 45, 1, 100, 1)
      Yasuo.c:Key("combo", "Combo", string.byte(" "))

    Yasuo:SubMenu("f", "Farm")
      Yasuo.f:SubMenu("l", "LaneClear")
      Yasuo.f.l:Boolean("Q", "Use Q", true)
      Yasuo.f.l:Boolean("E", "Use E", true)
      Yasuo.f.l:Key("lca", "LaneClear", string.byte("V"))

    Yasuo.f:SubMenu("h", "LastHit")
      Yasuo.f.h:Boolean("Q", "Use Q", true)
      Yasuo.f.h:Boolean("E", "Use E", true)
    Yasuo.f.h:Key("lha", "LastHit", string.byte("X"))

    Yasuo.f:SubMenu("j", "JungleClear")
      Yasuo.f.j:Boolean("Q", "Use Q", true)
      Yasuo.f.j:Boolean("E", "Use E", true)
      Yasuo.f.j:Key("jca", "LaneClear", string.byte("V"))

    Yasuo:SubMenu("j", "JungleSteal")
      Yasuo.j:Boolean("Q", "Use Q", true)
      Yasuo.j:Boolean("E", "Use E", true)


    Yasuo:SubMenu("m", "Misc")
      Yasuo.m:Key("ma", "Dash Force", string.byte("G"))
      Yasuo.m:Boolean("tfra", "R Team Fight", true)
      Yasuo.m:Boolean("ignite", "Use Ignite", true)
      Yasuo.m:Slider("tfr", " R X Enemies", 3, 0, 5, 1)
    Yasuo.m:SubMenu("I", "Items")
      Yasuo.m.I:Boolean("B", "Use BoTRK", true)
      Yasuo.m.I:Boolean("b", "Use BilgeWater", true)
      Yasuo.m.I:Boolean("G", "Use Ghostblade", true)
      Yasuo.m.I:Boolean("H", "Use Hydra", true)
      Yasuo.m.I:Boolean("T", "Use Tiamat", true)
      Yasuo.m.I:Slider("QM", " QSS HP", 75, 0, 100, 1)
      Yasuo.m.I:Boolean("R", "Use Randuins", true)
      Yasuo.m.I:Boolean("M", "Use Mercurial", true)
      Yasuo.m.I:Boolean("Q", "Use QSS", true)

    Yasuo:SubMenu("ks", "KillSteal")
      Yasuo.ks:Boolean("Q", "Use Q", true)
      Yasuo.ks:Boolean("E", "Use E", true)
      Yasuo.ks:Boolean("R", "Use R", true)

    Yasuo:SubMenu("Wall", "Wall")
      Yasuo.Wall:Boolean("W", "Use W", true)

    Yasuo:Info("Made", "Script by Cloud") 
end

function Yasuo:Loop(myHero)
    self:Checks()
    if IOW:Mode() == "Combo" then
      self:Combo()
      self:Items()
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
    self:KillSteal()
    self:AutoUlt()
    self:AutoIgnite()
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
  QWPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,425,90,false,false)
  Q2Pred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,GetCastRange(myHero, _Q),55,false,true)
  Q3Pred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1000,90,false,false)
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
if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(unit, 475) and Yasuo.c.Q:Value() and QWPred.HitChance == 1 and GetCastName(myHero,_Q) ~= "yasuoq3w" and Yasuo.c.combo:Value() then
CastSkillShot(_Q,QWPred.PredPos.x,QWPred.PredPos.y,QWPred.PredPos.z)
end

if CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and Q3Pred.HitChance == 1 and Yasuo.c.Q:Value() and GoS:ValidTarget(unit, 900) and Yasuo.c.combo:Value() then
CastSkillShot(_Q,Q3Pred.PredPos.x,Q3Pred.PredPos.y,Q3Pred.PredPos.z)
end
end

function Yasuo:CastE(unit)
if CanUseSpell(myHero,_E) == READY and Yasuo.c.combo:Value() and GoS:ValidTarget(unit, 475) and Yasuo.c.E:Value() then
CastTargetSpell(unit,_E)
end
end

function Yasuo:YasuoRinCombo()
if GoS:ValidTarget(unit, 1200) then
if CanUseSpell(myHero,_R) == READY and Yasuo.c.R:Value() and (GetCurrentHP(unit)/GetMaxHP(unit))*100 <= Yasuo.c.RP:Value() then
GoS:DelayAction(function()
CastSpell(_R)
end, 2 - GetLatency()/2000)
end
end
end


function Yasuo:KillSteal()
for i,enemy in pairs(GoS:GetEnemyHeroes()) do
if GoS:ValidTarget(enemy, 1200) then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(enemy)
local Dmg = GoS:CalcDamage(myHero, enemy, z)

local y = (GetCastLevel(myHero,_E)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(enemy)
local Dmgq = GoS:CalcDamage(myHero, enemy, y)

local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)+(GetBaseDamage(myHero))
local Dmgr = GoS:CalcDamage(myHero, enemy, ult)

local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1025,90,false,false)
if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(EnemyPos2, 475) and GetCastName(myHero,_Q) == "YasuoQW" or "yasuoq2w" and Dmg > hp and Yasuo.ks.Q:Value() then
CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
elseif CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and QPred.HitChance == 1 and Yasuo.ks.Q:Value() and Dmg > hp then
CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end

if GetCastName(myHero, _E) == "YasuoDashWrapper" and GotBuff(unit, "YasuoDashWrapper") == 0 and Dmg > hp and Yasuo.ks.E:Value() then
CastTargetSpell(enemy, _E)
end

if CanUseSpell(myHero, _R) == READY and Dmgr > hpq and Yasuo.ks.R:Value() then
GoS:DelayAction(function()
CastSpell(_R)
end, 2 - GetLatency()/1000)
end

end
end
end

function Yasuo:LaneClear()
if Yasuo.f.l.lca:Value()then
local towerPos = GetOrigin(objectManager2.turrents) 
for _,Q in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
if GoS:ValidTarget(Q, 475) then

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
end

function Yasuo:JungleClear()
if Yasuo.f.j.jca:Value() then

for _,Q in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
if GoS:ValidTarget(Q, 475) then

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
end

function Yasuo:LastHit()
if Yasuo.f.h.lha:Value() then
	
for _,M in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
if GoS:ValidTarget(M, 475) then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(M)
local Dmg = GoS:CalcDamage(myHero, M, z)

local y = (GetCastLevel(myHero,_Q)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(M)
local Dmgq = GoS:CalcDamage(myHero, M, y)

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
end

function Yasuo:JungleSteal()

for _,js in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do

local y = (GetCastLevel(myHero,_Q)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(M)
local Dmgq = GoS:CalcDamage(myHero, js, y)
local EnemyPos4 = GetOrigin(js)

local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local Dmg = GoS:CalcDamage(myHero, js, z)
if GoS:ValidTarget(js, 475) and IsInDistance(js, GetCastRange(myHero,_Q)) then  
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
for _,Q in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
if GoS:ValidTarget(Q, 375) then
if GetCastName(myHero, _E) == "YasuoDashWrapper" and CanUseSpell(myHero, _E) == READY and Yasuo.m.ma:Value() and not GoS:ValidTarget(unit, 475) then
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
if GetTeam(turrent) ~= GetTeam(myHero) and GoS:ValidTarget(turrent, 1450) then
local turretPos = GetOrigin(turrent)
if GoS:GetDistance(myHero, turrentPos) <= 1140 then
	return true
end
end
end
	return false
end

function MinionsAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GoS:GetAllMinions(MINION_ALLY)) do 
        if v and GoS:ValidTarget(v) and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
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
    if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(unit, 1200) and KnockedUnits[GetNetworkID(unit)] ~= nil then
        CastSpell(_R)
    end
end

function EnemiesKnocked()
    local Knockeds = {}
    for i, enemy in ipairs(GoS:GetEnemyHeroes()) do
        if GoS:ValidTarget(enemy, 1200) and KnockedUnits[GetNetworkID(enemy)] ~= nil then table.insert(Knockeds, enemy) end
    end
    return Knockeds
end

function Yasuo:AutoIgnite()
    if Ignite then
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if GoS:ValidTarget(unit, 600) and CanUseSpell(myHero, Ignite) == READY and (20*GetLevel(myHero)+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 and Yasuo.m.ignite:Value() then
                CastTargetSpell(k, Ignite)
            end
        end
    end
  end


function Yasuo:Items() -- Yes deftsu ik your looking right here kappa 

-- QSS
if GetItemSlot(myHero,3140) > 0 and Yasuo.m.I.Q:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 <= Yasuo.m.I.QM:Value() then
CastTargetSpell(myHero, GetItemSlot(myHero,3140))
end
--Mercurial
if GetItemSlot(myHero,3139) > 0 and Yasuo.m.I.M:Value()  and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 <=  Yasuo.m.I.QM:Value() then
CastTargetSpell(myHero, GetItemSlot(myHero,3139))
end
-- blade of ruined king
if GetItemSlot(myHero,3153) > 0 and Yasuo.m.I.B:Value()  and GoS:ValidTarget(unit, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
CastTargetSpell(target, GetItemSlot(myHero,3153))
end
-- Bilgewater
if GetItemSlot(myHero,3144) > 0 and  Yasuo.m.I.b:Value() and GoS:ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
CastTargetSpell(target, GetItemSlot(myHero,3144))
end
-- Ghost Blade
if GetItemSlot(myHero,3142) > 0 and Yasuo.m.I.G:Value() and GoS:ValidTarget(target, 550) then
CastTargetSpell(myHero, GetItemSlot(myHero,3142))
end
-- Hydra
if GetItemSlot(myHero,3074) > 0 and Yasuo.m.I.H:Value() and GoS:ValidTarget(target, 550) then
CastTargetSpell(myHero, GetItemSlot(myHero,3074))
end
-- Tiamat
if GetItemSlot(myHero,3077) > 0 and Yasuo.m.I.T:Value() and GoS:ValidTarget(target, 550) then
CastTargetSpell(myHero, GetItemSlot(myHero,3077))
end
-- Randiuns
if GetItemSlot(myHero,3143) > 0 and Yasuo.m.I.R:Value() and GoS:ValidTarget(target, 550) then
CastTargetSpell(myHero, GetItemSlot(myHero,3143))
end

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
  OnLoop(function(myHero)
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
  GoS:DelayAction(function() EmptyObjManager() end, 60000)
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
  GoS:DelayAction(function() EmptyObjManager() end, 60000)
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end

PrintChat(string.format("<font color='#1244EA'>Yasuo:</font> <font color='#FFFFFF'> By Cloud Loaded HI</font>"))
