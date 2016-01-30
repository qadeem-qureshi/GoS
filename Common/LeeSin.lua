require("Inspired")
require("OpenPredict")
require("DamageLib")
wards = {}
QPred = { delay = 0.25, speed = 1800, width = 60, range = 1100 }

lastWardTime = GetGameTimer()


  Callback.Add("Tick", function() Loop() end)
  Callback.Add("CreateObj", function(obj) CreateObj(obj) end)
  Callback.Add("Draw", function(myHero) OnDraw(myHero) end)
  LoadIOW()

if GetObjectName(GetMyHero()) ~= "LeeSin" then return end

-- Menu
Config = Menu("LeeSin", "LeeSin")
Config:SubMenu("c", "Combo")
Config.c:Boolean("Q1", "Use Q1", true)
Config.c:Boolean("Q2", "Use Q2", true)
Config.c:Boolean("W1", "Use W1", true)
Config.c:Boolean("W2", "Use W2", true)
Config.c:Boolean("E1", "Use E1", true)
Config.c:Boolean("E2", "Use E2", true)

Config:SubMenu("i", "Insec")
Config.i:DropDown("mode", "Insec Mode", 2, {"Manual", "Automatic"})
Config.i:KeyBinding("Insec", "Insec", string.byte("T"))

Config:SubMenu("ks", "Killsteal")
Config.ks:Boolean("KSR","Killsteal with R", true)

Config:SubMenu("m", "misc")
Config.m:KeyBinding("Jump", "Jump Creep/ Ward Jump", string.byte("Z"))
Config.m:Info("blubb","nothing here :P")

ally = nil
extracheck = nil 
wardRange = 600
-- Start
function Loop()
unit = GetCurrentTarget()
enemy = GetCurrentTarget()
  if IOW:Mode() == "Combo" then
    combo(unit)
  end
 if CanUseSpell(myHero, _R) == READY then
  if Config.i.mode:Value() == 1 then
    if Config.i.Insec:Value() then
      MoveToXYZ(GetMousePos())
      if ally ~= nil then
      Insec()
      end
    end
    Callback.Add("WndMsg", function(Msg, Key) OnWndMsg(Msg, Key) end)
  elseif Config.i.Insec:Value() and Config.i.mode:Value() == 2 then
    MoveToXYZ(GetMousePos())
    Insec2()
    InsecLogic()
  end
 end
  if Config.m.Jump:Value() and CanUseSpell(myHero, _W) == READY then
    MoveToXYZ(GetMousePos())
    jump2creep()
    wardjump()
  end
  if KeyIsDown(string.byte("K")) then
    if Config.i.mode:Value() == 1 then
    Config.i.mode:Value(2)
    PrintChat("Automatic insec")
    elseif Config.i.mode:Value() == 2 then
      Config.i.mode:Value(1)
      PrintChat("Manual insec")
      end 
  end
  ks()
  getWard()
end

function OnDraw(myHero)
  for i,unit in pairs(GetEnemyHeroes()) do
    if ValidTarget(unit,1000) then
      if Ready(_R) then
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),getdmg("R",unit ,myHero),0,0xffffffff)
      end
    end
  end
  if ally ~= nil then
    DrawCircle(ally, 100, 1, 100, 0xff00ffff)
  end
end

function combo(unit)
  if ValidTarget(unit, 1100) and Config.c.Q1:Value() and GetCastName(myHero,_Q) =="BlindMonkQOne" then
      local QQPred = GetPrediction(unit, QPred)
    if QQPred and QQPred.hitChance >= .25 and not QQPred:mCollision(1) then
      CastSkillShot(_Q, QQPred.castPos)
    end
  end
  if ValidTarget(unit, 1100) and Config.c.Q1:Value() and GetCastName(myHero,_Q) ~="BlindMonkQOne" then
    CastSpell(_Q)
  end
  if ValidTarget(unit, 350) and Config.c.E1:Value() and GetCastName(myHero, _E) == "BlindMonkEOne" then
    CastSpell(_E)
  end
  if ValidTarget(unit, 350) and Config.c.E2:Value() and GetCastName(myHero, _E) ~= "BlindMonkEOne" then
    CastSpell(_E)
  end
  if ValidTarget(unit, 300) and Config.c.W1:Value() and GetCastName(myHero, _W) ~= "BlindMonkWOne" then
    CastSpell(_W)
  end
  if ValidTarget(unit, 300) and Config.c.W2:Value() and GetCastName(myHero, _W) == "BlindMonkWOne" then
    CastSpell(_W)
  end
