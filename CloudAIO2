local version = 5.4
--[[
█▀▀█ █░░ █▀▀█ █░░█ █▀▀▄ ░█▀▀█ ▀█▀ ▒█▀▀▀█ 
█░░░ █░░ █░░█ █░░█ █░░█ ▒█▄▄█ ▒█░ ▒█░░▒█ 
█▄▄█ ▀▀▀ ▀▀▀▀ ░▀▀▀ ▀▀▀░ ▒█░▒█ ▄█▄ ▒█▄▄▄█

────(♥)(♥)(♥)────(♥)(♥)(♥) __ ɪƒ ƴσυ'ʀє αʟσηє,
──(♥)██████(♥)(♥)██████(♥) ɪ'ʟʟ ɓє ƴσυʀ ѕɧα∂σѡ.
─(♥)████████(♥)████████(♥) ɪƒ ƴσυ ѡαηт тσ cʀƴ,
─(♥)██████████████████(♥) ɪ'ʟʟ ɓє ƴσυʀ ѕɧσυʟ∂єʀ.
──(♥)████████████████(♥) ɪƒ ƴσυ ѡαηт α ɧυɢ,
────(♥)████████████(♥) __ ɪ'ʟʟ ɓє ƴσυʀ ρɪʟʟσѡ.
──────(♥)████████(♥) ɪƒ ƴσυ ηєє∂ тσ ɓє ɧαρρƴ,
────────(♥)████(♥) __ ɪ'ʟʟ ɓє ƴσυʀ ѕɱɪʟє.
─────────(♥)██(♥) ɓυт αηƴтɪɱє ƴσυ ηєє∂ α ƒʀɪєη∂,
───────────(♥) __ ɪ'ʟʟ ʝυѕт ɓє ɱє.
--]]
function prequire(m) 
  local ok, err = pcall(require, m) 
  if not ok then return nil, err end
  return err
end

function requireDL(script, address, retry)
  local retry = retry or 0
  local status, module = pcall(require, script)
  
  if not status and retry<4 then
	retry=retry+1
    response=webRequest("github", address.."?rand="..math.random(1,10000))
    if response~=nil then
      saveScript("Common\\"..script, response) end
    requireDL(script, address, retry)
  else
    if retry==4 then
      MessageBox(0,"Unable to download library "..script,"Error!",0) end

  end
  if retry>0 then
	s, module = pcall(require, script) end
  return module
end
Updater={}
function Updater.new(address, name, version)
	local this = {}
	this.address=address
	this.version=version
	this.name=name
	
	function this.newVersion()
		if not updaterActive.getValue() or not g then return false end
		this.response=webRequest("github", this.address.."?rand="..math.random(1,10000))
		if this.response==nil then return false end
		this.remoteVersion = string.match(this.response, "local version = %d+")
		if this.remoteVersion==nil then 
			this.response=nil
			return false 
		end
		this.remoteVersion = tonumber(string.match(this.remoteVersion, "%d+"))
	return this.remoteVersion>this.version
	end
	
	function this.update()
		if this.response==nil then end
		saveScript(this.name, this.response)
		delay(function() notification(this.name.." updated.\n F6-F6 to reload.", 5000) end, 5000)
	end
	return this
end
g=prequire("GOSUtility")
if g then
	local UP=Updater.new("Cloudhax23/GoS/blob/master/CloudAIO.lua", "Common\\CloudAIO", version)
	if UP.newVersion() then UP.update() end
else
	PrintChat("GOSUtility.dll not found. Functions using GOSUtility won't work.")
end
--Version 5.3 *NEW* All info in thread!

-- Varus
myIAC = IAC()
unit = GetCurrentTarget()
mymouse = GetMousePos() 
supportedHero = {["Akali"] = true ,["Alistar"] = true ,["Gnar"] = true ,["Azir"] = true ,["Brand"] = true ,["Cassiopeia"] = true,["Ekko"] = true ,["Evelynn"] = true ,["Fiora"] = true ,["Gangplank"] = true  ,["Graves"] = true ,["Irelia"] = true ,["Khazix"] = true ,["Leona"] = true ,["Riven"] = true ,["Rumble"] = true ,["Sona"] = true ,["Swain"] = true ,["Syndra"] = true ,["Udyr"] = true ,["Varus"] = true ,["Velkoz"] = true ,["Vi"] = true ,["Viktor"] = true ,["Vladimir"] = true ,["Yasuo"] = true,["Ziggs"] = true}

-- Cassiopeia
class "Cassiopeia"
function Cassiopeia:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Cassiopeia", "Cassiopeia")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use Smart E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Es", "Use E", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Z", "LaneClear E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("U", "LaneClear W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "LaneClear Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("S", "Use HP W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("D", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("O", "Use E KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("V", "Use W KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end

--Start
function Cassiopeia:Loop(myHero)
    self:Checks() 
      if Config.D or Config.O or Config.V then
    self.KS() 
end
 if Config.Z or Config.I or Config.U then
    self.LaneClear()
end
 if Config.F then
    self.LastHit()
end
if Config.Es then
    self.CastEs()
end
if Config.Q and ValidTarget(unit,850) then
    self.CastQ()
end
if Config.W and ValidTarget(unit,850) then
    self.CastW()
end
if Config.E and ValidTarget(unit,850) then
    self.CastE()
end
  if _G.IWalkConfig.Combo and ValidTarget(unit, 1000) then
    self:Combo()
  end
end
function Cassiopeia:Combo()
	self.CastQ()
	self.CastW()
	self.CastE()
	self.CastR()
end
  function Cassiopeia:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

-- Cassiopeia E
function Cassiopeia:CastE()
if IsInDistance(unit, 700) and Config.E and Config.Combo and GotBuff(unit, "cassiopeianoxiousblastpoison") == 1 or GotBuff(unit, "cassiopeiamiasmapoison") == 1 or GotBuff(unit, "cassiopeiatwinfangdebuff") == 1 or GotBuff(unit, "poison") == 1 then
    CastTargetSpell(unit, _E)
end
end
function Cassiopeia:CastEs()
if IsInDistance(unit, 700) and Config.Combo and Config.Es then
    CastTargetSpell(unit, _E)
end
end
-- Cassiopeia W
function Cassiopeia:CastW()
    if Config.W then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 850) and Config.Combo then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
          end
-- Cassiopeia Q
function Cassiopeia:CastQ()
	local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1000,250,850,60,false,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and IsInDistance(unit, 850) and Config.Q and Config.Combo then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
              end
-- Cassiopeia R
function Cassiopeia:CastR()
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,825,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 700) and EnemiesAround(GetMyHeroPos(), 825) >= 3 and Config.Combo and ValidTarget(unit, 825) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
        end
            -- END

function Cassiopeia:LaneClear()
   if _G.IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 700) then
            if Config.Z then
        local EnemyPos = GetOrigin(Q)
                    if CanUseSpell(myHero, _E) == READY and IsInDistance(Q, 700) and Config.Z and GotBuff(Q, "cassiopeianoxiousblastpoison") == 1 or GotBuff(Q, "cassiopeiamiasmapoison") == 1 or GotBuff(Q, "cassiopeiatwinfangdebuff") == 1 then
            CastTargetSpell(Q, _E)
    end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.I and IsInDistance(Q, 850) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY  and Config.U and IsInDistance(Q, 850) then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
