myIAC = IAC()
priority = {} 
unit = GetCurrentTarget()
Config = scriptConfig("CB", "CloudBot")
OnLoop(function(myHero)
Farm()
HitFarm()
AtkE()
JungleFarm()
turrentattack()
barrackattack()
for _, ally1 in pairs (GetAllyHeroes()) do
        local Allyclosest = AllyNearMe(myHeroPos)
        local Ally = GetOrigin(Allyclosest)
        ally2 = GetOrigin(ally1)
if GetDistance(Allyclosest, myHero) > 300 and IsDead(ally1) == false and (GetCurrentHP(myHero)/GetMaxHP(myHero))>.20 and GotBuff(ally1, "recall") == 0 then
MoveToXYZ(Ally.x+100,Ally.y,Ally.z+190)
elseif (GetCurrentHP(myHero)/GetMaxHP(myHero))<.20 then
MoveToXYZ(12,0,30)
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
        if dmg > hp and ValidTarget(k, 500) and GetDistance(myHero, ally1) < 450 then
        AttackUnit(k)
end
end
end
function HitFarm()
   for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
    if ValidTarget(k, 600) and GetDistance(myHero, ally1) < 750 and EnemiesAround(GetOrigin(myHero), 850) == 0 then
        AttackUnit(k)
end
end
end
function JungleFarm()
   for _,k in pairs(GetAllMinions(MINION_JUNGLE)) do
    if ValidTarget(k, 500) and GetDistance(myHero, ally1) > 650 then
        AttackUnit(k)
end
end
end
function AtkE()
for i,enemy in pairs(GetEnemyHeroes()) do
if ValidTarget(enemy, 500) and GetDistance(myHero, ally1) < 650 then
  AttackUnit(enemy)
end
end
end
function turrentattack()
if  ValidTarget(Obj_AI_Turrent, 700) and GetDistance(myHero, ally1) < 650 then
  AttackUnit(Obj_AI_Turret)
end
end
function barrackattack()
if ValidTarget(Obj_AI_Barracks, 700) and GetDistance(myHero, ally1) < 600 then
  AttackUnit(Obj_AI_Barracks)
end
end
