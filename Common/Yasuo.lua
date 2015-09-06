
require('Dlib')
require('Inspired')
require('IAC')

local version = 2
local UP=Updater.new("Cloudhax23/GoS/tree/master/Common", "Common\\Yasuo", version)
if UP.newVersion() then UP.update() end

notification("Yasuo CloudWalker Loaded.", 5000)

--------------- Thanks ilovesona for this ------------------------
DelayAction(function ()
        for _, imenu in pairs(menuTable) do
                local submenu = menu.addItem(SubMenu.new(imenu.name))
                for _,subImenu in pairs(imenu) do
                        if subImenu.type == SCRIPT_PARAM_ONOFF then
                                local ggeasy = submenu.addItem(MenuBool.new(subImenu.t, subImenu.value))
                                OnLoop(function(myHero) subImenu.value = ggeasy.getValue() end)
                        elseif subImenu.type == SCRIPT_PARAM_KEYDOWN then
                                local ggeasy = submenu.addItem(MenuKeyBind.new(subImenu.t, subImenu.key))
                                OnLoop(function(myHero) subImenu.key = ggeasy.getValue(true) end)
                        elseif subImenu.type == SCRIPT_PARAM_INFO then
                                submenu.addItem(MenuSeparator.new(subImenu.t))
                        end
                end
        end
        _G.DrawMenu = function ( ... )  end
end, 1000)
------------------------------------------------------------------


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
if WallsU.getValue() then
if Config.W and unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
local unispells = WALL_SPELLS[GetObjectName(unit)]
if myHero == spell.target and spell.name:lower():find(unispells) and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
local wPos = GenerateWallPos(GetOrigin(unit))
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
elseif spell.endPos and not spell.name:lower():find("attack") then
local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
local wPos = GenerateWallPos(GetOrigin(unit))
CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
end
end
end
end
end)

target = GetCurrentTarget()
unit = GetCurrentTarget()
EnemyPos2 = GetOrigin(unit)

local root = menu.addItem(SubMenu.new("Yasuo"))

local Combo = root.addItem(SubMenu.new("Combo"))
local QC = Combo.addItem(MenuBool.new("Use Q",true))
local EC = Combo.addItem(MenuBool.new("Use E",true))
local RC = Combo.addItem(MenuBool.new("Use R",true))
local ComboA = Combo.addItem(MenuKeyBind.new("", 32))

local Wall = root.addItem(SubMenu.new("Wall"))
local WallsU = Wall.addItem(MenuBool.new("Use W",true))

local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))
local KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", true))
local KSR = KSmenu.addItem(MenuBool.new("Killsteal with R", true))

local Misc = root.addItem(SubMenu.new("Misc"))
local TFR = Misc.addItem(MenuBool.new("Team Fight Ult", true))

local Farm = root.addItem(SubMenu.new("Farm"))
local M2M = Farm.addItem(MenuKeyBind.new("E to Minion", 71))
local LaneT = Farm.addItem(MenuSlider.new("How many minions E (V)", 3, 0, 7, 1))
local LaneClearE = Farm.addItem(MenuKeyBind.new("Use E LaneClear", 86))
local LaneClearQ = Farm.addItem(MenuKeyBind.new("Use Q LaneClear", 86))
local LaneClearA = Farm.addItem(MenuKeyBind.new("LaneClear", 86))
local JungleClearE = Farm.addItem(MenuKeyBind.new("Use E JungleClear", 86))
local JungleClearQ = Farm.addItem(MenuKeyBind.new("Use Q JungleClear", 86))
local JungleClearA = Farm.addItem(MenuKeyBind.new("JungleClear", 86))
local LastHitQ = Farm.addItem(MenuKeyBind.new("Use Q LastHit", 88))
local LastHitE = Farm.addItem(MenuKeyBind.new("Use E LastHit", 88))
local LastHitA = Farm.addItem(MenuKeyBind.new("LaneClear", 88))
local LastHitET = Farm.addItem(MenuSlider.new("How many minions E (X)", 3, 0, 7, 1))





-- Q predictions

QWPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1500,250,425,90,false,false)
Q2Pred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1500,250,GetCastRange(myHero, _Q),55,false,true)
Q3Pred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1500,250,1000,90,false,true)

-- End of Q Predictions


OnLoop(function(myHero)
Combo()
YasuoDash2minion()
YasuoR3()
LaneClear()
KillSteal()
LastHit()
JungleClear()
end)

function Combo()
if ComboA.getValue() then
if ValidTarget(unit, 1200) then

if CanUseSpell(myHero, _Q) == READY and ValidTarget(EnemyPos2, 475) and GetCastName(myHero,_Q) == "YasuoQW" or "yasuoq2w" and QC.getValue() then
CastSkillShot(_Q,QWPred.PredPos.x,QWPred.PredPos.y,QWPred.PredPos.z)
elseif CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and Q3Pred.HitChance == 1 and QC.getValue() then
CastSkillShot(_Q,Q3Pred.PredPos.x,Q3Pred.PredPos.y,Q3Pred.PredPos.z)
end

if CanUseSpell(myHero, _E) == READY and ValidTarget(unit, 475) and EC.getValue() then
CastTargetSpell(unit, _E)
end

local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)+(GetBaseDamage(myHero))
if ValidTarget(unit, 1200) then
if CanUseSpell(myHero, _R) == READYNONCAST and RC.getValue() and GotBuff(unit, "Knockup") == 1 or GotBuff(unit, "Knockback") == 1 or GotBuff(unit, "yasuoq3ms") == 1 then
CastSpell(_R)
end
end

