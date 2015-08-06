local version = 1
require ("DLib")

up=Updater.new("Cloudhax23/GOS/master/CloudAIO.lua", "CloudAIO", version)
if up.newVersion() then 
	up.update() end
--Menu
if GetObjectName(GetMyHero()) == "Azir" then
--Azir
Config = scriptConfig("Azir", "Azir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

-- Azir W
    if Config.W then
        if GetCastName(myHero, _W) == "AzirW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Azir Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "AzirQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
    -- Azir E
    if Config.E then
        if GetCastName(myHero, _E) == "AzirE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Azir R
             if Config.R then
if GetCastName(myHero, _R) == "AzirR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,250,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end
end)
end

--Viktor
if GetObjectName(GetMyHero()) == "Viktor" then
--Menu
Config = scriptConfig("Viktor", "Viktor")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

-- Viktor W
    if Config.W then
        if GetCastName(myHero, _W) == "ViktorGravitonField" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Viktor Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "ViktorPowerTransfer" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
    -- Viktor E
    local myorigin = GetOrigin(unit)
local mymouse = GetMousePos() 
if Config.E then
        if GetCastName(myHero, _E) == "ViktorDeathRay" then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,525,55,false,true)
if CanUseSpell(myHero, _E) == READY then 
    CastSkillShot3(_E,myorigin,mymouse)
    end
end
end
-- Viktor R
             if Config.R then
if GetCastName(myHero, _R) == "ViktorChaosStorm" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end
end)
end
-- VelKoz
if GetObjectName(GetMyHero()) == "Velkoz" then
--Menu
Config = scriptConfig("VelKoz", "VelKoz")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
 
-- Velkoz E
    if Config.E then
        if GetCastName(myHero, _E) == "VelkozE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end

-- Velkoz W
    if Config.W then
        if GetCastName(myHero, _W) == "VelkozW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Velkoz Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "VelkozQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1050,55,true,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
-- Velkoz R
             if Config.R then
if GetCastName(myHero, _R) == "VelkozR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end
end)
end

if GetObjectName(GetMyHero()) == "Syndra" then
--Menu
Config = scriptConfig("Syndra", "Syndra")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1200) then
 
-- Syndra Q cast
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,true,true)
            if Config.Q then
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
 
-- Syndra cast W on Minion
    if GetCastName(myHero, _W) == "SyndraW" then
            if Config.W then
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- Syndra PUSH
        if GetCastName(myHero, _E) == "SyndraE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,700,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Syndra Ultimate
if GetCastName(myHero, _R) == "SyndraR" then
            if Config.R then
        if unit ~= nil then
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 675) then
    CastTargetSpell(myHero, _R)
                end
            end
        end
    end
end
end
end)
end
-- Ekko
if GetObjectName(GetMyHero()) == "Ekko" then
--Menu
Config = scriptConfig("Ekko", "Ekko")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
    if GetCastName(myHero, _R) == "EkkoR" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) then
            CastTargetSpell(myHero,_R)
            end
        end
    end
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1200) then
 
-- Q cast
        if GetCastName(myHero, _Q) == "EkkoQ" then
                local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1075,50,true,true)
                        if Config.Q then
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
                end
        end
-- W Cast
    if GetCastName(myHero, _W) == "EkkoW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1600,50,false,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- E Cast Will cast E and if im correct then GoS will click champ and Ekko will blink Cast = 325 range Blink= 425
    if GetCastName(myHero, _E) == "EkkoE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- R Cast Disabled till i manage how to Use R when low --THANKS SNOWBALL
    if GetCastName(myHero, _R) == "EkkoR" then
            if Config.R then
            CastTargetSpell(myHero,_R)
            end
        end
    end