end
end
end
end
end
function Cassiopeia:LastHit()
   if _G.IWalkConfig.LastHit then
          if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 700) then
        local z = (GetCastLevel(myHero,_E)*25)+(GetBonusAP(myHero)*.55)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        local Fmg = CalcDamage(myHero, Q, H)
        if Dmg > hp then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(Q, _E)
            end
        end
          end
        end
      end
        end

   end
function Cassiopeia:KS()
for i,enemy in pairs(GetEnemyHeroes()) do
local z = (GetCastLevel(myHero,_E)*25)+(GetBonusAP(myHero)*.55)
         local H = (GetCastLevel(myHero,_Q)*40)+(GetBonusAP(myHero)*.45)
         local G = (GetCastLevel(myHero,_W)*45)+(GetBonusAP(myHero)*.90)
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _Q) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.D and ValidTarget(enemy,850)and CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) then
    CastSkillShot(_Q,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
if CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) and IsInDistance(enemy, 700) and ValidTarget(enemy,850) and Config.O then
    CastTargetSpell(enemy, _E)
end
 local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and QPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.V and ValidTarget(enemy,850) and CalcDamage(myHero, enemy, G) > GetCurrentHP(enemy)  then
    CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
end

class "Vladimir"
function Vladimir:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Vladimir", "Vladimir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Z", "LaneClear E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("U", "LaneClear W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "LaneClear Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Y", "LastHit Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("S", "Use HP W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("D", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("O", "Use E KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Vladimir:Loop(myHero)
    self:Checks() 
      if Config.D or Config.O then
    self.KS() 
end
      if Config.S then
    self.SaveMeW() 
end
 if Config.Z or Config.I or Config.U then
    self.LaneClear()
end
 if Config.F or Config.Y then
    self.LastHit()
end
  if _G.IWalkConfig.Combo and ValidTarget(unit, 1000) then
    self:Combo()
  end
end
  function Vladimir:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Vladimir:Combo()
	self.CastQ()
	self.CastW()
	self.CastE()
	self.CastR()
end
 
-- Vladimir E
function Vladimir:CastE()
    if Config.E then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 610) and Config.Combo then
            CastSpell(_E)
            end
        end
      end

-- Vladimir W
function Vladimir:CastW()
    if Config.W then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 150) and Config.Combo then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
          end
-- Vladimir Q
function Vladimir:CastQ()
            if Config.Q then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(unit) and IsInDistance(unit, 600) and Config.Combo then
            CastTargetSpell(unit,_Q)
            end
        end
      end
-- Vladimir R
function Vladimir:CastR()
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*112)+(GetBonusAP(myHero)*0.78)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 700) and CalcDamage(myHero, unit, ult) and Config.Combo then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
          end

function Vladimir:LaneClear()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            if Config.Z then
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(Q, 610) then
            CastSpell(_E)
    end
                if CanUseSpell(myHero, _W) == READY and IsInDistance(Q, 150) and Config.U then
            CastSpell(_W)
    end
                    if CanUseSpell(myHero, _Q) == READY and IsInDistance(Q, 600) and Config.I then
            CastTargetSpell(Q, _Q)
    end
    end
end
end
end
end
function Vladimir:LastHit()
   if IWalkConfig.LastHit then
          if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 610) then
        local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusAP(myHero)*.45)
         local H = (GetCastLevel(myHero,_Q)*35)+(GetBonusAP(myHero)*.60)

        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        local Fmg = CalcDamage(myHero, Q, H)
        if Dmg > hp then
if CanUseSpell(myHero, _E) == READY then
    CastSpell(_E)
            end
            if Fmg > hp then
            if Config.Y then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(Q) and IsInDistance(Q, 600) then
            CastTargetSpell(Q,_Q)
            end
          end
        end
          end
        end
      end
        end

   end
end
function Vladimir:SaveMeW()
if Config.S then
if CanUseSpell(myHero, _W) and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.15 and GotBuff(myHero, "recall") == 0 and ValidTarget(unit, 800) then
  CastSpell(_W)
end
end
end
function Vladimir:KS()
for i,enemy in pairs(GetEnemyHeroes()) do
local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusAP(myHero)*.45)
         local H = (GetCastLevel(myHero,_Q)*35)+(GetBonusAP(myHero)*.60)
          if CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) and IsInDistance(enemy, 600) and ValidTarget(enemy, 800) and Config.D then
    CastTargetSpell(enemy, _Q)
end
if CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) and IsInDistance(enemy, 610) and Config.O and ValidTarget(enemy, 800) then
    CastSpell(_E)
end
end
end

class "Varus"
function Varus:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Varus", "Varus")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Varus:Loop(myHero)
    self:Checks()  
    if Config.F then
    self.LaneClear()
end
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Varus:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
 
-- Varus E
function Varus:CastE(unit)
    if Config.E then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Varus W
-- Varus Q
function Varus:CastQ(unit)
    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 1625) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1625, 250 do
        DelayAction(function()
            local _Qrange = 225 + math.min(225, i/2)
              local Pred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1625,50,false,true)
              if Pred.HitChance >= 1 then
                CastSkillShot2(_Q, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
              end
          end, i)
      end
    end
  end
-- Varus R
function Varus:CastR(unit)
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
      end
                              function Varus:Combo()
  if ValidTarget(self.target, 1700)  then       
    elseif self.QREADY then
      self:CastQ(self.target) 
               elseif self.EREADY then
      self:CastE(self.target) 
                elseif self.RREADY then
      self:CastR(self.target)          
end
end
function Varus:LaneClear()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            if Config.F then
-- Syndra cast W at Enemy
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY then
            CastSkillShot(_E,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
    end
end
end
end
end

class "Ziggs"
function Ziggs:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Ziggs", "Ziggs")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsQ", "Use Q in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("KsW", "Use W in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("KsR", "Use R in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("H", "Use Q Harass", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Z", "Use E Harass", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max QE",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
--Start
function Ziggs:Loop(myHero)
    self:Checks() 

        if Config.KsQ or Config.KsW or Config.KsE then
    self.Killsteal() 
end
        if DrawingsConfig.DrawQ or DrawingsConfig.DrawW or DrawingsConfig.DrawE then
    self:Drawings()
  end
             if _G.IWalkConfig.LaneClear then
    self:LaneClear()
  end
        if LevelConfig.L1 then
    self:LevelUp()
  end
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
    if _G.IWalkConfig.Harass then
    self:Harass()
  end
end
  function Ziggs:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Ziggs:Combo()
	self.CastQ()
	self.CastW()
	self.CastE()
	self.CastR()
end

                 -- Ziggs Q
function Ziggs:CastQ()
                         if Config.Q then
        if GetCastName(myHero, _Q) == "ZiggsQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Combo and ValidTarget(unit, 1000) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
        -- Ziggs E
        function Ziggs:CastE()
                 if GetCastName(myHero, _E) == "ZiggsE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.Combo and ValidTarget(unit, 1000) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
    -- Ziggs W
    function Ziggs:CastW()
   if GetCastName(myHero, _W) == "ZiggsW" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,5300,50,false,true)
                          if ValidTarget(unit, 1000) and (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsObjectAlive(myHero) and IsInDistance(unit, 1000) and Config.Combo then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
-- Ziggs R
function Ziggs:CastR()
   if GetCastName(myHero, _R) == "ZiggsR" then
                 if Config.R then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,5300,55,false,true)
        local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.5)
        if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
       if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and Config.Combo and ValidTarget(unit, 1000) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                    end
                end
            end
        end
      end

