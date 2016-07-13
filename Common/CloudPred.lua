
Callback.Add("Load", function() Load() end)
--Callback.Add("Tick", function() Draw() end)
Callback.Add("ProcessWaypoint", function(unit, point) PW(unit, point) end)
Callback.Add("CreateObj", function(obj) CreateObj(obj) end)
Callback.Add("DeleteObj", function(obj) DeleteObj(obj) end)
Callback.Add("ObjectLoad", function(obj) ObjectLoad(obj) end)
local wPoint = {}
local samples = {}
local minions = {}
local avgpl1 = 0
local avgreaction = 0


local RStats = {delay = 0.25, range = 1400, width = 40, speed = 5000, collision = false}
local QStats = {delay = 0.25, range = 1500, width = 35, speed = 1600, collision = true}
function Load()
	local m = nil 
end
-- Example usage.
--[[
function Draw()
	unit = GetCurrentTarget()
    local pred, hitChance = GLP(unit, RStats)
    if pred then
    	DrawCircle(pred, 30, 1, 1, GoS.White)
    end

    --local predQ, hitChanceQ = GLP(unit, QStats)
    	--print(hitChance)
	if Ready(_W) and pred and hitChance == "High" and ValidTarget(unit, RStats.range) and KeyIsDown(32) then
		CastSkillShot(_W, pred)
	end
end]]

