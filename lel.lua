require 'MapPositionGOS'
 Config = scriptConfig("Gnar2", "Gnar2")
 Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
 Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
OnLoop(function(myHero)
        AutoRiAC()
end)
 
-- modify from IAC vayne
function AutoRiAC()
  if Config.Combo then
  if Config.R then 
        local target = GetCurrentTarget()
        if ValidTarget(target,GetCastRange(myHero,_R)) and IsInDistance(target, GetCastRange(myHero,_R)) and CanUseSpell(myHero,_R) == READY then
                for _=0,450,GetHitBox(target) do
                        local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, true, true)
            local tPos = Vector(Pred.PredPos)+Vector(Vector(Pred.PredPos)-Vector(myHero)):normalized()*_
            if MapPosition:inWall(tPos) then
              CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z)
              break
            end
          end
        end
      end
    end
end
-- Credits: Ilovesona Inspired Maxxxel