function JungleClear()
    for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 650) then
            if Config.J then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
end
end
end
end
function Ziggs:LevelUp()     
if LevelConfig.L1 then
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
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end
end
end
function Ziggs:Killsteal()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*45)+(GetBonusAP(myHero)*1))
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KsQ 
  and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
   if GetCastName(myHero, _R) == "ZiggsR" then
                 if Config.KsR then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,5300,55,false,true)
        local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.5)
        if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
       if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                    end
                end
            end
    end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*35)+(GetBonusAP(myHero)*.5)
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
end
end
function Ziggs:LaneClear()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
         local EnemyPos = GetOrigin(Q)
          if IsInDistance(Q, 650) then
            if Config.F then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
            if CanUseSpell(myHero, _W) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
        end
    end
end
end
end

function Ziggs:Harass()
                if IWalkConfig.Harass then
                if Config.H then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
    end
  end
    if Config.Z then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if CanUseSpell(myHero, _E) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_E,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
    end
end
function Ziggs:Drawings()
    myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xffff00ff) end
end

--Syndra
class "Syndra"
function Syndra:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Syndra", "Syndra")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsQ", "Use Q in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsW", "Use W in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsR", "Use R in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("J", "JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("H", "Use Q Harass", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Y", "Use W Harass", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Stun", "QE Snipe", SCRIPT_PARAM_KEYDOWN, string.byte("T")) --Maxxel logic
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max QW",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
end
--Start
  function Syndra:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Syndra:Loop(myHero)
    self:Checks() 

        if Config.Stun then
    self.Stun() 
end
        if Config.KsQ or Config.KsW or Config.KsR then
    self.Killsteal() 
end
             if _G.IWalkConfig.LaneClear then
    self:LaneClear()
  end
        if LevelConfig.L1 then
    self:LevelUp()
  end
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
    if _G.IWalkConfig.Harass and Config.H or Config.Y then
    self:Harass()
  end
end
  function Syndra:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
-- Syndra Q cast
function Syndra:Combo()
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,false,true)
            if Config.Q then
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(unit, 1000) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
    end
-- Syndra cast W on Minion

            if Config.W then
            if CanUseSpell(myHero, _W) == READY and ValidTarget(unit, 1000) then
            CastTargetSpell(Obj_AI_Minion, _W)
        end
    end
-- Syndra cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,false,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(unit, 1000) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
    end
-- Syndra PUSH
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,700,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(unit, 1000) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
end
-- Syndra Ultimate

            if Config.R then
        if unit ~= nil then
         local ult = (GetCastLevel(myHero,_R)*135)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 675) then
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and ValidTarget(unit, 1000) then
    CastTargetSpell(unit, _R)
                end
        end
    end
end
end

function Syndra:LevelUp()     
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
        LevelSpell(_E)
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

function Syndra:Killsteal()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*45)+(GetBonusAP(myHero)*1.6))
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,true,true)
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KsQ 
  and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
        if GetCastName(myHero, _R) == "SyndraR" then
            if Config.KsR then
        if unit ~= nil then
         local ult = (GetCastLevel(myHero,_R)*135)+(GetBonusAP(myHero)*1.5)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 675) then
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastTargetSpell(unit, _R)
                end
            end
        end
    end
end
            if GetCastName(myHero, _W) == "SyndraW" then
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*40)+(GetBonusAP(myHero)*1)
            if CanUseSpell(myHero, _W) == READY then if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*40)+(GetBonusAP(myHero)*1)

            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
        end
    end
end
end
function Syndra:Stun()
local unit = GetCurrentTarget() --Maxxxel logic
local myHeroPos = GetOrigin(myHero)
    if Config.Stun then
        if ValidTarget(unit,1200) then
            local timea
            local distanceStun=0
            if timea~=nil and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _E) ~= READY then
                timea=nil
            end
        ---Values---
            local enemyposition = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1200,50,true,true)
            enemyposx=enemyposition.PredPos.x
            enemyposy=enemyposition.PredPos.y
            enemyposz=enemyposition.PredPos.z
            local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
            if GetDistance(unit)>=700 then
                distanceStun=GetDistance(unit)-700
            end
            if GetDistance(unit)<700 then
                distanceStun=0
            end
            local firePos = TargetPos-(TargetPos-myHeroPos)*(distanceStun/GetDistance(unit)) 
            local dPredict = GetDistance(myHero,firePosPoint)
        ---Values end---
            if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and timea==nil then
                if dPredict < 1200 then
                    CastSkillShot(_Q,firePos.x,0,firePos.z)
                    timea = GetTickCount()
                end
            end
            if CanUseSpell(myHero, _E) == READY and timea~=GetTickCount() then
                    CastSkillShot(_E,firePos.x,0,firePos.z)
            end
        end
        Move()
    end
    end
    function Move()
    local movePos = GenerateMovePos()
    if GetDistance(GetMousePos()) > GetHitBox(myHero) then
        MoveToXYZ(movePos.x, 0, movePos.z)
    end
    end
function Syndra:LaneClear()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do

          if IsInDistance(Q, 700) then
            if Config.F then
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end
    end
        if GetCastName(myHero, _W) == "SyndraW" then
local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end

-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end

end
end
end
end

function Syndra:Harass()
                if IWalkConfig.Harass then
                if Config.H then
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
        if GetCastName(myHero, _W) == "SyndraW" then
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
end
function Syndra:Drawing()
    myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xffff00ff) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_R) ,3,100,0xffff00ff) end
end
end

 