end
end
end

function KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
if ValidTarget(enemy, 1200) and IsDead(enemy) == false then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(enemy)
local Dmg = CalcDamage(myHero, enemy, z)

local y = (GetCastLevel(myHero,_E)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(enemy)
local Dmgq = CalcDamage(myHero, enemy, y)

local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)+(GetBaseDamage(myHero))
local Dmgr = CalcDamage(myHero, enemy, ult)

if CanUseSpell(myHero, _Q) == READY and ValidTarget(EnemyPos2, 475) and GetCastName(myHero,_Q) == "YasuoQW" or "yasuoq2w" and KSQ.getValue() then
CastSkillShot(_Q,QWPred.PredPos.x,QWPred.PredPos.y,QWPred.PredPos.z)
elseif CanUseSpell(myHero, _Q) == READY and GetCastName(myHero,_Q) == "yasuoq3w" and Q3Pred.HitChance == 1 and KSQ.getValue() then
CastSkillShot(_Q,Q3Pred.PredPos.x,Q3Pred.PredPos.y,Q3Pred.PredPos.z)
end

if GetCastName(myHero, _E) == "YasuoDashWrapper" and GotBuff(unit, "YasuoDashWrapper") == 0 and Dmg > hp and KSE.getValue() then
CastTargetSpell(enemy, _E)
end

if CanUseSpell(myHero, _R) == READY and Dmgr > hpq and KSR.getValue() and GotBuff(enemy, "Knockup") >= 1 or GotBuff(enemy, "Knockback") >= 1 or GotBuff(enemy, "yasuoq3ms") >= 1 then
CastSpell(_R)
end

end
end
end

function LaneClear()
if LaneClearA.getValue() then
local towerPos = GetOrigin(objectManager.turrents) 
for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
if ValidTarget(Q, 475) then

EnemyPos3 = GetOrigin(Q)
if CanUseSpell(myHero, _E) == READY and LaneClearE.getValue() and UnderTower(myHero) == false or MinionsAround(GetOrigin(turrentPos), 750) <= LaneT.getValue() then
CastTargetSpell(Q, _E)
end

if CanUseSpell(myHero, _Q) == READY and LaneClearQ.getValue() then
CastSkillShot(_Q,EnemyPos3.x,EnemyPos3.y,EnemyPos3.z)
end
end
end
end
end

function JungleClear()
if JungleClearA.getValue() then

for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
if ValidTarget(Q, 475) then

local EnemyPos = GetOrigin(Q)
if CanUseSpell(myHero, _Q) == READY and JungleClearQ.getValue() then
CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
if CanUseSpell(myHero, _E) == READY and JungleClearE.getValue() then
CastTargetSpell(Q, _E)
end
end
end
end
end

function LastHit()
if LastHitA.getValue() then
	
for _,M in pairs(GetAllMinions(MINION_ENEMY)) do
if ValidTarget(M, 475) then
local z = (GetCastLevel(myHero,_E)*20)+(GetBonusAP(myHero)*.60)+(GetBaseDamage(myHero))
local hp = GetCurrentHP(M)
local Dmg = CalcDamage(myHero, M, z)

local y = (GetCastLevel(myHero,_Q)*20)+(GetBonusDmg(myHero)*1)+(GetBaseDamage(myHero))
local hpq = GetCurrentHP(M)
local Dmgq = CalcDamage(myHero, M, y)

local towerPos = GetOrigin(objectManager.turrents) 

if CanUseSpell(myHero, _E) == READY and Dmg > hp and LastHitE.getValue() and UnderTower(myHero) == false or MinionsAround(GetOrigin(turrentPos), 750) <= LastHitET.getValue() then
CastTargetSpell(M, _E)
end
local EnemyPos3 = GetOrigin(M)
if CanUseSpell(myHero, _Q) == READY and Dmgq > hpq and LastHitQ.getValue() then
CastSkillShot(_Q,EnemyPos3.x,EnemyPos3.y,EnemyPos3.z)
end
end
end
end
end

function YasuoR3()
for _,enemy in pairs(GetEnemyHeroes()) do
if ValidTarget(enemy, 1200) and CanUseSpell(myHero,_R) == READYONCAST and EnemiesAround(GetOrigin(myHero), 1200) > 2 and TFR.getValue() and GotBuff(enemy, "Knockup") >= 1 or GotBuff(enemy, "Knockback") >= 1 or GotBuff(enemy, "yasuoq3ms") >= 1 then
CastSpell(_R)
end
end
end

function YasuoDash2minion()
for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
if ValidTarget(Q, 375) then
if GetCastName(myHero, _E) == "YasuoDashWrapper" and CanUseSpell(myHero, _E) == READY and M2M.getValue() and not ValidTarget(unit, 475) then
CastTargetSpell(Q,_E)
end
end
end
end

function GenerateWallPos(unitPos)
local tV = {x = (unitPos.x-GetMyHeroPos().x), z = (unitPos.z-GetMyHeroPos().z)}
local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
return {x = GetMyHeroPos().x + 400 * tV.x / len, y = 0, z = GetMyHeroPos().z + 400 * tV.z / len}
end

function GenerateSpellPos(unitPos, spellPos, range)
local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end

function UnderTower(p1)
p1 = GetOrigin(p1) or p1
for i,turrent in pairs(objectManager.turrets) do
if GetTeam(turrent) ~= GetTeam(myHero) and ValidTarget(turrent, 1450) then
local turretPos = GetOrigin(turrent)
if GetDistance(myHero, turrentPos) <= 930 then
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


PrintChat("Hi")
