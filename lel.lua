require 'MapPositionGOS'
 Config = scriptConfig("Gnar2", "Gnar2")
 Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
 Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
OnLoop(function(myHero)
        AutoR()
end)
function AutoR()
	if Config.Combo then
	 for _,target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target,1000) then
			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz
			local distance1=24
			local distance2=118
			local distance3=212
			local distance4=306
			local distance5=400
 
			local enemyposition = GetOrigin(target)
			enemyposx=enemyposition.x
			enemyposy=enemyposition.y
			enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
 
			local self=GetOrigin(myHero)
			selfx = self.x
			selfy = self.y
    	                selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
    	
			local Pos1 = TargetPos-(TargetPos-HeroPos)*(-distance1/GetDistance(target))
			local Pos2 = TargetPos-(TargetPos-HeroPos)*(-distance2/GetDistance(target))
			local Pos3 = TargetPos-(TargetPos-HeroPos)*(-distance3/GetDistance(target))
			local Pos4 = TargetPos-(TargetPos-HeroPos)*(-distance4/GetDistance(target))
			local Pos5 = TargetPos-(TargetPos-HeroPos)*(-distance5/GetDistance(target))
 
				if MapPosition:inWall(Pos1)==true then
					if GetDistance(target)<=1000 then
  local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, false, true)         
  CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z) 
					end
				end
				
				if MapPosition:inWall(Pos2)==true then
					if GetDistance(target)<=1000 then
  local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, false, true)         
  CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z)
					end
				end
				
				if MapPosition:inWall(Pos3)==true then
					if GetDistance(target)<=1000 then
  local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, false, true)         
  CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z) 
					end
				end
				
				if MapPosition:inWall(Pos4)==true then
					if GetDistance(target)<=1000 then
  local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, false, true)         
  CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z)
					end
				end
				
				if MapPosition:inWall(Pos5)==true then
					if GetDistance(target)<=1000 then
  local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), 2000, 250, 1000, 1, false, true)         
  CastSkillShot(_R,Pred.PredPos.x,Pred.PredPos.y,Pred.PredPos.z) 
					end
				end
				
		end
	end
end
end