-- kalista
if GetObjectName(GetMyHero()) == "Kalista" then
--Menu
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Rs", "Use R Save", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "E Clear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Z", "Spam E", SCRIPT_PARAM_KEYDOWN, string.byte("C"))
Config.addParam("M", "Execute Jungle", SCRIPT_PARAM_ONOFF, true)
Config.addParam("N", "Auto E Kill", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "KS Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("G", "Send Ghost", SCRIPT_PARAM_KEYDOWN, string.byte("T"))
Config.addParam("X", "Wall Jump 1", SCRIPT_PARAM_KEYDOWN, string.byte("L"))
Config.addParam("Y", "Wall Jump 2", SCRIPT_PARAM_KEYDOWN, string.byte("K"))
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
ItemsConfig = scriptConfig("Items", "Items")
ItemsConfig.addParam("I4","Use QSS",SCRIPT_PARAM_ONOFF,true)
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max EQ",SCRIPT_PARAM_ONOFF,false)
LevelConfig.addParam("L2","Max EW",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawDMG", "Draw Damage", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawQW", "Draw Wall Jump", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
Killsteal()
AutoIgnite()
Drawings()
LevelUpMeleeSupport()
LevelUp() 
LaneClear()
JungleClear()
Ghost()
WallJump()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

if DrawingsConfig.DrawDMG then
local hp  = GetCurrentHP(unit)
local dmg = 0
local targetPos = GetOrigin(unit)
local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
    if CanUseSpell(myHero, _Q) == READY then
      local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
          dmg = dmg + CalcDamage(myHero, unit, GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
    end
    if CanUseSpell(myHero, _E) == READY then
      dmg = dmg + CalcDamage(myHero, unit, 0, 10 + 10*GetCastLevel(myHero,_E) + 0.6*GetBonusDmg(myHero))
    end
    if dmg > hp then
      DrawText("Killable",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(unit,hp,0,hp,0xffffffff)
    else
      DrawText(math.floor(100 * dmg / hp).."%",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(unit
      ,hp,0,dmg,0xffffffff)
    end
end
if GetItemSlot(myHero,3140) > 0 and ItemsConfig.I4 and GotBuff(myHero, "Stun") == 1 then
CastTargetSpell(unit, GetItemSlot(myHero,3140))
end
if GetItemSlot(myHero,3139) > 0 and ItemsConfig.I4 and GotBuff(myHero, "Stun") == 1 then
CastTargetSpell(unit, GetItemSlot(myHero,3139))
end
                 if Config.Q then
                                             local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1150,50,true,true)
            if CanUseSpell(myHero, _Q) == READY then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
                                  --kalista E
                 
              if Config.E then
   local Dmgz= GetBonusDmg(myHero)+GetBaseDamage(myHero)
 local dmg = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (GetCastLevel(myHero,_E) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
   if CalcDamage(myHero, unit, dmg) > GetCurrentHP(unit)  then
                  if CanUseSpell(myHero,_E) == READY then
                    CastSpell(_E)
                  end
                end
              end
                if IWalkConfig.Harass then
                if Config.Z then
              if GotBuff(unit,"kalistaexpungemarker") > 4 then
                if CanUseSpell(myHero,_E) == READY and IsInDistance(unit, 1200) then
                  CastSpell(_E)
                end
              end
            end
        end
    -- Cast R
            if Config.R then
                  if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and
                    IsObjectAlive(unit) and
                   CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1200) and EnemiesAround(GetMyHeroPos(), 1400) >= 2 then
            CastSpell(_R)
            end
        end
end
end
end)
-- LanClear
function LaneClear()
if IWalkConfig.LaneClear then
      if Config.F then
       for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
            local dmg = (GotBuff(Q,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(Q,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
            local hp = GetCurrentHP(Q)
            local Dmg = CalcDamage(myHero, Q, dmg)
            if Dmg > hp then
            if CanUseSpell(myHero,_E) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .35 then
            CastSpell(_E) 
           end
        end
     end
  end
end
end
end
function Ghost() 
if Config.G then
if CanUseSpell(myHero, _W) == READY then
CastSkillShot(_W,10092.000000, -71.240601, 4452.000000)
end
end
end
          function WallJump()
           local HeroPos = GetOrigin(myHero)
        if Config.X and HeroPos.x == 11972 and HeroPos.z == 4708 then                
                          CastSkillShot(_Q,11572, -71.240601, 4102)  
                          MoveToXYZ(11572, -71.240601, 4102) 
                          elseif Config.X then 
                             MoveToXYZ(11972, 59.729401, 4708)  

    end
        if Config.Y and HeroPos.x == 9022 and HeroPos.z == 4360 then                
                          CastSkillShot(_Q,9744, -71.240601, 4654)  
                          MoveToXYZ(9634, -71.240601, 4544) 
                          elseif Config.Y then 
                             MoveToXYZ(9022, 52.840878, 4360)  
                               
    end
    end
          function JungleClear()
                  if IWalkConfig.LaneClear then
                  if Config.M then
       for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 650) then
            local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
            local dmg = (GotBuff(Q,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(Q,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
            local hp = GetCurrentHP(Q)
            local Dmg = CalcDamage(myHero, Q, dmg)
            if Dmg > hp then
            if CanUseSpell(myHero,_E) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .35 then
            CastSpell(_E) 
           end
        end
    end
     end
  end
end
end
function Killsteal()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9))
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.I 
  and (GetCastLevel(myHero,_Q)*60)+(GetBonusDmg(myHero)*1) and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
    CastTargetSpell(enemy, _Q)
            end
        end
        if Config.N then
   local Dmgz= GetBonusDmg(myHero)+GetBaseDamage(myHero)
 local dmg = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
   if CalcDamage(myHero, unit, dmg) > GetCurrentHP(unit)  then
                  if CanUseSpell(myHero,_E) == READY then
                    CastSpell(_E)
                  end
                end
              end
end
end
function LevelUpMeleeSupport()     
if LevelConfig.L2 then
if GetLevel(myHero) == 1 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_Q)
end
end
end
function LevelUp()     
if LevelConfig.L1 then
if GetLevel(myHero) == 1 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end
end
function kalE(x) if x <= 1 then return 10 else return kalE(x-1) + 2 + x end end -- Insipireds code.
function Drawings()
myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
end
end
-- Vi
class "Vi"
function Vi:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Vi", "Vi")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Vi:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Vi:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
                 
                 function Vi:CastQ(unit)
    local target = GetTarget(725, DAMAGE_PHYSICAL) -- Q from Deftsu
    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 725) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 725, 250 do
        DelayAction(function()
            local _Qrange = 225 + math.min(225, i/2)
              local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,true,true)
              if Pred.HitChance >= 1 then
                CastSkillShot2(_Q, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
              end
          end, i)
      end
    end
  end
                                  --Vi E
                 function Vi:CastE(unit)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 175) then
            CastSpell(_E)
            end
        end
      end
    -- Cast R
    function Vi:CastR(unit)
            if Config.R then
                  if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 800) then
            CastTargetSpell(unit, _R)
            end
        end
end
                        function Vi:Combo()
  if ValidTarget(self.target, 1700)  then       
    elseif self.QREADY then
      self:CastQ(self.target) 
         elseif self.EREADY then
      self:CastE(self.target) 
                elseif self.RREADY then
      self:CastR(self.target)          
end
end

-- Yasuo
class "Yasuo"
function Yasuo:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Yasuo", "Yasuo")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "E to Minion (Combo)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Yasuo:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Yasuo:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

                 -- Yasuo Q
function Yasuo:CastQ(unit)
                         if Config.Q then
                          local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,false,true)
if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1200) and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
          end
        -- Yasuo E
        function Yasuo:CastE(unit)
                 if GetCastName(myHero, _E) == "YasuoDashWrapper" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 475) then
            CastTargetSpell(unit,_E)
            end
        end
    end
  end
-- Yasuo R
function Yasuo:CastR(unit)
            if Config.R then
                    local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)
                   if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1200) then
            CastSpell(_R)
            end
        end
      end


