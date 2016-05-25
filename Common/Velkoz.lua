require("OpenPredict")

Q = {range= 1200, delay =.25, width=50, speed= 1300}
QSplit = {range = 1100, width = 55, speed = 2100}

Callback.Add("CreateObj", function(Obj) CreateObj(Obj) end)
Callback.Add("DeleteObj", function(Obj) DeleteObj(Obj) end)
Callback.Add("Draw", function(myHero) Draw(myHero) end)

function CreateObj(Obj)
	if Obj.name == "missile" and GetObjectSpellOwner(Obj) == myHero and GetObjectSpellName(Obj) == "VelkozQMissile" then
		QObj = Obj
	end
end

function DeleteObj(Obj)
    if Obj.name == "missile" and GetObjectSpellOwner(Obj) == myHero and GetObjectSpellName(Obj) == "VelkozQMissileSplit"  then
        QObj = nil
    end
end
lastQtick = 0

function Draw(myHero)
	local Ticker = GetTickCount()
	Enemy = GetCurrentTarget()
	if QObj ~= nil then
		local Endpos = GetObjectSpellEndPos(QObj)
		local Stapos = GetObjectSpellStartPos(QObj)
		local Qpos = VectorExtend(QObj, myHero.pos, -35)
		local TE = Qpos + Vector(Vector(Qpos)-Stapos):perpendicular2():normalized()*1100
		local TE2 = Qpos + Vector(Vector(Qpos)-Stapos):perpendicular():normalized()*1100
		local pred = GetPrediction(Enemy, Q, Qpos)
		DrawCircle(Vector(TE),50,1,1,GoS.White)
		DrawCircle(Vector(TE2),50,1,1,GoS.White)
		local predpos = GetPrediction(Enemy, Q)
		for i, u in pairs(GetEnemyHeroes()) do
			if ValidTarget(u, QSplit.range) and (CountObjectsOnLineSegment(Qpos, TE, QSplit.width+u.boundingRadius, GetEnemyHeroes(), MINION_ENEMY) >= 1 or CountObjectsOnLineSegment(Qpos, TE2, QSplit.width+u.boundingRadius, GetEnemyHeroes(), MINION_ENEMY)>=1) then
				CastSpell(_Q)
			end
		end
	end
	if QObj == nil and Ready(_Q) and ValidTarget(Enemy, Q.range) and Ready(_Q) and GetCastName(myHero, _Q) == "VelkozQ" then
		local pred = GetPrediction(Enemy, Q)
		for i=-90,90, 15 do
			local alpha = 28 * math.pi/180
			local cp = myHero.pos + Vector(Vector(pred.castPos)-myHero.pos):rotated(0, i*alpha, 0)
			local pred1 = GetPrediction(Vector(cp), Q)
			local pred2 = GetPrediction(Enemy, QSplit, Vector(cp))
			if pred2.hitChance >= .65 and CountObjectsOnLineSegment(myHero, Vector(cp), QSplit.width, minionManager.objects, MINION_ENEMY) == 0 and not pred1:mCollision(0) and not pred2:mCollision(0) then
				if lastQtick + 250 < Ticker then  
					CastSkillShot(_Q,Vector(cp))
				end
			end
		end
	end
end

function VectorExtend(v,t,d)
	return v + d * (t-v):normalized() 
end

