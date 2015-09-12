require("Inspired")

-- Global stuff
KnockedUnits = {}
Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
target = GetCurrentTarget()
unit = GetCurrentTarget()
EnemyPos2 = GetOrigin(unit)

OnLoop(function(myHero)
YasuoDash2minion()
LaneClear()
LastHit()
Items()
YasuoRinCombo()
KillSteal()
AutoUlt()
AutoIgnite()
JungleClear()
if Yasuo.c.combo:Value() then
if GoS:ValidTarget(unit, 1200) then
  local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1025,90,false,false)
if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(unit, 475) and Yasuo.c.Q:Value() then
CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
if CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and Q3Pred.HitChance == 1 and Yasuo.c.Q:Value() then
CastSkillShot(_Q,Q3Pred.PredPos.x,Q3Pred.PredPos.y,Q3Pred.PredPos.z)
end
if CanUseSpell(myHero,_E) == READY and Yasuo.c.combo:Value() and GoS:ValidTarget(unit, 475) and Yasuo.c.E:Value() then
CastTargetSpell(unit,_E)
end
end
end
end)


WALL_SPELLS = { -- Yea boiz and grillz its all right here.......
    ["Fizz"]                      = {_R},
    ["Aatrox"]                      = {_E},
    ["Ahri"]                      = {_Q,_W,_E,_R},
    ["Anivia"]                      = {_Q,_E},
    ["Annie"]                      = {_Q},
    ["Ashe"]                      = {_W,_R},
    ["Amumu"]                      = {_Q},
    ["Blitzcrank"]                      = {_Q},
    ["Brand"]                      = {_Q,_R},
    ["Braum"]                      = {_Q,_R},
    ["Caitlyn"]                      = {_Q,_E,_R},
    ["Cassiopiea"]                      = {_W,_E},
    ["Corki"]                      = {_Q,_R},
    ["Diana"]                      = {_Q},
    ["DrMundo"]                      = {_Q},
    ["Draven"]                      = {_Q,_E,_R},
    ["Elise"]                      = {_Q,_E},
    ["Evelynn"]                      = {_Q},
    ["Ezreal"]                      = {_Q,_W,_R},
    ["Galio"]                      = {_Q,_E},
    ["Gangplank"]                      = {_Q},
    ["Gnar"]                      = {_Q},
    ["Graves"]                      = {_Q,_R},
    ["Heimerdinger"]                      = {_W},
    ["Irelia"]                      = {_R},
    ["Janna"]                      = {_Q},
    ["Jayce"]                      = {_Q},
    ["Jinx"]                      = {_W,_R},
    ["Kalista"]                      = {_Q},
    ["Karma"]                      = {_Q},
    ["Kassidan"]                      = {_Q},
    ["Katarina"]                      = {_R},
    ["Leblanc"]                      = {_Q,_E},
    ["Irelia"]                      = {_R},
    ["Leesin"]                      = {_Q},
    ["Irelia"]                      = {_R},
   	["Leona"]                      = {_E},
   	["Lissandra"]                      = {_E},
   	["Lucian"]                      = {_R}, 
   	["Lux"]                      = {_Q,_E},
   	["Missfortune"]                      = {_R},
   	["Morgana"]                      = {_Q},
   	["Nami"]                      = {_R},
   	["Nocturne"]                      = {_Q},
   	["Pantheon"]                      = {_Q},
   	["Quinn"]                      = {_Q},
   	["Rengar"]                      = {_E},
   	["Riven"]                      = {_R},
   	["Ryze"]                      = {_Q,_E},
   	["Sejuani"]                      = {_R},
   	["Sivir"]                      = {_Q,_E},
   	["Skarner"]                      = {_E},
   	["Sona"]                      = {_R},
   	["Swain"]                      = {_Q,_R},
   	["Irelia"]                      = {_R},
   	["Syndra"]                      = {_E,_R},
   	["Talon"]                      = {_W,_R},
   	["Teemo"]                      = {_Q},
   	["Thresh"]                      = {_Q},
   	["Tristana"]                      = {_R},
   	["Varus"]                      = {_Q,_R},
   	["Vayne"]                      = {_E},
   	["Veigar"]                      = {_R},
   	["Twistedfate"]                      = {_Q},
   	["Velkoz"]                      = {_Q,_W},
   	["Viktor"]                      = {_E},
   	["Xerath"]                      = {_Q},
   	["Zed"]                      = {_Q},
   	["Ziggs"]                      = {_Q, _R},
   	["Zyra"]                      = {_E}
}

OnProcessSpell(function(unit, spell)
myHero = GetMyHero()
if Yasuo.Wall.W:Value() then
if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GoS:GetDistance(unit) < 1500 then
local unispells = WALL_SPELLS[GetObjectName(unit)]
if myHero == spell.target and unispells and GetRange(unit) >= 450 and GoS:CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
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


-- Q predictions

QWPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,425,90,false,false)
Q2Pred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,GetCastRange(myHero, _Q),55,false,true)
Q3Pred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,1000,90,false,false)

-- End of Q Predictions


function YasuoRinCombo()
if GoS:ValidTarget(unit, 1200) then
if CanUseSpell(myHero,_R) == READY and Yasuo.c.R:Value() and (GetCurrentHP(unit)/GetMaxHP(unit))*100 <= Yasuo.c.RP:Value() then
GoS:DelayAction(function()
CastSpell(_R)
end, 2 - GetLatency()/1000)
end
end
end


function KillSteal()
for i,enemy in pairs(GoS:GetEnemyHeroes()) do
if GoS:ValidTarget(enemy, 1200) and IsDead(enemy) == false then
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
elseif CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and QPred.HitChance == 1 and Yasuo.ks.Q:Value() then
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

function LaneClear()
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

function JungleClear()
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

function LastHit()
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

function JungleSteal()

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

function YasuoDash2minion()
for _,Q in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
if GoS:ValidTarget(Q, 375) then
if GetCastName(myHero, _E) == "YasuoDashWrapper" and CanUseSpell(myHero, _E) == READY and Yasuo.m.ma:Value() and not GoS:ValidTarget(unit, 475) then
CastTargetSpell(Q,_E)
end
end
end
end
mydpos = GetOrigin(myHero)
function GenerateWallPos(unitPos)
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
p1 = GetOrigin(p1) or p1
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


function AutoUlt()
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

function AutoIgnite()
    if Ignite then
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if GoS:ValidTarget(unit, 600) and CanUseSpell(myHero, Ignite) == READY and (20*GetLevel(myHero)+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 and Yasuo.m.ignite:Value() then
                CastTargetSpell(k, Ignite)
            end
        end
    end
  end


function Items() -- Yes deftsu ik your looking right here kappa 

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


PrintChat(string.format("<font color='#1244EA'>Yasuo:</font> <font color='#FFFFFF'> By Cloud Loaded</font>"))