function Yasuo:CastEQ(unit)
if Config.Combo then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
 local unit = GetCurrentTarget()
 if unit == nil then return end
 if IsInDistance(Q, 750) or IsInDistance(unit, 750) then
        local targetPos = GetOrigin(Q)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, GetBonusDmg(myHero)+GetBaseDamage(myHero))
        local unit = GetCurrentTarget()
              elseif GotBuff(unit, "YasuoDashWrapper") > 1 then return end
        if GetCastName(myHero, _E) == "YasuoDashWrapper" then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(Q,_E)
end
            end
        end
          end

      end
    end
                        function Yasuo:Combo()
  if ValidTarget(self.target, 1700)  then       
    elseif self.QREADY then
      self:CastQ(self.target) 
         elseif self.EREADY then
      self:CastE(self.target) 
         elseif self.EREADY then
      self:CastEQ(self.target) 
                elseif self.RREADY then
      self:CastR(self.target)          
end
end

-- Sona
class "Sona"
function Sona:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Sona", "Sona")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Sona:Loop(myHero)
    self:Checks() 
    self:CastWA()
    self:CastWM()
  if _G.IWalkConfig.Combo then
    self:Combo()
end
  function Sona:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Sona:CastWA(unit)
                if Config.W then
                for _, ally in pairs(GetAllyHeroes()) do
            if (GetCurrentHP(ally)/GetMaxHP(ally))<0.6 and
                    CanUseSpell(myHero, _W) == READY and IsInDistance(ally, 1000) and IsObjectAlive(ally) then
            CastSpell(_W)
          end
    end
end
end
function Sona:CastWM(unit)
    if GetCastName(myHero, _W) == "SonaW" then
            if Config.W then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.5 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(myHero) then
            CastSpell(_W)
            end
        end
    end
  end

                 -- Sona Q
                 function Sona:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "SonaQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 850) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
  end
                     -- Sona R
                     function Sona:CastR(unit)
                         if Config.R then
        if GetCastName(myHero, _R) == "SonaR" then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,false,true)
             if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
            end
        end
      end
    end
                      function Sona:Combo()
  if ValidTarget(self.target, 1700)  then       
    elseif self.QREADY then
      self:CastQ(self.target) 
                elseif self.RREADY then
      self:CastR(self.target)          
end
end
end
--Khazix
class "Khazix"
function Khazix:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Khazix", "Khazix")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Khazix:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Khazix:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1700, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
                  function Khazix:Combo()
  if ValidTarget(self.target, 1700)  then
      self:CastE()       
      self:CastW() 
      self:CastQ()          
end
end

    -- Khazix E
    function Khazix:CastE()
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_E),50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
      end
                         -- Khazix Q
                         function Khazix:CastQ()
            if Config.Q then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(unit) and IsInDistance(unit, 325) then
            CastTargetSpell(unit,_Q)
            end
        end
      end
-- Khazix Q
function Khazix:CastW()
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,600,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 1000) and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
      end

--Rumble
class "Rumble"
function Rumble:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Rumble", "Rumble")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Rumble:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Rumble:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1700, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

-- Rumble Q
function Rumble:CastQ(unit)
        if GetCastName(myHero, _Q) == "RumbleFlameThrower" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,600,50,false,true)
            if Config.Q then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 600) and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
    -- Rumble E
    function Rumble:CastE(unit)
        if GetCastName(myHero, _E) == "RumbleGrenade" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 850) and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
-- Rumble R
function Rumble:CastR(unit)
        local myorigin = GetOrigin(unit)
local mymouse = GetCastRange(myHero,_R) 
if Config.R then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1700,55,false,true)
if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1700) then 
    CastSkillShot3(_R,myorigin,EPred)
end
end
end
                  function Rumble:Combo()
  if ValidTarget(self.target, 1700)  then
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.QREADY then
      self:CastQ(self.target) 
                elseif self.WREADY then
      self:CastW(self.target)   
                 elseif self.RREADY then
              self:CastR(self.target)         
end
end
-- Alistar
class "Alistar"
function Alistar:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Alistar", "Alistar")
Config.addParam("QW", "Use QW Combo", SCRIPT_PARAM_ONOFF, false)
Config.addParam("WQ", "Use WQ Combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Alistar:Loop(myHero)
    self:Checks() 
    self:CastR()
    self:CastEA()
    self:CastEM()
  if _G.IWalkConfig.Combo and Config.QW then
    self:ComboQW()
  end
    if _G.IWalkConfig.Combo and Config.WQ then
    self:ComboWQ()
  end
end
  function Alistar:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Alistar:CastR(unit)
    if GetCastName(myHero, _R) == "FerociousHowl" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSpell(_R)
            end
        end
    end
  end
  function Alistar:CastEA(unit)
                for _, ally in pairs(GetAllyHeroes()) do
            if Config.E then
            if (GetCurrentHP(ally)/GetMaxHP(ally))<0.7 and
                    CanUseSpell(myHero, _E) == READY and IsInDistance(ally, 575) and IsObjectAlive(ally) then
            CastSpell(_E)
        end
    end
end
end
function Alistar:CastEM(unit)
    if GetCastName(myHero, _E) == "TriumphantRoar" then
            if Config.E then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.7 and
                    CanUseSpell(myHero, _E) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSpell(_E)
            end
        end
    end
end
                    -- Alistar W
                    function Alistar:CastWQ(unit)
   if GetCastName(myHero, _W) == "Headbutt" then
            if Config.WQ then
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 650) then
           CastTargetSpell(unit, _W)
            end
        end
    end
  end
                 -- Alistar Q
                 function Alistar:CastWQ2(unit)
                         if Config.WQ then
        if GetCastName(myHero, _Q) == "Pulverize" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
  end
                     -- Alistar Q
                     function Alistar:CastQW(unit)
                         if Config.QW then
        if GetCastName(myHero, _Q) == "Pulverize" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
  end
                        -- Alistar W
                        function Alistar:CastQW2(unit)
   if GetCastName(myHero, _W) == "Headbutt" then
            if Config.QW then
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 300) then
           CastTargetSpell(unit, _W)
            end
        end
    end
                  function Alistar:ComboQW()
  if ValidTarget(self.target, 1700)  then
    elseif self.QREADY then
      self:CastQW(self.target) 
                       elseif self.WREADY then      
      self:CastQW2(self.target)           
end
end
                  function Alistar:ComboWQ()
  if ValidTarget(self.target, 1700)  then
    elseif self.WREADY then
      self:CastWQ(self.target)
                       elseif self.QREADY then       
      self:CastWQ2(self.target)         
end
end
end
-- Leona
class "Leona"
function Leona:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Leona", "Leona")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Leona:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Leona:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

                 
                                                  -- Leona Q
                                                  function Leona:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "LeonaShieldOfDaybreak" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 625) then
                        CastTargetSpell(unit,_Q)
            end
        end
    end
  end
                                  --Leona E 
                                  function Leona:CastE(unit)
                 if Config.E then
                 if GetCastName(myHero, _E) == "LeonaZenithBlade" then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_E),50,false,true)
                 if CanUseSpell(myHero, _E) == READY and IsObjectAlive(unit) and IsInDistance(unit, 700)  then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
                     -- Leona R
                     function Leona:CastR(unit)
                     if Config.R then
                 if GetCastName(myHero, _R) == "LeonaSolarFlare" then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_R),50,false,true)
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.8 and
                 CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1100) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
  end