end
end)
end
--Nidalee
if GetObjectName(GetMyHero()) == "Nidalee" then
--Menu
Config = scriptConfig("Nidalee", "Nidalee")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Q2", "Use Q2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W2", "Use W2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E2", "Use E2", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
-- Nidalee human heal --THANKS SNOWBALL
            if GetCastName(myHero, _E) == "PrimalSurge" then
        if Config.E then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _E) == READY and IsObjectAlive(myHero) then
            CastTargetSpell(myHero,_E)
        end
    end
end
AutoIgnite()
if IWalkConfig.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1500) then
 
-- Nidalee Human Trap
    if GetCastName(myHero, _W) == "Bushwhack" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- Nidalee human spear
    if GetCastName(myHero, _Q) == "JavelinToss"then
    -- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,true,true)
    if Config.Q then
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
-- Tansform to cougar
if GetCastName(myHero, _R) == "AspectOfTheCougar" then
            if Config.R then
        if unit ~= nil then
    if CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) ~= READY and IsInDistance(unit, 750) and GotBuff(unit, "Hunted") then
    CastTargetSpell(myHero, _R)
                end
            end
        end
    end
-- Cougar attack Q
            if GetCastName(myHero, _Q) == "Takedown" then
        if Config.Q2 then
    if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 475) then
    CastTargetSpell(unit, _Q)
    end
        end
    end
    -- Cougar pounce W
            if GetCastName(myHero, _W) == "Pounce" then
        if Config.W2 then
    if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 375) then
    CastTargetSpell(unit, _W)
            end
        end
    end
    -- E cast in cougar form
            if GetCastName(myHero, _E) == "Swipe" then
        if Config.E2 then
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 300) then
    CastTargetSpell(unit, _E)
            end
        end
    end
-- Transform back
    if GetCastName(myHero, _R) == "AspectOfTheCougar" then
        if Config.R then
            if unit ~= nil then
        if CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _Q) ~= READY then
        CastSpell(_R)
                end
            end
                end
        end
 
        end
            end
    end)
 end
-- Graves
if GetObjectName(GetMyHero()) == "Graves" then
--Menu
Config = scriptConfig("Graves", "Graves")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
        local target = GetCurrentTarget()
        if ValidTarget(target, math.huge) then
                if KeyIsDown(32) then
                        castE(target)
                        castQ(target)
                        castW(target)
                        castR(target)
                end
        end
end
-- End
-- W cast
 )function castW( target )
    if Config.W then
        pred = GetPredictionForPlayer(GetOrigin(target),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_W),900,false,true)
        if IsInDistance(target, GetCastRange(myHero,_W)) and CanUseSpell(myHero,_W) == READY and pred.HitChance == 1 then      
                CastSkillShot(_W,pred.PredPos.x,pred.PredPos.y,pred.PredPos.z)
        end
end
-- Q cast
function castQ( target )
    if Config.Q then
        pred = GetPredictionForPlayer(GetOrigin(target),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_Q),900,false,true)
        if IsInDistance(target, GetCastRange(myHero,_Q)) and CanUseSpell(myHero,_Q) == READY and pred.HitChance == 1 then      
                CastSkillShot(_Q,pred.PredPos.x,pred.PredPos.y,pred.PredPos.z)
        end
end
-- E cast
end
 function castE( target )  
    if Config.E then
            if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY then    
                CastSkillShot(_E, GetMousePos().x, GetMousePos().y, GetMousePos().z)
        end
end
 
-- R cast
-- R cast
function castR( target )
pred = GetPredictionForPlayer(GetOrigin(target),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_R),950,false,true)
        if CanUseSpell(myHero_R) == READY and pred.HitChance == 1 and IsInDistance(target, GetCastRange(myHero,_R)) and Config.R and CalcDamage(myHero, target, (150*GetCastLevel(myHero,_R)+100+1.5*GetBonusDmg(myHero)), 0) > GetCurrentHP(target) then
        CastSkillShot(_R,pred.PredPos.x,pred.PredPos.y,pred.PredPos.z)
        end
  end
end
end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Loaded</font>"))