function PW(unit, wProc)
    if not wPoint[unit.networkID] then 
        wPoint[unit.networkID] = {}
        wPoint[unit.networkID].t = GetTickCount()
    end
    if GetTickCount() - wPoint[unit.networkID].t > 10 then
        wPoint[unit.networkID] = {}
        wPoint[unit.networkID].t = GetTickCount()
    end
    wPoint[unit.networkID][wProc.index] = wProc.position
    --Static
	if not samples[unit.networkID] and unit.isHero then
	samples[unit.networkID] = {}
		-- Average pathlength
		local avgpl = 0
		samples[unit.networkID]["avgpl"] = {}
		table.insert(samples[unit.networkID]["avgpl"], avgpl)
		avgpl1 = avgpl
		-- Gets the lastmvnt time
		samples[unit.networkID].lastmvmntchange = GetTickCount()
		-- Average Reaction Time
		local avgreaction = 0
		samples[unit.networkID]["avgreaction"] = {}
		table.insert(samples[unit.networkID]["avgreaction"], avgreaction)
		avgreaction1 = avgreaction
	end
	-- Dynamic
	if samples[unit.networkID] then
		 if samples[unit.networkID]["avgpl"] and wPoint[unit.networkID][#wPoint[unit.networkID]] then
		  	local averagepath = ((#samples[unit.networkID]["avgpl"]-1)*avgpl1+GetDistance(wPoint[unit.networkID][#wPoint[unit.networkID]], wPoint[unit.networkID][1]))/#samples[unit.networkID]["avgpl"]
		 	table.insert(samples[unit.networkID]["avgpl"], averagepath)
		 	avgpl1 = averagepath
		 end
		if samples[unit.networkID]["avgreaction"] then 
		  	local avgreaction = (#samples[unit.networkID]["avgreaction"]*avgreaction1 + (GetTickCount()-samples[unit.networkID].lastmvmntchange))/#samples[unit.networkID]["avgreaction"]+1
		 	table.insert(samples[unit.networkID]["avgreaction"], avgreaction) 
		 	avgreaction1 = avgreaction
		 end
		 samples[unit.networkID].lastmvmntchange = GetTickCount()
		 -- Removal
		--[[ if #samples[unit.networkID]["avgpl"] >= 30 then
		 	avgpl1 = 0
		 	samples[unit.networkID]["avgpl"] = {[1]=0}
		 end
		if #samples[unit.networkID]["avgreaction"] >= 30 then
			avgreaction1 = 0
			samples[unit.networkID]["avgreaction"] = {[1]=avgreaction1}
		end]]
	end
end

function CreateObj(obj)
	if not obj.dead and obj.isMinion and obj.team ~= myHero.team then
		table.insert(minions, obj)
	end
end

function DeleteObj(obj)
	for i=1, #minions do
		if minions[i] and minions[i].dead then
			table.remove(minions, i)
		end
	end
end

function ObjectLoad(obj)
	if not obj.dead and obj.isMinion and obj.team ~= myHero.team then
		table.insert(minions, obj)
	end
end

function GLP(target, width, delay, missilespeed, range, collision)
	local GBW, hitChance = nil 
	if type(width) == "table" then 
		GBW, hitChance = GetBestWaypointClosest(target, width.width, width.delay, width.speed, width.range, width.collision, target)
	else
		GBW, hitChance = GetBestWaypointClosest(target, width, delay, missilespeed, range, collision, target)
	end
	local range1 = type(width) == "table" and width.range or range
	local width1 =  type(width) == "table" and width.width or width
	local collision1 = type(width) == "table" and width.collision or collision
	if GBW and collision1 == true and GetDistance(GBW, myHero) <= range1 and GetMinionCollision(GBW, width1) == false then
		return GBW, hitChance
	end
	if GBW and collision1 == false and GetDistance(GBW, myHero) <= range1 then
		return GBW, hitChance
	end
end

function GetHitChance(unit, timeFly, avgt, movt, avgp)
	if wPoint[unit.networkID] and wPoint[unit.networkID][1] and wPoint[unit.networkID][#wPoint[unit.networkID]] and GetDistance(wPoint[unit.networkID][#wPoint[unit.networkID]], wPoint[unit.networkID][1]) >= avgp and avgp >= 400 then
		if movt >= avgt then
			if timeFly and avgt >= timeFly*1.25 then return "High"
				elseif timeFly and avgt - movt >= timeFly then return "Medium"
					else return "Low"
			end
			else return "High"
		end
		else return "Medium"
	end
end

function GetMinionCollision(u, width)
	--[[for i=1, #minions, 1 do
	local TE = u + Vector(Vector(u)-myHero.pos):perpendicular2():normalized()*(width/2)  -- A
	local TE1 = u + Vector(Vector(u)-myHero.pos):perpendicular():normalized()*(width/2)   -- C
	local TE2 =  myHero.pos + Vector(Vector(myHero.pos)-u):perpendicular2():normalized()*(width/2)
	local TE3 = myHero.pos + Vector(Vector(myHero.pos)-u):perpendicular():normalized()*(width/2)
	local col1 = false
	local col2 = false
	for j=1, GetDistance(TE,TE3), 100 do
		local Vet = VectorExtend(Vector(TE1), Vector(TE2), j)
		--DrawCircle(Vet,30,1, 0,GoS.White)
		if GetDistance(minions[i], Vet) < minions[i].boundingRadius*2 then
			col1 = true
		end
	end 
	for v=1, GetDistance(TE1,TE2), 100 do
		local Vet = VectorExtend(Vector(TE), Vector(TE3), v)
		--DrawCircle(Vet,30,1, 0,GoS.White)
		if GetDistance(minions[i], Vet) < minions[i].boundingRadius*2 then
			col2 = true
		end
	end
	if col2 == true or col1 == true then return true end
	local poly = Polygon(Point(Vector(TE).x,Vector(TE).z,Vector(TE).y), Point(Vector(TE1).x,Vector(TE1).z,Vector(TE1).y), Point(Vector(TE2).x,Vector(TE2).z,Vector(TE2).y), Point(Vector(TE3).x,Vector(TE3).z,Vector(TE3).y))
		if minions[i] and poly:__contains(Point(minions[i].x, minions[i].z, minions[i].y)) then
			return true 
		end
	end
	return false]]
	for i=1, #minions, 1 do
		local proj2, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myHero, u, Vector(minions[i]))
        if isOnSegment and GetDistance(myHero, minions[i]) > 50 and (GetDistanceSqr(minions[i], proj2) <= (minions[i].boundingRadius + width + 20) ^ 2) then
            return true
        end
	end
	return false
end

function AvgPathLength(unit)
	local APL = avgpl1  
	return APL
end

function LastMoveChangeTime(unit)
	local LMCT = samples[unit.networkID] and GetTickCount() - samples[unit.networkID].lastmvmntchange or 0
	return LMCT
end

function AvgMoveChangeTime(unit)
	local AVMCT = avgreaction1
	return AVMCT
end

function IsMoving(unit)
    if unit and wPoint[unit.networkID] and wPoint[unit.networkID][1] and GetDistance(unit, wPoint[unit.networkID][1]) <= 20 and AvgMoveChangeTime(unit) > LastMoveChangeTime(unit) then
        return false
    end
    if unit and wPoint[unit.networkID] and wPoint[unit.networkID][1] and GetDistance(unit, wPoint[unit.networkID][1]) > 20 then 
        return true 
    end
    --return false
end

function GetBestWaypointClosest(unit, width, delay, missilespeed, range, collision, pos)
	local point = nil
	local table, timeFlyer = GetBestWaypoint(unit, width, delay, missilespeed, range, collision)
	if not table then return end
	if IsMoving(unit) == false then return unit.pos, "High" end
	if unit.isRecalling then return unit.pos, "High" end
	for k,v in pairs(table) do
		if not point and v then point = v end
		if point and v and GetDistanceSqr(point,pos) > GetDistanceSqr(v,pos) then
			point = v
		end
	end
	return point, GetHitChance(unit, timeFlyer, AvgMoveChangeTime(unit), LastMoveChangeTime(unit), AvgPathLength(unit))
end

function GetBestWaypoint(unit, width, delay, missilespeed, range, collision)
	local points = {}
	local t = nil 
	if wPoint[unit.networkID] then
		local ClostestPoint = GetClosestWaypoint(unit)  
		local step = math.floor(GetDistance(unit, ClostestPoint)/width)
		for i=1, step, 1 do
			local center = VectorExtend(unit.pos, ClostestPoint, i*width)
			local flytime = GetDistance(myHero, center)/missilespeed 
			t = flytime + delay+GetLatency()/2000/1000
			local arivaltime = GetDistance(unit, center)/unit.ms
			if t <= arivaltime then
				table.insert(points, center) 
			end
		end
	end
	return points, t 
end

function GetClosestWaypoint(unit)
	local point = nil
		for _,i in pairs(wPoint[unit.networkID]) do
			if tonumber(_) then 
				if not point and i then point = i end
				if point and i and GetDistanceSqr(i,unit.pos) < GetDistanceSqr(point,unit.pos) then
					local var = _-1 == 0 and 1 or _-1
					point = wPoint[unit.networkID][var]
				end
			end
		end
	return point
end

function VectorExtend(v,t,d)
	return v + d * (t-v):normalized() 
end
