require('Interrupter')
-- Here we print chat. 
PrintChat(string.format("<font color='#4682B4'>[Ahri]</font><font color='#FFFFFF'> Loaded</font>"))
PrintChat(string.format("<font color='#FFFFFF'> Do good and make sure you upload results!</font>"))
PrintChat(string.format("<font color='#FFFFFF'> Make sure you select your combo from shift menu.</font>"))
PrintChat(string.format("<font color='#FFFFFF'> Combo 1 = IsCharmed combo will only use spells if the enemy has charm.</font>"))
PrintChat(string.format("<font color='#FFFFFF'> Combo 2 = Fast Combo QWER R no logic.</font>"))
PrintChat(string.format("<font color='#FFFFFF'> Combo 3 = Fast Combo [Recommended] QWER R with HP logic.</font>"))
PrintChat(string.format("<font color='#FFFFFF'> IF YOU HAVE <font color='#FF0000'>RED</font> CIRCLES [DRAWINGS] THEN RELOAD ASAP</font>"))
-- End of print chat
unit = GetCurrentTarget()
mymouse = GetMousePos() 
myIAC = IAC()
supportedHero = {["Ahri"] = true}
class "Ahri"
--Initializing "Ahri"
function Ahri:__init()
-- To save FPS we make everything with functions! Thus the only onloop is used for Ahri:Loop!
OnLoop(function(myHero) self:Loop(myHero) end)
-- Menus! For now i made this IAC and Inspred only but maybe soon something else.
Config = scriptConfig("Ahri", "Ahri")
Config.addParam("LQ", "Use Q LaneClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("LW", "Use W LaneClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("JQ", "Use Q JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("JW", "Use W JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("JE", "Use E JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit Q", SCRIPT_PARAM_ONOFF, false)
Config.addParam("KsQ", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsE", "Use E KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsW", "Use W KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HQ", "Use H-Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HE", "Use H-E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HW", "Use H-W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("EI", "Interrupt With E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item", "Use Zhonya", SCRIPT_PARAM_ONOFF, true)
Combo = scriptConfig("Combo", "Combo")
Combo.addParam("Co2", "Combo 2", SCRIPT_PARAM_ONOFF, false)
Combo.addParam("Co3", "Combo 3", SCRIPT_PARAM_ONOFF, false)
Combo.addParam("Co", "Combo 1", SCRIPT_PARAM_ONOFF, false)
Combo.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Combo.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Combo.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Combo.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max QW",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true) -- Leeched drawings from deftsu kappa
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawDMG", "Draw damage", SCRIPT_PARAM_ONOFF, true)
end


-- End of Ahri Intialize
function Ahri:Loop(myHero)
  -- Since we declared Ahri we can use self: whish refers to Ahri!
if _G.IWalkConfig.Combo and Combo.Co and ValidTarget(unit, 1500)  then
-- This is used to execute the combo if the player is holding the key linked to "Combo"
self:Combo()
end
if _G.IWalkConfig.Combo and Combo.Co2 and ValidTarget(unit, 1500) then
-- This is used to execute the combo if the player is holding the key linked to "Combo"
self:Combo2()
end
if _G.IWalkConfig.Combo and Combo.Co3 and ValidTarget(unit, 1500)  then
-- This is used to execute the combo if the player is holding the key linked to "Combo"
self:Combo3()
end
-- Config.LQ or .LW points to line 13 or 12 if they are true and we are holding the V key (later declared) then we will do (self:Lanclear (this is the function it points to))!
if Config.LQ or Config.LW then
  self:LaneClear()
end
-- This is exactly the same as the note i gave on line number 30!
if Config.JQ or Config.JW or Config.JE then
  self:JungleClear()
end
-- Exactly like line 30!
if Config.KsQ or Config.KsE or Config.KsW then
  self:KillSteal()
end
if Config.Item and ValidTarget(unit, 1000) then
  self:Items()
end
if Config.HQ or Config.HE or Config.HW and ValidTarget(unit, 1000) then
  self:Harass()
end
if LevelConfig.L1 then
  self:LevelUp()
end
if DrawingsConfig.DrawQ or DrawingsConfig.DrawE or DrawingsConfig.DrawW then
  self:Drawings()
end
if DrawingsConfig.DrawDMG then
  self:Drawing()
end
if _G.IWalkConfig.LastHit and Config.F then
self:QFarm()
end
-- The next end will end the function at line 23.
end

function Ahri:LevelUp()     
if LevelConfig.L1 then
if GetLevel(myHero) == 1 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
end
end

function Ahri:Items()
if GetItemSlot(myHero,3157) > 0 and Config.Item and ValidTarget(unit, 1000) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.13 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3157))
        end
end

function Ahri:Combo()
  if Combo.Q and Combo.Co then
    -- Rember line 1 where i said i could use unit? Well I cna use it in even local places! This is how you do prediction currently (exceptions are IAC PredCast)!
    -- Wondering what the numbers are?? (1000 = My skill shot speed 250 = delay on SS 850 = is the range of the SS and 60 = is the width) false = Check for minion collision and true = My hitbox 
  local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1100,250,880,75,false,true)
    -- If the hitchance is == 1 and the current unit has the ahri E buff we will cast q if they dont then it will not cast. I check valid unit in 790 range to make sure we have maximum hitchance! 
  if QPred.HitChance == 1 and GotBuff(unit, "AhriSeduce") == 1 and ValidTarget(unit, 790) then
    -- Here is where we cast the skillshot to the predicted enemy position. Should be very accurate since i have set widths and stuff.
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    -- Here is where the fast combo is. 
end
end
-- Refer to what Q has. the only difference is this is a self spell and requires CastSpell(_W) which casts it on you.
            if Combo.W and Combo.Co then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,550,50,true,true)
                          if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 550) and ValidTarget(unit, 550) and WPred.HitChance == 1 then
CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
end
                 if Combo.E then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero,_E),60,true,true)
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 870) and Config.Co and ValidTarget(unit, 860) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end

      if ValidTarget(unit, 1000) then
            if Combo.R and (GetCurrentHP(unit)/GetMaxHP(unit))<0.38  and Combo.Co then
        CastSkillShot(_R, GetMousePos().x, GetMousePos().y, GetMousePos().z)

end
end
end

function Ahri:Combo2()
  if Combo.Q and Combo.Co2 then
    -- Rember line 1 where i said i could use unit? Well I cna use it in even local places! This is how you do prediction currently (exceptions are IAC PredCast)!
    -- Wondering what the numbers are?? (1000 = My skill shot speed 250 = delay on SS 850 = is the range of the SS and 60 = is the width) false = Check for minion collision and true = My hitbox 
  local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1100,250,880,75,false,true)
    -- If the hitchance is == 1 and the current unit has the ahri E buff we will cast q if they dont then it will not cast. I check valid unit in 790 range to make sure we have maximum hitchance! 
  if QPred.HitChance == 1 and ValidTarget(unit, 790) then
    -- Here is where we cast the skillshot to the predicted enemy position. Should be very accurate since i have set widths and stuff.
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
-- Refer to what Q has. the only difference is this is a self spell and requires CastSpell(_W) which casts it on you.
            if Combo.W and Combo.Co2 then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,550,50,true,true)
                          if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 550) and ValidTarget(unit, 550) and WPred.HitChance == 1 then
CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
end
                 if Combo.E then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero,_E),60,true,true)
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 870) and Config.Co and ValidTarget(unit, 860) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
end
end
      if ValidTarget(unit, 1000) then
        if Combo.R and Combo.Co2 then
        CastSkillShot(_R, GetMousePos().x, GetMousePos().y, GetMousePos().z)

end
end
end


function Ahri:Combo3()
  if Combo.Q and Combo.Co3 then
    -- Rember line 1 where i said i could use unit? Well I cna use it in even local places! This is how you do prediction currently (exceptions are IAC PredCast)!
    -- Wondering what the numbers are?? (1000 = My skill shot speed 250 = delay on SS 850 = is the range of the SS and 60 = is the width) false = Check for minion collision and true = My hitbox 
  local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1100,250,880,75,false,true)
    -- If the hitchance is == 1 and the current unit has the ahri E buff we will cast q if they dont then it will not cast. I check valid unit in 790 range to make sure we have maximum hitchance! 
  if QPred.HitChance == 1 and ValidTarget(unit, 790) then
    -- Here is where we cast the skillshot to the predicted enemy position. Should be very accurate since i have set widths and stuff.
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
-- Refer to what Q has. the only difference is this is a self spell and requires CastSpell(_W) which casts it on you.
            if Combo.W and Combo.Co3 then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,550,50,true,true)
                          if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 550) and ValidTarget(unit, 550) and WPred.HitChance == 1 then
CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
end
                 if Combo.E then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero,_E),60,true,true)
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 870) and Config.Co3 and ValidTarget(unit, 860) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
end
end
      if ValidTarget(unit, 1000) then
        if Combo.R and Combo.Co3 and (GetCurrentHP(unit)/GetMaxHP(unit))<0.38   then
        CastSkillShot(_R, GetMousePos().x, GetMousePos().y, GetMousePos().z)

end
end
end

-- Start lane clear
function Ahri:JungleClear()
   if _G.IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 880) then
        local EnemyPos = GetOrigin(Q)
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.JQ and IsInDistance(Q, 880) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY  and Config.JW and IsInDistance(Q, 550) then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
                        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY  and Config.JE and IsInDistance(Q, 850) then
            CastSkillShot(_E,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end
-- End LaneClear

-- Start JungleClear
function Ahri:LaneClear()
   if _G.IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 880) then
        local EnemyPos = GetOrigin(Q)
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.LQ and IsInDistance(Q, 880) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY  and Config.LW and IsInDistance(Q, 850) then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end
-- End jungle clear

-- Q farm
function Ahri:QFarm()
if _G.IWalkConfig.LastHit then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 790) then
        local z = (GetCastLevel(myHero,_Q)*50)+(GetBonusDmg(myHero)*.7)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.LQ and IsInDistance(Q, 880) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end
end
end
-- End QFarm

-- Start KillsteaL
function Ahri:KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
     local z = (GetCastLevel(myHero,_E)*25)+(GetBonusAP(myHero)*.40)
         local H = (GetCastLevel(myHero,_Q)*50)+(GetBonusAP(myHero)*.70)
         local G = (GetCastLevel(myHero,_W)*35)+(GetBonusAP(myHero)*.50)
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1100,250,880,80,false,true)
    if CanUseSpell(myHero, _Q) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.KsQ and ValidTarget(enemy,850)and CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) then
    CastSkillShot(_Q,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
                    local EPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1100,250,880,80,false,true)
    if CanUseSpell(myHero, _Q) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.KsE and ValidTarget(enemy,850)and CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
end

 local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,550,55,false,true)
    if CanUseSpell(myHero, _W) == READY and QPred.HitChance == 1 and IsInDistance(enemy, 550) and Config.KsW and ValidTarget(enemy,550) and CalcDamage(myHero, enemy, G) > GetCurrentHP(enemy)  then
    CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
end
-- End KillSteal

-- Start drawings (by deftsu)
function Ahri:Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xffff00ff) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xffff00ff) end 
end
-- End drawings
function Ahri:Drawing()
  if ValidTarget(unit, 1500) then
trueDMG = 0
targetPos = GetOrigin(unit)
drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
hp = GetCurrentHP(unit)
if CanUseSpell(myHero,_Q) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (50*GetCastLevel(myHero,_Q)+50+(0.7*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end
-- W
if CanUseSpell(myHero,_W) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (35*GetCastLevel(myHero,_W)+25+10+(0.64*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end 
-- E
        if CanUseSpell(myHero,_E) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (35*GetCastLevel(myHero,_E)+35+(0.50*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end 
-- R
if CanUseSpell(myHero,_R) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (120*GetCastLevel(myHero,_R)+70+(0.9*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end 
            if trueDMG > hp then
      DrawText("Killable",20,drawPos.x,drawPos.y,0xff00ff00)
      DrawDmgOverHpBar(unit,hp,0,hp,0xff00ff00)
    else
      DrawText(math.floor(100 * trueDMG / hp).."%",20,drawPos.x,drawPos.y,0xff00ff00)
      DrawDmgOverHpBar(unit
      ,hp,0,trueDMG,0xff00ff00)
end
end
end

-- Start Harass
function Ahri:Harass()
                if _G.IWalkConfig.Harass then
                if Config.HQ then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1100,250,GetCastRange(myHero, _Q),80,false,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .40 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
                    if Config.HE then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero, _E),60,true,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .40 and ValidTarget(unit, 880) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
end
end
            if Combo.HW then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,550,50,true,true)
                          if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 550) and ValidTarget(unit, 550) and WPred.HitChance == 1 then
CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
end
end
end
addInterrupterCallback(function(unit, spellType)
  if IsInDistance(unit, 890) and CanUseSpell(myHero,_E) == READY then
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero, _E),60,true,true)
 if Config.EI and EPred.HitChance == 1 and ValidTarget(unit, 790) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)   
end
end
end)



if supportedHero[GetObjectName(myHero)] == true then
if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end 
end
