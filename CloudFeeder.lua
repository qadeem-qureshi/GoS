myIAC = IAC()
Config = scriptConfig("CF", "CloudFeeder")
Config.addParam("W", "CloudEvade", SCRIPT_PARAM_ONOFF, true)
OnLoop(function(myHero)
local unit = GetCurrentTarget()
local Enemy = GetOrigin(unit)
if ValidTarget(unit) then
MoveToXYZ(Enemy.x-120,Enemy.y,Enemy.z+90)
end
end)
-- Modify from Inspireds code. [CloudFeeder Evade]
OnProcessSpell(function(unit, spell)
  myHero = GetMyHero()
  if Config.W and unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
    if myHero == spell.target and spell.name:lower():find("attack") and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 then
      local wPos = GenerateFeedPos(GetOrigin(unit))
      MoveToXYZ(wPos.x, wPos.y, wPos.z)
    elseif spell.endPos then
      local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
      if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
        local wPos = GenerateFeedPos(GetOrigin(unit))
       MoveToXYZ(wPos.x, wPos.y, wPos.z)
      end
    end
  end
end)
function GenerateFeedPos(unitPos)
    local tV = {x = (unitPos.x-GetMyHeroPos().x), z = (unitPos.z-GetMyHeroPos().z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = GetMyHeroPos().x + 400 * tV.x / len, y = 0, z = GetMyHeroPos().z + 400 * tV.z / len}
end

function GenerateSpellPos(unitPos, spellPos, range)
    local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end

function GenerateDashPos(unitPos)
    local tV = {x = (unitPos.x-GetMyHeroPos().x), z = (unitPos.z-GetMyHeroPos().z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = GetMyHeroPos().x + 475 * tV.x / len, y = 0, z = GetMyHeroPos().z + 475 * tV.z / len}
end
-- end of modify