end

function getWard()
  for slot = ITEM_1, ITEM_7 do
    local name = myHero:GetSpellData(slot).name
    if name == "TrinketTotemLvl1" then 
      return slot
    elseif name == "VisionWard"  then
      return slot
    elseif name == "ItemGhostWard" then
      return slot
    end
  end
  return nil
end

function calcMaxPos(pos) -- Laiha vayne + ilovesona <3
  local origin = GetOrigin(myHero)
  local vectorx = pos.x-origin.x
  local vectory = pos.y-origin.y
  local vectorz = pos.z-origin.z
  local dist= math.sqrt(vectorx^2+vectory^2+vectorz^2)
  return {x = origin.x + wardRange * vectorx / dist ,y = origin.y + wardRange * vectory / dist, z = origin.z + wardRange * vectorz / dist}
end

function jump2creep()
  creep=ClosestMinion(GetMousePos(), MINION_ALLY)
  if GetDistance(creep, GetMousePos())<=500 then
    CastTargetSpell(creep,_W)
  end
end

function wardjump()
  if GetDistance(GetMousePos(), creep) > 250 and not IsInDistance2(wardRange, GetMousePos()) then
    wardpos = calcMaxPos(GetMousePos())
    wardHop(wardpos)
    elseif GetDistance(GetMousePos(), creep) > 250 and IsInDistance2(wardRange, GetMousePos()) then
      wardHop(GetMousePos())
  end
end

function IsInDistance2(r, p1, p2, fast) -- ilovesona <3 sorry had to take this cause whenever i used your ward jump it gave lag so i stole 2 things.
    local fast = fast or false
    -- local fast = true
    if fast then
      -- faster check, but don't know why still fps drop...
      local p1y = p1.z or p1.y
      local p2y = p2.z or p2.y
      return (p1.x + r >= p2.x) and (p1.x - r <= p2.x) and (p1y + r >= p2y) and (p1y - r <= p2y)
    else
      return GetDistanceSqr(p1, p2) < r*r
    end
end

function wardHop(pos)
  if wardCheck(pos) ~= nil then return end
  if GetGameTimer() - lastWardTime < 1 then return end
  if CanUseSpell(myHero, getWard()) == READY and GetDistance(pos, myHero) <= 600 then
    CastSkillShot(getWard(), pos.x, pos.y, pos.z)

    DelayAction(function()
    if wardCheck(pos) ~= nil then return end
    end, .1)
    lastWardTime = GetGameTimer()
  elseif getWard() and CanUseSpell(myHero, getWard()) == READY then
    pos = Vector(pos)
    pos = Vector(myHero) + Vector(pos - myHero):normalized() * 600
    DrawCircle(pos, 100, 1, 100, 0xff00ffff)
    if wardCheck(pos) ~= nil or CanUseSpell(myHero, _W) ~= READY or GetCastName(myHero, _W) == "blindmonkwtwo" then return end
  if CanUseSpell(myHero, getWard()) == READY and GetDistance(pos, myHero) <= 600 then
    CastSkillShot(getWard(), GetInsecPos(enemy, ally))
      end
    lastWardTime = GetGameTimer()
    DelayAction(function()
    if wardCheck(pos) ~= nil then return end
    end, .1)
    --wardHop(pos)
    end
end

function wardCheck(pos)
  for i, ward in pairs(wards) do
    checkpos = ward
    if GetDistance(ward, pos) <= 550 and CanUseSpell(myHero, _W) == READY then
      CastTargetSpell(ward, _W)
    end
  end
end

function CreateObj(obj)
    if GetObjectBaseName(obj) == "VisionWard" then
      table.insert(wards, obj)
    elseif GetObjectBaseName(obj) == "SightWard" then
      table.insert(wards, obj)
    end
end

function GetInsecPos(a, b)
  if a == nil then a = enemy end
  if b == nil then b = ally end
  if a == nil then return elseif b == nil then return end
  local start = Vector(a.x, a.y, a.z)
  
  local atob = Vector(start - Vector(b.x, b.y, b.z)):normalized() * 200
  local atob = a + atob
  
  return atob