function Leona:CastW(unit)
        if GetCastName(myHero, _W) == "LeonaSolarBarrier" then
            if Config.W then
                local unit = GetCurrentTarget()
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.75 and
                    CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "recall") == 0 then
            CastTargetSpell(myHero, _W)
            end
        end
    end
end
                  function Leona:Combo()
  if ValidTarget(self.target, 1700)  then
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.EREADY then
      self:CastE(self.target) 
                elseif self.WREADY then
      self:CastW(self.target)   
                 elseif self.RREADY then
              self:CastR(self.target)         
end
end

-- Swain
class "Swain"
function Swain:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Swain", "Swain")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Swain:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Swain:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

function Swain:CastRS(unit)
    if GetCastName(myHero, _R) == "SwainMetamorphism" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.3 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero,_R)
            end
        end
    end
  end

                 
                                                  -- Swain Q
                                                  function Swain:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "SwainDecrepify" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 625) then
                        CastTargetSpell(unit,_Q)
            end
        end
    end
  end
                                  --Swain E 
                                  function Swain:CastE(unti)
                 if Config.E then
                 if GetCastName(myHero, _E) == "SwainTorment" then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 625) then
            CastTargetSpell(unit,_E)
            end
        end
    end
  end
                     -- Swain W
                     function Swain:CastW(unit)
   if Config.W then
   if GetCastName(myHero, _W) == "SwainShadowGrasp" then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_W),50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 625)  then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
  function Swain:CastR(unit)
                     if Config.R then
                 if GetCastName(myHero, _R) == "SwainMetamorphism" then
                local ult = (GetCastLevel(myHero,_R)*50+130)+(GetBonusAP(myHero)*.2)
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 700) then
            CastTargetSpell(myHero, _R)
            end
        end
    end
  end
                  function Swain:Combo()
  if ValidTarget(self.target, 1700)  then
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.EREADY then
      self:CastE(self.mymouse) 
                elseif self.WREADY then
      self:CastW(self.mymouse)  
                 elseif self.RREADY then
              self:CastR(self.target) 
                               elseif self.RREADY then
              self:CastRS(self.target)        
end
end

-- Gnar
class "Gnar"
function Gnar:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Gnar", "Gnar")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Q2", "Use Q2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W2", "Use W2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E2", "Use E2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Gnar:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Gnar:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Gnar:Combo()
	self.CastQ()
	self.CastWG()
	self.CastE()
	self.CastQG()
	self.CastEG()
end

                                                  -- Gnar Q
                                                  function Gnar:CastQ()
                         if Config.Q then
        if GetCastName(myHero, _Q) == "GnarQ" then
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),250,250,1100,40,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1100) and ValidTarget(unit, 1150) then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
                                  --Gnar E gnarbigqwe
                                  function Gnar:CastE()
                 if Config.E then
                 if GetCastName(myHero, _E) == "GnarE" then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 1100) and ValidTarget(unit, 850) then
            CastSkillShot(_E, GetMousePos().x, GetMousePos().y, GetMousePos().z)
            end
        end
    end
  end
                     -- Gnar W
                     function Gnar:CastWG()
   if Config.W2 then
   if GetCastName(myHero, _W) == "gnarbigw" then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_W),50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and ValidTarget(unit, GetCastRange(myHero,_W)) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
    function Gnar:CastQG()
                             if Config.Q2 then
        if GetCastName(myHero, _Q) == "gnarbigq" then
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1100,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1100) and ValidTarget(unit, 1150) then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
    function Gnar:CastEG()
                     if Config.E2 then
                 if GetCastName(myHero, _E) == "gnarbige" then
                    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,475,50,false,true)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 475) and ValidTarget(unit, 475) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
-- Udyr
class "Udyr"
function Udyr:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Udyr", "Udyr")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Udyr:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Udyr:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
                 
                                  --Udyr E
                                  function Udyr:CastE(unit)
                 if GetCastName(myHero, _E) == "UdyrBearStance" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 125) then
            CastTargetSpell(myHero,_E)
            end
        end
      end
    end
                 -- Udyr Q
                 function Udyr:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "UdyrTigerStance" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 125) then
                        CastTargetSpell(myHero,_Q)
            end
        end
      end
    end
                     -- Udyr W
                     function Udyr:CastW(unit)
   if GetCastName(myHero, _W) == "UdyrTurtleStance" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 125) then
            CastTargetSpell(myHero,_W)
            end
        end
      end
    end
    -- Cast R
    function Udyr:CastR(unit)
   if GetCastName(myHero, _R) == "UdyrPhoenixStance" then
            if Config.R then
                  if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 250) then
            CastTargetSpell(myHero, _R)
            end
        end
      end
    end
              function Udyr:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.WREADY then
      self:CastW(self.target) 
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.EREADY then
      self:CastE(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end
-- Brand
class "Brand"
function Brand:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Brand", "Brand")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Brand:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Brand:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
                 
                                  --Brand E
                                  function Brand:CastE(unit)
                 if GetCastName(myHero, _E) == "BrandConflagration" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 625) then
            CastTargetSpell(unit,_E)
            end
        end
    end
  end
                 -- Brand Q
                 function Brand:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "BrandBlaze" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1050,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1050) and GotBuff(unit, "brandablaze") == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
                     -- Brand W
                     function Brand:CastW(unit)
   if GetCastName(myHero, _W) == "BrandFissure" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
    -- Cast R
    function Brand:CastR(unit)
   if GetCastName(myHero, _R) == "BrandWildfire" then
            if Config.R then
                local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusAP(myHero)*.50)
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 750) then
            CastTargetSpell(unit, _R)
            end
        end
    end
  end
          function Brand:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.EREADY then
      self:CastE(self.target) 
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end
-- Fiora
class "Fiora"
function Fiora:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Fiora", "Fiora")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end

--Start
function Fiora:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Fiora:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
                            -- Fiora Q
                            function Fiora:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "FioraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
  end
                     -- Fiora W
                     function Fiora:CastW(unit)
   if GetCastName(myHero, _W) == "FioraW" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 750) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
                 --Fiora E
                 function Fiora:CastE(unit)
                 if GetCastName(myHero, _E) == "FioraE" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 260) then
            CastTargetSpell(myHero,_E)
            end
        end
    end
  end
    -- Cast R
    function Fiora:CastR(unit)
   if GetCastName(myHero, _R) == "FioraR" then
            if Config.R then
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 500) then
            CastTargetSpell(unit, _R)
            end
        end
    end
  end
          function Fiora:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.WREADY then
      self:CastW(self.target) 
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.EREADY then
      self:CastE(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

-- Riven
class "Riven"
function Riven:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Riven", "Riven")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Riven:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Riven:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
function Riven:CastE(unit)
                 --Riven E
                 if GetCastName(myHero, _E) == "RivenFeint" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,325,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) 
            end
        end
    end
  end
                 -- Riven Q
                 function Riven:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "RivenTriCleave" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
        DelayAction(function() AttackUnit(unit) end, 1800)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 260) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
  end
    -- Riven W
    function Riven:CastW(unit)
   if GetCastName(myHero, _W) == "RivenMartyr" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,125,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 125) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
    -- Cast R
    function Riven:CastR(unit)
   if GetCastName(myHero, _R) == "RivenFengShuiEngine" then
            if Config.R then
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastTargetSpell(myHero, _R)
            end
        end
    end
    --Cast R windslash
       if GetCastName(myHero, _R) == "rivenizunablade" then
            if Config.R then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                     if (GetCurrentHP(unit)/GetMaxHP(unit))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
