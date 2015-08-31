PrintChat("D3ftland Jinx By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Jinx", "Jinx")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E (beta)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Qfarm", "Switch Q in X/V", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item5", "Use Mercurial", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()

if MiscConfig.Autolvl then
LevelUp()
end

if GetItemSlot(myHero,3140) > 0 and MiscConfig.Item4 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3140))
end

if GetItemSlot(myHero,3139) > 0 and MiscConfig.Item5 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3139))
end

local target = GetTarget(2500, DAMAGE_PHYSICAL)

    if CanUseSpell(myHero, _Q) == READY and Config.Q and ValidTarget(target, 700) then
        if GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
        CastSpell(_Q)
        elseif GetDistance(myHero, target) < 570 and GotBuff(myHero, "JinxQ") > 0 then
        CastSpell(_Q)
        end
    end
    
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,700,2500,140,false,true)
    
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target, 1000) and Config.E then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
    
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_W)) and Config.W then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end
    
    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(target, 2500) and Config.R and GetCurrentHP(target) < CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GetDistance(target)/1700))) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
    end
    
    if GetItemSlot(myHero,3153) > 0 and Config.Item1 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
    CastTargetSpell(target, GetItemSlot(myHero,3153))
    end

    if GetItemSlot(myHero,3144) > 0 and Config.Item2 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
    CastTargetSpell(target, GetItemSlot(myHero,3144))
    end

    if GetItemSlot(myHero,3142) > 0 and Config.Item3 then
    CastTargetSpell(GetItemSlot(myHero,3142))
    end
   
  
local target = GetTarget(1500, DAMAGE_PHYSICAL)
    if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, 700) then
        if GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
        CastSpell(_Q)
        elseif GetDistance(myHero, target) < 570 and GotBuff(myHero, "JinxQ") > 0 then
        CastSpell(_Q)
        end
    end
    
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
    
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_E)) and HarassConfig.HarassE then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
    
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_W)) and HarassConfig.HarassW then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end
  
  if IWalkConfig.LastHit then
    if GotBuff(myHero, "JinxQ") > 0 and Config.Qfarm then
    CastSpell(_Q)
    end
  end
  
  if IWalkConfig.LaneClear then
    if GotBuff(myHero, "JinxQ") > 0 and Config.Qfarm then
    CastSpell(_Q)
    end
  end
end)

function Killsteal()
    for i,enemy in pairs(GetEnemyHeroes()) do
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),3300,600,GetCastRange(myHero,_W),60,true,true)
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2300,700,4000,140,false,true)
       if CanUseSpell(myHero, _W) == READY and ValidTarget(enemy, GetCastRange(myHero,_W)) and KSConfig.KSW and WPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 50*GetCastLevel(myHero,_Q) - 40 + 1.4*GetBaseDamage(myHero)) then  
       CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
       elseif CanUseSpell(myHero, _R) == READY and ValidTarget(enemy, 4000) and GetDistance(myHero, enemy) > 400 and KSConfig.KSR and RPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, (GetMaxHP(enemy)-GetCurrentHP(enemy))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GetDistance(enemy)/1700))) then 
       CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
       end
    end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
    LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
    LevelSpell(_E)
elseif GetLevel(myHero) == 3 then
    LevelSpell(_W)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
    LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
    LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
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

function Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end

local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
MiscConfig.addParam("Baseult", "Baseult", SCRIPT_PARAM_ONOFF, true)
myHero = GetMyHero()

if GetTeam(myHero) == 100 then 
enemyBasePos = Vector(14340, 171, 14390)
elseif GetTeam(myHero) == 200 then 
enemyBasePos = Vector(400, 200, 400)
end

if GetObjectName(myHero) == "Jinx" then
    delay = 600
    missileSpeed = 2300
    damage = function(target) return CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R)) + 150 + 100*GetCastLevel(myHero,_R) + GetBonusDmg(myHero)) end
end

local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = true
MiscConfig.addParam("Recalltracker", "Recall tracker", SCRIPT_PARAM_ONOFF, true)

OnLoop(function()
if MiscConfig.Recalltracker then
    local i = 0
    for hero, recallObj in pairs(recalling) do
        local percent=math.floor(GetCurrentHP(recallObj.hero)/GetMaxHP(recallObj.hero)*100)
        local color=percentToRGB(percent)
        local leftTime = recallObj.starttime - GetTickCount() + recallObj.info.totalTime
        
        if leftTime<0 then leftTime = 0 end
        FillRect(x,y+rowHeight*i-2,168,rowHeight,0x50000000)
        if i>0 then FillRect(x,y+rowHeight*i-2,168,1,0xC0000000) end
        
        DrawText(string.format("%s (%d%%)", hero, percent), 14, x+2, y+rowHeight*i, color)
        
        if recallObj.info.isStart then
            DrawText(string.format("%.1fs", leftTime/1000), 14, x+115, y+rowHeight*i, color)
            FillRect(x+169,y+rowHeight*i, barWidth*leftTime/recallObj.info.totalTime,14,0x80000000)
        else
            if recallObj.killtime == nil then
                if recallObj.info.isFinish and not recallObj.info.isStart then
                recallObj.result = "finished"
                recallObj.killtime =  GetTickCount()+2000
                elseif not recallObj.info.isFinish then
                recallObj.result = "cancelled"
                recallObj.killtime =  GetTickCount()+2000
                end
                
            end
            DrawText(recallObj.result, 14, x+115, y+rowHeight*i, color)
        end
        
        if recallObj.killtime~=nil and GetTickCount() > recallObj.killtime then
            recalling[hero] = nil
        end
        
        i=i+1
    end
end
end)

function percentToRGB(percent) 
    local r, g
    if percent == 100 then
        percent = 99 end
        
    if percent < 50 then
        r = math.floor(255 * (percent / 50))
        g = 255
    else
        r = 255
        g = math.floor(255 * ((50 - percent % 50) / 50))
    end
    
    return 0xFF000000+g*0xFFFF+r*0xFF
end

OnProcessRecall(function(Object,recallProc)
    if CanUseSpell(myHero, _R) == READY and MiscConfig.Baseult and GetTeam(Object) ~= GetTeam(myHero) then
        if damage(Object) > GetCurrentHP(Object) then
            local timeToRecall = recallProc.totalTime
            local distance = GetDistance(enemyBasePos)
            local timeToHit = delay + (distance * 1000 / missileSpeed)
            if timeToRecall > timeToHit then
                recallPos = Vector(Object)
                print("BaseUlt on "..GetObjectName(Object), 2, 0xffff0000)
                DelayAction(
                    function() 
                        if recallPos == Vector(Object) then
                        CastSkillShot(_R, enemyBasePos.x, enemyBasePos.y, enemyBasePos.z)
                        recallPos = nil
                        end
                    end, 
                    timeToRecall-timeToHit
                )
            end
        end
    end
    
    
    if onlyEnemies and GetTeam(GetMyHero())==GetTeam(Object) then return end
    if onlyFOW and recalling[GetObjectName(Object)] == nil  and IsVisible(Object) then return end
    
    rec = {}
    rec.hero = Object
    rec.info = recallProc
    rec.starttime = GetTickCount()
    rec.killtime = nil
    rec.result = nil
    recalling[GetObjectName(Object)] = rec
    
end)