end

function InsecLogic()
  ally2 = ClosestAlly(myHero)
  no2 = false
  ally3 = ClosestTurret(myHero)
  no3 = false
  if GetDistance(myHero, ally2) <= 1500 then
    ally = ally2
  else
    no2 = true
  end
  if no2 == true and GetDistance(myHero, ally3) <= 2000 then
    ally = ally3
  else
    no3 = true
  end
  if no3 == true and no2 == true then 
    if GetTeam(myHero) == 200 then
      ally = Vector(14340, 171, 14390)
    elseif GetTeam(myHero) == 100 then
      ally = Vector(400, 200, 400)
    end
  end 
end

function ClosestTurret(pos)
  local ally = nil
  for k,v in pairs(GetTurrets()) do
  if not ally and v then ally = v end
  if ally and v and v.team == myHero.team and GetDistanceSqr(GetOrigin(ally),pos) > GetDistanceSqr(GetOrigin(v),pos) then
    ally = v
  end
  end
  return ally
end

function Insec()
  if ValidTarget(enemy, 550) and CanUseSpell(myHero, _R) == READY --[[and GetDistance(ally, myHero) <= 2000]] then 
  wardEnd = GetInsecPos(enemy, ally)
    if GetDistance(myHero, wardEnd) >= 150 and CanUseSpell(myHero, _W) == READY then
    wardHop(wardEnd)
    else
    CastTargetSpell(enemy, _R)
    end
    elseif ValidTarget(enemy, 1100) and CanUseSpell(myHero, _Q) == READY then
    local QQPred = GetPrediction(enemy, QPred)
      if GetDistance(myHero, enemy) <= 1100 then
      local QQPred = GetPrediction(unit, QPred)
    if QQPred and QQPred.hitChance >= .25 and not QQPred:mCollision(1) then
      CastSkillShot(_Q, QQPred.castPos)
      CastSpell(_Q)
    end
    end
  end
end

function Insec2()
  if ValidTarget(enemy, 550) and CanUseSpell(myHero, _R) == READY then 
  wardEnd = GetInsecPos(enemy, ally)
    if GetDistance(myHero, wardEnd) >= 150 and CanUseSpell(myHero, _W) == READY then
    wardHop(wardEnd)
    else
    CastTargetSpell(enemy, _R)
    end
    elseif ValidTarget(enemy, 1100) and CanUseSpell(myHero, _Q) == READY then
    local QQPred = GetPrediction(enemy, QPred)
      if GetDistance(myHero, enemy) <= 1100 then
      local QQPred = GetPrediction(unit, QPred)
    if QQPred and QQPred.hitChance >= .25 and not QQPred:mCollision(1) then
      CastSkillShot(_Q, QQPred.castPos)
      CastSpell(_Q)
    end
    end
  end
end

function ks()
  for i,unit in pairs(GetEnemyHeroes()) do
    if Config.ks.KSR:Value() and Ready(_R) and ValidTarget(unit,GetCastRange(myHero,_R)) and GetCurrentHP(unit)+GetDmgShield(unit) < getdmg("R",unit ,myHero) then 
      CastTargetSpell(unit,_R)
    end
  end
end


function OnWndMsg(Msg, Key)
  if Msg == WM_MBUTTONDOWN then
    if GetDistance(enemy, GetMousePos()) > 200 then
      ally = Vector(GetMousePos())
      return
    end
    ally = nil
  end
  if KeyIsDown(string.byte("M")) then
    if Msg == WM_LBUTTONDOWN then
      for _,allie in pairs(GetAllyHeroes()) do
        if GetDistance(allie, GetMousePos()) <= 200 then
          ally = allie 
          return
        end
      end
      ally = nil
    end
  end
end

PrintChat("<font color=\"#00FFFF\">Lee Loaded - Enjoy your game - Logge and Cloud v1.2</font>")
PrintChat("Insec should be really good. Wardjump will not use normal trinket after jungler item purchase same for insec.\nBut if you use manual mode, Click T then select a point by clicking the Middle mouse scroll wheel. If you are in Manual mode and want to insec to an ally, Hold M and left click the ally you want to insec to.")
