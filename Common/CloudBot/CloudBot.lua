myIAC = IAC()
priority = {}
-- 100 Teams near red buff
point1 = GetOrigin(8024, 51.550800, 3508)
-- 200 Teams Bottom sentry turrent
point2 = GetOrigin(12500, 51.729401, 5182)
-- 200 teams Middle bush near sentrys
point3 = GetOrigin(8256, 50.064091, 10202)
-- 100 teams top sentry near gromp
point4 = GetOrigin(2356, 53.504669, 9674)
unit = GetCurrentTarget()
Config = scriptConfig("CB", "CloudBot")
Config.addParam("U", "Jungle Clear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "AutoFollow", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "Hit Inhibs", SCRIPT_PARAM_ONOFF, true)
Config.addParam("S", "Hit Turrents", SCRIPT_PARAM_ONOFF, true)
Config.addParam("D", "Hit Enemies", SCRIPT_PARAM_ONOFF, true)
Config.addParam("O", "LastHit", SCRIPT_PARAM_ONOFF, true)
Config.addParam("V", "LaneClear", SCRIPT_PARAM_ONOFF, true)
OnLoop(function(myHero)
Farm()
HitFarm()
AtkE()
JungleFarm()
turrentattack()
barrackattack()
local Hero = GetOrigin(myHero)
for _, ally1 in pairs (GetAllyHeroes()) do
        local Allyclosest = AllyNearMe(myHeroPos)
        Ally = GetOrigin(Allyclosest)
        ally2 = GetOrigin(ally1)
if GetDistance(Allyclosest, myHero) > 300 and IsDead(Allyclosest) == false and (GetCurrentHP(myHero)/GetMaxHP(myHero))>.25 and Config.U then
MoveToXYZ(Ally.x+100,Ally.y,Ally.z+190)
 
        elseif (GetCurrentHP(myHero)/GetMaxHP(myHero))<.25 and IsDead(myHero) == false then
 
        if GetTeam(myHero) == 100 and Hero.x == 9222 and Hero.z == 3580 and EnemiesAround(Hero, 1400) == 0 and GotBuff(myHero, "recall") == 0 then
        CastSpell(RECALL)
        elseif GetTeam(myHero) == 100 and GetDistance(myHero, Ally) <= 5000 and GotBuff(myHero, "recall") == 0 then
        MoveToXYZ(9222, 59.105228, 3580)
        end
 
        if GetTeam(myHero) == 200 and Hero.x == 12500 and Hero.z == 5182 and GotBuff(myHero, "recall") == 0 and EnemiesAround(Hero, 1400) == 0 then
        CastSpell(RECALL)
        elseif GotBuff(myHero, "recall") == 0 and GetDistance(myHero, Ally) <= 5000 and GetTeam(myHero) == 200 then
        MoveToXYZ(12500, 51.729401, 5182)
        end

 
end
end
end)
 
function AllyNearMe(pos)
    local ally = nil
    for k,v in pairs(GetAllyHeroes()) do
        if not ally and v then ally = v end
        if ally and v and GetDistanceSqr(GetOrigin(ally),pos) > GetDistanceSqr(GetOrigin(v),pos) then
            ally = v
        end
    end
    return ally
end
 
function Farm()
 for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
        local targetPos = GetOrigin(k)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        local hp = GetCurrentHP(k)
        local dmg = CalcDamage(myHero, k, 50+GetBonusDmg(myHero)+GetBaseDamage(myHero))
        if dmg > hp and ValidTarget(k, 500) and GetDistance(myHero, Ally) <= 450 and Config.O then
        AttackUnit(k)
end
end
end
 
function HitFarm()
   for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
    if ValidTarget(k, 600) and GetDistance(myHero, Ally) <= 400 and EnemiesAround(GetOrigin(myHero), 850) == 0 and Config.V then
        AttackUnit(k)
end
end
end
 
function JungleFarm()
   for _,k in pairs(GetAllMinions(MINION_JUNGLE)) do
    if ValidTarget(k, 500) and GetDistance(myHero, Ally) <= 500 and Config.U then
        AttackUnit(k)
end
end
end
 
function AtkE()
for i,enemy in pairs(GetEnemyHeroes()) do
if ValidTarget(enemy, 500) and GetDistance(myHero, Ally) <= 500 and EnemiesAround(GetOrigin(Obj_AI_Turrent), 800) == 0 and Config.D then
  AttackUnit(enemy)
end
end
end
 
function turrentattack()
for i,turrent in pairs(objectManager.turrets) do
if ValidTarget(turrent, 600) and GetDistance(myHero, Ally) <= 550 and EnemiesAround(GetOrigin(turrent), 800) == 0 and Config.S then
  AttackUnit(turrent)
end
end
end
 
function barrackattack()
for i,barrack in pairs(objectManager.barracks) do
if ValidTarget(barrack, 600) and GetDistance(myHero, Ally) <= 550 and EnemiesAround(GetOrigin(barrack), 800) == 0 and Config.F then
  AttackUnit(barrack)
end
end
end