end
          function Riven:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

-- Gangplank
class "Gangplank"
function Gangplank:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Gangplank", "Gangplank")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Es", "Use R ks", SCRIPT_PARAM_ONOFF, false)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Gangplank:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
      if Config.F then
    self:QFarm() 
  end
    if Config.Es then
    self:KS()
  end 
end
  function Gangplank:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
  --Auto heal if under or 30% HP AND ENEMY IS IN 1000 RANGE.
function Gangplank:CastW(unit)
   if GetCastName(myHero, _W) == "GangplankW" then
            if Config.W then
                          if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.3 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero, _W)
            end
        end
    end
  end
       -- Auto R (ks)
       function Gangplank:KS(unit)
       if GetCastName(myHero, _R) == "GangplankR" then
            if Config.Es then
                                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,10000,50,false,true)
                          if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 10000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
  end
                 -- Gang Q
function Gangplank:CastQ(unit)
                         if Config.Q then
        if GetCastName(myHero, _Q) == "GangplankQWrapper" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit ,_Q)
                end
            end
        end
      end
        -- Gangplank E
        function Gangplank:CastE(unit)
                 if GetCastName(myHero, _E) == "GangplankE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
-- Gangplank R
function Gangplank:CastR(unit)
   if GetCastName(myHero, _R) == "GangplankR" then
            if Config.R then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,10000,50,false,true)
                     if (GetCurrentHP(unit)/GetMaxHP(unit))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 10000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
  end

function Gangplank:QFarm()
if IWalkConfig.LastHit then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 750) then
        local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusDmg(myHero)*1.7)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(Q,_Q)
            end
        end
          end
        end
        end
      end
    end
                function Gangplank:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

-- Irelia
class "Irelia"
function Irelia:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Irelia", "Irelia")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Es", "Use E Stun", SCRIPT_PARAM_ONOFF, false)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit", SCRIPT_PARAM_ONOFF, true)
Config.addParam("G", "KS Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Irelia:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
      if Config.F then
    self:QFarm() 
  end
  if Config.G then
    self:KS()
  end 
    if Config.Es then
    self:Es()
  end 
end
  function Irelia:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

                 -- Irelia Q
                 function Irelia:CastQ(unit)
                 if Config.Q then
        if GetCastName(myHero, _Q) == "IreliaGatotsu" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
      end
        -- Irelia E
        function Irelia:CastE(unit)
             if Config.E then
if GetCastName(myHero, _E) == "IreliaEquilibriumStrike" then
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_E)
                end
            end
end
end
        -- Irelia E
        function Irelia:ES(unit)
             if Config.Es then
if GetCastName(myHero, _E) == "IreliaEquilibriumStrike" then
    if (GetCurrentHP(myHero) < GetCurrentHP(unit)) and CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_E)
                end
            end
end
end
function Irelia:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "IreliaHitenStyle" then
if CanUseSpell(myHero, _W) == READY  and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_W)
                end
            end
        end
      end
-- Irelia R
function Irelia:CastR(unit)
       if Config.R then
        if GetCastName(myHero, _R) == "IreliaTranscendentBlades" then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1000,55,false,true)
if (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and IsObjectAlive(unit) and CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1000)  then
     CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
    end
    end
  end

function Irelia:QFarm()
if IWalkConfig.LastHit then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 750) then
        local z = (GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(Q,_Q)
            end
        end
          end
        end
        end
      end
    end
function Irelia:KS()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9))
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.I 
  and (GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9) and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
    CastTargetSpell(enemy, _Q)
            end
        end
end
end
            function Irelia:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

--Evelynn
class "Evelynn"
function Evelynn:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Evelynn", "Evelynn")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Evelynn:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Evelynn:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

-- Evelynn W
function Evelynn:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "EvelynnW" then
if CanUseSpell(myHero, _W) == READY then
    CastTargetSpell(myHero,_W)
                end
            end
        end
      end
-- Evelynn Q
function Evelynn:CastQ(unit)
    if Config.Q then
        if GetCastName(myHero, _Q) == "EvelynnQ" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(myHero,_Q)
                end
            end
        end
      end
    -- Evelynn E
    function Evelynn:CastE(unit)
   if Config.E then
        if GetCastName(myHero, _E) == "EvelynnE" then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(unit,_E)
                end
    end
end
end
-- Evelynn R
function Evelynn:CastR(unit)
             if Config.R then
if GetCastName(myHero, _R) == "EvelynnR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,650,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
       end
     end
            function Evelynn:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

--Akali
class "Akali"
function Akali:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Akali", "Akali")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
function Akali:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Akali:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1700, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
--Start
function Akali:CastQ(unit)
                 if Config.Q then
        if GetCastName(myHero, _Q) == "AkaliMota" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
      end
      function Akali:CastE(unit)
             -- Akali E
             if Config.E then
if GetCastName(myHero, _E) == "AkaliShadowSwipe" then
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,325,55,false,true)
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                end
            end
          end
        end
-- Akali W
function Akali:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "AkaliSmokeBomb" then
if CanUseSpell(myHero, _W) == READY then
    CastTargetSpell(unit,_W)
                end
            end
        end
      end
    -- Akali R
    function Akali:CastR(unit)
   if Config.R then
        if GetCastName(myHero, _R) == "AkaliShadowDance" then
if CanUseSpell(myHero, _R) == READY then
    CastTargetSpell(unit,_R)
                end
    end
end
end
            function Akali:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.EREADY then
      self:CastE(self.target)       
    elseif self.WREADY then
      self:CastW(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

--Menu
class "Azir"
function Azir:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Azir
Config = scriptConfig("Azir", "Azir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Azir:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Azir:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1700, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

-- Azir W
function Azir:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "AzirW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
  end
-- Azir Q
function Azir:CastQ(unit)
    if Config.Q then
        if GetCastName(myHero, _Q) == "AzirQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
  end
    -- Azir E
    function Azir:CastE(unit)
    if Config.E then
        if GetCastName(myHero, _E) == "AzirE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
-- Azir R
function Azir:CastR(unit)
             if Config.R then
if GetCastName(myHero, _R) == "AzirR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,250,55,false,true)
  local ult = (GetCastLevel(myHero,_R)*75)+(GetBonusAP(myHero)*.6)
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) or (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.27 and CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 250) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
      end
    end
            function Azir:Combo()
  if ValidTarget(self.target, 1700)  then
    if self.WREADY then
      self:CastW(self.target) 
    elseif self.QREADY then
      self:CastQ(self.target)       
    elseif self.EREADY then
      self:CastE(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end

--Viktor
class "Viktor"
function Viktor:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Viktor", "Viktor")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Viktor:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Viktor:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1700, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end

-- Viktor W
function Viktor:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "ViktorGravitonField" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
  end
-- Viktor Q
function Viktor:CastQ(unit)
    if Config.Q then
        if GetCastName(myHero, _Q) == "ViktorPowerTransfer" then
if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 600) then
    CastTargetSpell(unit,_Q)
                end
            end
        end
      end
    -- Viktor E
    function Viktor:CastE(unit)
    local myorigin = GetOrigin(unit)
local mymouse = GetCastRange(myHero,_E) 
if Config.E then
        if GetCastName(myHero, _E) == "ViktorDeathRay" then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 1500) then 
    CastSkillShot3(_E,myorigin,myorigin)
    end
end
end
end
-- Viktor R
function Viktor:CastR(unit)
             if Config.R then
if GetCastName(myHero, _R) == "ViktorChaosStorm" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200+25)+(GetBonusDmg(myHero)*1.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
   if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
        end
    end
end
            function Viktor:Combo()
  if ValidTarget(self.target, 1000)  then
    if self.EREADY then
      self:CastE(self.target) 
    elseif self.WREADY then
      self:CastW(self.target)       
    elseif self.QREADY then
      self:CastQ(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end
-- VelKoz
class "Velkoz"
function Velkoz:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("VelKoz", "VelKoz")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Velkoz:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
  function Velkoz:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
-- Velkoz E
function Velkoz:CastE(unit)
    if Config.E then
        if GetCastName(myHero, _E) == "VelkozE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end

-- Velkoz W
function Velkoz:CastW(unit)
    if Config.W then
        if GetCastName(myHero, _W) == "VelkozW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 1500) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
  end
-- Velkoz Q
function Velkoz:CastQ(unit)
    if Config.Q then
        if GetCastName(myHero, _Q) == "VelkozQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1050,55,true,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
  end
-- Velkoz R
function Velkoz:CastR(unit)
             if Config.R then
if GetCastName(myHero, _R) == "VelkozR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
      if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
          end
                end
            end
          end
        end
            function Velkoz:Combo()
  if ValidTarget(self.target, 1000)  then
    if self.EREADY then
      self:CastE(self.target) 
    elseif self.WREADY then
      self:CastW(self.target)       
    elseif self.QREADY then
      self:CastQ(self.target)
         elseif self.RREADY then
      self:CastR(self.target)     
end
end
end
-- Ekko
class "Ekko"
function Ekko:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Ekko", "Ekko")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Rs", "Use R Save", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Ekko:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
 function Ekko:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1500, DAMAGE_MAGIC)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
 
-- Q cast
function Ekko:CastQ(unit)
        if GetCastName(myHero, _Q) == "EkkoQ" then
                local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1075,50,false,true)
                        if Config.Q then
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
                end
        end
      end
-- W Cast
function Ekko:CastW(unit)
    if GetCastName(myHero, _W) == "EkkoW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1600,50,false,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
    function Ekko:CastE(unit)
-- E Cast Will cast E and if im correct then GoS will click champ and Ekko will blink Cast = 325 range Blink= 425
    if GetCastName(myHero, _E) == "EkkoE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
  end
-- R cast
function Ekko:CastR(unit)
    if GetCastName(myHero, _R) == "EkkoR" then
            if Config.R then
              local ult = (GetCastLevel(myHero,_R)*150+50)+(GetBonusAP(myHero)*1.30)
                      local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,325,50,false,true)
                         if CanUseSpell(myHero, _R) and IsInDistance(unit, 325) then 
            if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_R,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) 
              end
            end
            end
    end
  end
    function Ekko:CastRs(unit)
        if GetCastName(myHero, _R) == "EkkoR" then
            if Config.Rs then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero,_R)
            end
        end
    end
  end
  function Ekko:Combo()
  if ValidTarget(self.target, 1000)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.WREADY then
      self:CastW(self.target)       
    elseif self.EREADY then
      self:CastE(self.target)
         elseif self.RREADY then
      self:CastR(self.target)
      elseif self.RREADY then
      self:CastRs(self.target)      
end
end
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
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
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
if Config.Combo then
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
              if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and 
    CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) ~= READY and IsInDistance(unit, 750) then
    CastTargetSpell(myHero, _R)
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
         if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and 
    CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 750) and GotBuff(myHero, "nidaleepassivehunting") == 1 then
        CastSpell(_R)
                end
            end
                end
        end
 
        end
    end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Nidalee Loaded</font>"))
 end
-- Graves
class "Graves"
function Graves:__init()
OnLoop(function(myHero) self:Loop(myHero) end)
--Menu
Config = scriptConfig("Graves", "Graves")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
end
--Start
function Graves:Loop(myHero)
    self:Checks() 
  if _G.IWalkConfig.Combo then
    self:Combo()
  end
end
 function Graves:Checks()
  self.QREADY = CanUseSpell(myHero,_Q) == READY
  self.WREADY = CanUseSpell(myHero,_W) == READY
  self.EREADY = CanUseSpell(myHero,_E) == READY
  self.RREADY = CanUseSpell(myHero,_R) == READY
  self.target = GetTarget(1200, DAMAGE_PHYSICAL)
  self.targetPos = GetOrigin(self.target)
  self.mymouse = GetMousePos() 
end
-- Q cast
function Graves:CastQ(unit)
        if GetCastName(myHero, _Q) == "GravesClusterShot" then
                local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                        if Config.Q then
                        if self.QREADY and QPred.HitChance == 1 then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
                end
        end
      end
-- W Cast
function Graves:CastW(unit)
    if GetCastName(myHero, _W) == "GravesSmokeGrenade" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1600,50,false,true)
            if Config.W then
            if self.WREADY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
  end
-- E Cast 
function Graves:CastE(mymouse)
    if GetCastName(myHero, _E) == "GravesMove" then
            if Config.E and self.EREADY then
        CastSkillShot(_E, GetMousePos().x, GetMousePos().y, GetMousePos().z)
            end
        end
      end
-- R Cast 
function Graves:CastR(unit)
    if GetCastName(myHero, _R) == "GravesChargedShot" then
      if Config.R then
        local ult = (GetCastLevel(myHero,_R)*150+150)+(GetBonusDmg(myHero)*1.50)
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,true,true)
                        if CanUseSpell(myHero_R) == READY and RPred.HitChance == 1 and IsInDistance(target, GetCastRange(myHero,_R)) and self.RREADY then
                                  if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
                          CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
        end
    end
end
end
function Graves:Combo()
  if ValidTarget(self.target, 1000)  then
    if self.QREADY then
      self:CastQ(self.target) 
    elseif self.WREADY then
      self:CastW(self.target)       
    elseif self.EREADY then
      self:CastE(self.mymouse)
         elseif self.RREADY then
      self:CastR(self.target)      
    end 
  end
end

if supportedHero[GetObjectName(myHero)] == true then
if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end 
end
