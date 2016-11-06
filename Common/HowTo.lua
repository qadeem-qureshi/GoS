-- Table Of Contents
	1. General Lua Section
	2. General API Section (Commented by Feretorix)
	3. Ahri Script (Commented by me)
	4. Link to my machine learning script (https://github.com/Cloudhax23/GoS/blob/master/Common/CloudPred.lua)
	5. Feel free to ask questions by tagging me on GitHub
--
-- General Lua Section
	-- the double dashes indecate a comment. Comments are not read by the code executer and are for orthers or yourself to read.
	var1 = "Test" -- This creates a variable. A variable is for performance or other related things. Also so you dont have to repeat the code
	print(var1) -- anything in quotes is a string. SO print() will output whatever var1 is equal to. In this case var1 is "Test" so the out put will be Test in the console.
	if var1 == var1 then print("True") else print("False") end -- SO if var1 is equal to itself then it will print true. If its not then it will print false.
	var1 = var1.." Changed" -- You can reset variables as needed. This will change var1 from "Test" to "Test Changed." The .. signifys connection of two strings.
	var1 = var1..var1 -- This will add both strings together. "Test Changed Test Changed" will be printed by the console
	-- For every if you must have one end. so if var1 == "Test Changed" then print("True") end. else statements do not need ends.
	-- 
	--[[
	This is how you do multiline comments. Anything out side the brackets are not comments
	]] 
	--Functions. Probably one of the most important things in Lua
	function FirstFunction() -- Creates the function
		print(var1)
	end
	FirstFunction() -- Calls the function. This will output "Test Changed"
	function SecondFunction(here) -- Heres another example!
		print(here) -- prints here
	end
	SecondFunction("Hi") -- This will print "Hi" if nothing is is inputed inbetween the () then it will print nil
	function ThridFunction(input, output, extra) -- A little more advanced but remember it will be the same as the SecondFunction
		if input == 1 and output == 2 then
			print(extra)
		else
			print("Nope")
		end
	end
	ThridFunction(1,1,"Good Work") -- The first is Input, the second is output, the thrid is a string. So if input is equal to one and output is equal to one then print "Good Work" else print "Nope"
	-- Math
	function FourthFunction(input, input1, output) -- Simple math
		if input*input1 == 30 then
			print(output)
		else 
			print("no")
		end
		if input/input1 == 30 then 
			print(output)
		else
			print("no")
		end
	end
	FourthFunction(1,30, "True") -- This will be true because 1*30 is 30!
	FourthFunction(30,1, "True") -- This will be true because 30/1 is 30!
	FourthFunction(30/2,1,"True") -- This will be false because 30/2 is 15 and this will output "no". "True" will never be printed.
	--[[ 
	a = 13
	b = 2
	print( a + b )
	print( a - b )
	print( a * b )
	print( a / b )
	print( a % b )
	Math Operations in Lua. Another math library for more advanced functions is found at http://lua-users.org/wiki/MathLibraryTutorial
	]] 
	--Operators
	if 1==1 then print("true") end -- if 1 is equal to 1 then print "true"
	if 1~=1 then print("true") end -- if 1 is not equal to 1 then print "true". This will not print anything because 1 is equal to 1.
	if 3>= 2 then print("true") end -- if 3 is greater then or equal to 2 then print "true". This will print "true"
	if 3<= 2 then print("true") end -- if 3 is less then or equal to 2 then print "true". This will not print anything because the statement is false
	if 3>2 then print("true") end -- if 3 is greater then 2 print "true". This will print "true"
	if 3<2 then print ("true") end -- if 3 is less then 2 print "true". This will not print anything because the statement is false
	if 3>2 then 
		print("Yes") -- If 3 was ever greater then true this will print "Yes". Since this is true it will end the entire argument of elseif. However if it was 3<2 then it would check the elseif statements!
		elseif 3==2 then
			print("Yes")
			elseif 3~=2 then
				print("True") 
	end -- Only one of them is true. That one will be 3~=2 because 3 is not equal to 2. So this will only print true. 
	-- Tables
	mytable = {1,2,3,4,5,6,7,8,9,10}
	if mytable[1] == 1 then print("true") end -- Now this may be a little tricky. mytable is a table of values. These values can be anything like functions, strings, or numbers. THEY ARE SORTED BY INDEXS' so mytable[1] is acutally checking what mytable of index 1 is. So since index 1 is 1 then 1is equal to 1!
	if mytable[2] == 3 then print("true") end -- If mytable index 2 is equal to 3 then print true. This is not correct because table index 2 is equal to 2 not 3. This will print nothing.
	-- For Loops
	for key,value in pairs(mytable) do -- Key will be index and value will be whatever the idex is equal to for example if index 1 is equal to one then (if key==1 and value==1 then print("true") end) This is true!
		if key == value then print("true") end -- This is the same thing as above. Key 1 is equal to value 1
	end
	for i=1, 10, 1 do -- a loop like this starts of with the number 1 (i=1) has a maximum value of 10 and climbs numbers by 1. 
		if mytable[i] == 1 then print("true") end -- This is like mytable[1-10] is ever equal to one then print "true". This will print true once
	end
	for i=1, 10, 2 do -- Instead of climbing the numbers by one this will climb by 2. So 1,3,5,7,9
	end
	-- Misc functions 
	error("message") -- For debug purposes really. If your code doesnt work it will print "message"
	require("C://System32") -- Put this at the top. Used for library requirements for your project.  For extra API if needed (For my machine learning algorthm i use the native Lua library)
-- General Lua Ending
-- Commenting By Feretorix on API used by my machine learning alg (Just for reference if you dont seem to get what my alorithm is doing)

--[[
OnProcessSpellComplete(function(Object,spellProc)
if Object == GetMyHero() then --we check if it's us
CastEmote(EMOTE_DANCE); --force emote cast after Q finished
MoveToXYZ(GetMousePos()); --force move to cursor to cancel dance emote
end
end)

 
Some other news are that we have:
 
OnDraw(function(myHero)
--which does the same thing as OnLoop, but soon the old "OnLoop" will get deprecated and later deleted.
end)
 
OnTick(function(myHero)
--which should be used for heavy calculations and hundreds of calls to GotBuff functions, etc without losing any performance (causing FPS lag)
 
end)
 
New SCRIPT_PATH and COMMON_PATH constants.
 
 
 
 
 
 
 
 
Changelog 15.10.2015
 
With the new update for Patch 5.20 and old 5.19, i've updated both dll's with the following changes:
 
 
-Added new API CastEmote(emoteID) which returns a boolean with success/failure (but how can it possibly fail?) (Credits to finndev @ UC Forums)
Current emote ID's:
EMOTE_DANCE, EMOTE_TAUNT, EMOTE_LAUGH, EMOTE_JOKE, EMOTE_TOGGLE.
-Added new API IsChatOpened() which returns a boolean, to check if your chat is open, good for libs.
-Added new API IsGameOnTop() which returns a boolean, to check if your game window is currently on top.
-Added Lua.IO.Library support (file manipulation functions) (fixed it's loading)
 
(Credits for events to Inspired!)
-Added new OnDraw(myHero) event which is the same as OnLoop (which will become deprecated soon™)
-Added new OnTick(myHero) event which is safe to use it to make heavy calculations without draining FPS too much.
 
Code example:
 
 
local myDrawID = OnDraw(function(myHero)
DrawText(GetObjectName(myHero),64,250,250,0xffffffff)
end)
 
--if DeleteOnDraw(myDrawID) then
-- PrintChat("Draw was removed!")
--else
-- PrintChat("Draw was NOT removed!")
--end
 
local myTickID1 = OnTick(function(myHero)
PrintChat(string.format("PassedTicks1 = %d", GetTickCount()))
end)
 
local myTickID2 = OnTick(function(myHero)
PrintChat(string.format("PassedTicks2 = %d", GetTickCount()))
end)
 
local myTickID3 = OnTick(function(myHero)
PrintChat(string.format("PassedTicks3 = %d", GetTickCount()))
end)
 
local myTickID4 = OnTick(function(myHero)
PrintChat(string.format("PassedTicks4 = %d", GetTickCount()))
end)
 
 
--if DeleteOnTick(myTickID) then
-- PrintChat("Tick was removed!")
--else
-- PrintChat("Tick was NOT removed!")
--end
 
 
 
 
 
 
 
Changelog 28.09.2015
 
 
-Added new API GetGameTimer(); returns a float value with the game time used for buffs.
-Added new API GetBuffData(myHero,"buffname"); returns struct with the following values: (credits to can1357 @ UC Forums)
retval.Type = a value from 0 to 31 containing specifying the buff type.
retval.Name = returning a string with the buffname
retval.Count = returning how much the buff is stacked (Ryze passive, Annie passive)
retval.Stacks = returns a value for a rare amount of buffs in the game which have huge stack values (Example is Nasus Q)
retval.StartTime = returns a value with the time the buff started depending on the GetGameTimer.
retval.ExpireTime = returns a value when the buff will expire depending on the GetGameTimer.
 
-Added new API GetBuffType(myHero,ID); returns the buff type for the specified ID
-Added new API GetBuffStacks(myHero,ID); returns the buff stacks for the specified ID
-Added new API GetBuffStartTime(myHero,ID); returns a float with the buff start time for the specified ID
-Added new API GetBuffExpireTime(myHero,ID); returns a float with the buff end time for the specified ID
-Added new API GetBuffTypeList(); returns a structure with the constant buff types as follows:
    Ret.Internal = 0,
    Ret.Aura = 1,
    Ret.CombatEnchancer = 2,
    Ret.CombatDehancer = 3,
    Ret.SpellShield = 4,
    Ret.Stun = 5,
    Ret.Invisibility = 6,
    Ret.Silence = 7,
    Ret.Taunt = 8,
    Ret.Polymorph = 9,
    Ret.Slow = 10,
    Ret.Snare = 11,
    Ret.Damage = 12,
    Ret.Heal = 13,
    Ret.Haste = 14,
    Ret.SpellImmunity = 15,
    Ret.PhysicalImmunity = 16,
    Ret.Invulnerability = 17,
    Ret.Sleep = 18,
    Ret.NearSight = 19,
    Ret.Frenzy = 20,
    Ret.Fear = 21,
    Ret.Charm = 22,
    Ret.Poison = 23,
    Ret.Suppression = 24,
    Ret.Blind = 25,
    Ret.Counter = 26,
    Ret.Shred = 27,
    Ret.Flee = 28,
    Ret.Knockup = 29,
    Ret.Knockback = 30,
    Ret.Disarm = 31,
-Added new API GetBuffTypeToString(BuffTypeInt); returns a string with the bufftypename depending on the ID provided.
 
-Updated OnRemoveBuff(Object,buffProc) where buffProc has the following members:
-Updated OnUpdateBuff(Object,buffProc) where buffProc has the following members:
buffProc.Type = a value from 0 to 31 containing specifying the buff type.
buffProc.Name = returning a string with the buffname
buffProc.Count = returning how much the buff is stacked (Ryze passive, Annie passive)
buffProc.Stacks = returns a value for a rare amount of buffs in the game which have huge stack values (Example is Nasus Q)
buffProc.StartTime = returns a value with the time the buff started depending on the GetGameTimer.
buffProc.ExpireTime = returns a value when the buff will expire depending on the GetGameTimer.
 
 
Some random LUA example:
 
OnUpdateBuff(function(Object,buffProc)
--PrintChat(string.format("<font color='#00ff00'>CreatedObject = %s</font>",buffProc.Name));
PrintChat(string.format("<font color='#00ff00'>Updated:</font> BuffName: [%s] BuffType: [%d] BuffCount: [%d] BuffStacks: [%f] StartTime: [%f] ExpireTime: [%f]",buffProc.Name,buffProc.Type,buffProc.Count,buffProc.Stacks,buffProc.StartTime,buffProc.ExpireTime));
end)
 
 
OnLoop(function(myHero)
buffdatas = GetBuffData(myHero,"recall");
DrawText(string.format("[RECALL_BUFF INFO]", buffdatas.Type),12,0,20,0xff00ff00);
DrawText(string.format("Type = %d", buffdatas.Type),12,0,30,0xff00ff00);
DrawText(string.format("Name = %s", buffdatas.Name),12,0,40,0xff00ff00);
DrawText(string.format("Count = %d", buffdatas.Count),12,0,50,0xff00ff00);
DrawText(string.format("Stacks = %f", buffdatas.Stacks),12,0,60,0xff00ff00);
DrawText(string.format("StartTime = %f", buffdatas.StartTime),12,0,70,0xff00ff00);
DrawText(string.format("ExpireTime = %f", buffdatas.ExpireTime),12,0,80,0xff00ff00);
DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,0,90,0xff00ff00);
bufftypelist = GetBuffTypeList();
if buffdatas.Type == bufftypelist.Aura then
DrawText("Buff is considered as aura",12,0,100,0xffffffff);
end
DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas.Type)),12,0,110,0xffffff00);
 
 
buffdatas2 = GetBuffData(myHero,"nasusqstacks");
DrawText(string.format("[NASUS(Q)BUFF INFO]", buffdatas2.Type),12,200,20,0xff00ff00);
DrawText(string.format("Type = %d", buffdatas2.Type),12,200,30,0xff00ff00);
DrawText(string.format("Name = %s", buffdatas2.Name),12,200,40,0xff00ff00);
DrawText(string.format("Count = %d", buffdatas2.Count),12,200,50,0xff00ff00);
DrawText(string.format("Stacks = %f", buffdatas2.Stacks),12,200,60,0xff00ff00);
DrawText(string.format("StartTime = %f", buffdatas2.StartTime),12,200,70,0xff00ff00);
DrawText(string.format("ExpireTime = %f", buffdatas2.ExpireTime),12,200,80,0xff00ff00);
DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,200,90,0xff00ff00);
DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas2.Type)),12,200,110,0xffffff00);
end)
 
 
 
 
 
Changelog 20.09.2015
 
-Added new API GetItemID(myHero,SLOT_1); returns a value bigger than 0 with the ITEMID number if any is found.
-Added new API GetItemStack(myHero,SLOT_1); returns value bigger than 0 if item is found, bigger than 1 for any item stacked on that slot (multiple potions in one slot)
-Added new API GetItemAmmo(myHero,SLOT_1); returns value bigger than 0 if the current item has any ammo (Crystalline Flask)
 
Added inventory slot constants:
 
ITEM_1
ITEM_2
ITEM_3
ITEM_4
ITEM_5
ITEM_6
ITEM_7
 
Some example code:
 
OnLoop(function(myHero)
local capspress = KeyIsDown(0x14); --Caps Lock key
if capspress then
local itemid = GetItemID(myHero,ITEM_1);
local itemammo = GetItemAmmo(myHero,ITEM_1);
local itemstack = GetItemStack(myHero,ITEM_1);
PrintChat(string.format("itemID in Slot 1 is = %d", itemid));
PrintChat(string.format("AMMO! in Slot 1 is = %d", itemammo));
PrintChat(string.format("STACK in Slot 1 is = %d", itemstack));
end
end)
 
 
 
Changelog 15.09.2015
 
-Added new API: DrawLine(x1,y1,x2,y2,width,color);
 
 
Example code:
 
OnLoop(function(myHero)
mymouse = WorldToScreen(1,GetMousePos());
myposition = WorldToScreen(1,GetOrigin(myHero));
if mymouse.flag and myposition.flag then
DrawLine(mymouse.x,mymouse.y,myposition.x,myposition.y,1,ARGB(255,255,255,255));
end
end)
Changelog 08.09.2015
 
-Added new event "OnWndMsg"
-Added new API "GetCursorPos"
-Added new API "GetResolution"
-Added constants for event "OnWndMsg"; WM_MOUSEHWHEEL, WM_LBUTTONDOWN, WM_LBUTTONUP, WM_RBUTTONDOWN, WM_RBUTTONUP, WM_MBUTTONDOWN, WM_MBUTTONUP, KEY_DOWN, KEY_UP.
 
Example script below:
 
OnWndMsg(function(msg,wParam)
PrintChat(string.format("msg = %d | wParam = %d", msg, wParam))
end)
 
OnLoop(function(myHero)
reso = GetResolution();
curp = GetCursorPos();
DrawText(string.format("     RES[X] = %d | RES[Y] = %d", reso.x, reso.y),30,curp.x,curp.y,ARGB(255,255,255,255));
DrawText(string.format("    MOUSE[X] = %d | MOUSE[Y] = %d", curp.x, curp.y),30,curp.x,curp.y+30,ARGB(255,255,255,255));
end)
 
Changelog 01.09.2015
 
-Added new OnProcessWaypoint event!
-Added new GetMapID.
-Added new GetBaseAttackSpeed.
-Added constants: CRYSTAL_SCAR, TWISTED_TREELINE, SUMMONERS_RIFT, HOWLING_ABYSS, RECALL
-Fixed prediction large waypoints mismatch position.
-Fixed DrawTextSmall ")" symbol support.
 
Example script below:
 
mapID = GetMapID(); --get mapID once ....
baseAS = GetBaseAttackSpeed(GetMyHero()); --get once baseAS to avoid causing FPS lag...
 
OnProcessWaypoint(function(Object,waypointProc)
if Object == GetMyHero() then
if waypointProc.index == 1 then
place = waypointProc.position;
end
if waypointProc.index == 2 then
place2 = waypointProc.position;
end
end
end)
 
OnLoop(function(myHero)
if place ~= nil then
DrawCircle(place,100,0,0,ARGB(255,255,255,255));
end
if place2 ~= nil then
DrawCircle(place2,100,0,0,ARGB(255,255,255,255));
end
if mapID == CRYSTAL_SCAR then
DrawText("Map is: CRYSTAL_SCAR",12,10,10,ARGB(255,0,255,0));
elseif mapID == TWISTED_TREELINE then
DrawText("Map is: TWISTED_TREELINE",12,10,10,ARGB(255,0,255,0));
elseif mapID == SUMMONERS_RIFT then
DrawText("Map is: SUMMONERS_RIFT",12,10,10,ARGB(255,0,255,0));
elseif mapID == HOWLING_ABYSS then
DrawText("Map is: HOWLING_ABYSS",12,10,10,ARGB(255,0,255,0));
else
DrawText(string.format("Map is unknown with ID: %d",mapID),12,10,10,ARGB(255,0,255,0));
end
if baseAS ~= nil then
DrawText(string.format("My BaseAttackSpeed is: %f",baseAS),12,10,20,ARGB(255,0,255,0));
end
end)
Changelog 25.08.2015
 
-Added 4 new functions (events).
-Fixed GetObjectBaseName to properly read names longer than 15 bytes.
Example code with the latest events:
 
 
OnUpdateBuff(function(Object,BuffName,Stacks)
PrintChat(string.format("<font color='#00ff00'>Champion [%s] Updated: [%s] Stacks: [%d]</font>",GetObjectName(Object),BuffName,Stacks));
end)
 
 
OnRemoveBuff(function(Object,BuffName)
PrintChat(string.format("<font color='#ff0000'>Champion [%s] Removed: [%s]</font>",GetObjectName(Object),BuffName));
end)
 
 
OnCreateObj(function(Object) --Object is a pointer to the object created by the game just now.
PrintChat(string.format("<font color='#00ff00'>CreatedObject = %s</font>",GetObjectBaseName(Object)));
--NetworkID for newly created objects is always 0, just save the object pointer instead
end)
 
 
OnDeleteObj(function(Object) --Object is a pointer to the object deleted by the game just now.
--if GetNetworkID(Object) > 0 then --this line could be used to track objects only with NETID
PrintChat(string.format("<font color='#ff0000'>DeletedObject = %s</font>",GetObjectBaseName(Object)));
--end --this line is used only if we're closing the GetNetworkID check
end)
 
 
 
 
 
Changelog 23.08.2015
 
-Added new function IsTargetable(Object); returns a boolean (true) if you can attack the target, and false if you can't (for example Vladimir currently is using his blood pool)
-Improved IsImmune(Object); now checks only for immortality buffs like Trynda, Kayle, Zilean, Poppy ultimates & more. For additional checks use IsTargetable (Vlad Pool, Fizz Trickster, Yi AlphaStrike, Kogmaw SupriseDeath, Karthus DeathBuff ... etc)
 
 
 
 
Changelog 06.08.2015
 
Added new function LevelSpell(spellid); --returns a boolean true/false if success or failure
Added new function CastSkillShot3(spellid,startpos,endpos); --could be used for Viktor[E] or Rumble[R] and any other spell which requires two positions.
 
local tabpress = KeyIsDown(9); --TAB key
if tabpress then
lvlp = LevelSpell(_Q);
if lvlp == true then
MessageBox(0,"LVLUP Q SUCCESS!","Nice!",0);
else
MessageBox(0,"LVLUP Q FAILURE!","Bad!",0);
end
end
 
local shiftpress = KeyIsDown(0x10); --Shift Key
if shiftpress then
CastSkillShot3(_E,myorigin,mymouse); --cast victor [E] from ourself to our mouse pos
end
Changelog 03.08.2015
 
Added new event: OnDrawMinimap(function() which could be used to draw over everything, not only minimap, but it's not recommended to use.
Added WorldToMinimap(position) .... returns X,Y
 
 
 
OnDrawMinimap(function()
 
local myHero = GetMyHero();
local myorigin = GetOrigin(myHero);
 
minipos = WorldToMinimap(myorigin);
 
DrawText("me!",12,minipos.x,minipos.y,ARGB(255,255,255,255));
 
end)
 
 
 
 
 
Changelog 31.07.2015
 
Added new function "ARGB(255,255,255,255)" used in other drawing funcs to fix color bugs with values bigger than 7FFFFFFF.
Added possibility to use directly a "vector" instead of "vector.x","vector.y","vector.z"
 
OnLoop(function(myHero)
 
local origin = GetOrigin(myHero);
local mymouse = GetMousePos();
 
local shiftpress = KeyIsDown(0x10); --Shift Key
if shiftpress then
CastSkillShot(_Q,mymouse); --start charging Xerath Q
end
 
local tabpress = KeyIsDown(9); --TAB key
if tabpress then
CastSkillShot2(_Q,mymouse); --release charged Xerath Q
end
 
local capspress = KeyIsDown(0x14); --Caps Lock key
if capspress then
MoveToXYZ(mymouse);
end
 
local myscreenpos = WorldToScreen(1,origin);
if myscreenpos.flag then
FillRect(myscreenpos.x-200,myscreenpos.y-200,100,100,ARGB(220,0,0xff,100)); --you can use both int and hex
DrawDmgOverHpBar(myHero,GetCurrentHP(myHero),220,60,ARGB(255,255,255,255)); --full white color
DrawText("New ARGB!",24,myscreenpos.x,myscreenpos.y,ARGB(255,0,255,0)); --full green color
DrawTextSmall("hEllO wOrLd!",myscreenpos.x,myscreenpos.y-20,ARGB(0xff,0,0xff,0)); --full green color again (in hex)
 
DrawCircle(origin,300,0,0,0xffffffff); --white with direct origin table
DrawCircle(origin.x,origin.y,origin.z,350,0,0,0xffff0000); --red with separate origin table
DrawCircle(origin,400,0,0,ARGB(0xff,0,0xff,0)); --green with direct origin table
DrawCircle(origin.x,origin.y,origin.z,450,0,0,ARGB(0xff,0,0,0xff)); --blue with separate origin table
end
 
end)
 
Changelog 28.07.2015
 
 
Added support for classes thanks to  Inspired!
 
 
-- define class Point
class "Point" -- {
  function Point:__init(x, y, z) -- this constructor gets called when we create a new Point(x,y,z)
    local pos = GetOrigin(x) or type(x) ~= "number" and x or nil -- check if the input is a position or an object instead of x,y,z coordinates
    self.x = pos and pos.x or x -- set x
    self.y = pos and pos.y or y -- set y
    self.z = pos and pos.z or z -- set z
  end
-- }
 
-- create some points
local p1 = Point(myHero) -- create a new point of myHero coordinates
local p2 = Point(GetMousePos()) -- create a new point of mouse coordinates
local p3 = Point(100,10,100) -- create a new point with defined coordinates
 
-- print distances between the three points in chat
PrintChat(GetDistance(p1, p2)) 
PrintChat(GetDistance(p2, p3))
PrintChat(GetDistance(p1, p3))
 
Changelog 27.07.2015
 
OnProcessRecall detects recalling in FOW!
PrintChat("text"); --prints a text on the lol chat
CastSpell(_R); --selfcast a spell (like Katar R, Kata W, Potions, and much more - self targetable)
CastSkillShot2(_Q,mymouse.x,mymouse.y,mymouse.z); --release already charged Xerath Q
 
 
--GamingOnSteroids.com lua API file (with some basic examples)
 
--available constants by GoS
--[[
 
/////////////////////////
Spell slots used by "CastTargetSpell", "CastSkillShot" and more ...:
_Q
_W
_E
_R
SUMMONER_1
SUMMONER_2
////////////////////////
Spellstates returned by "CanUseSpell":
READY
NOTAVAILABLE
NOTLEARNED
READYNONCAST
UNKNOWN
ONCOOLDOWN
NOMANA
////////////////////////
ObjectTypes returned by "GetObjectType" (the engine might have more, but they're not declared in GoS):
Obj_AI_SpawnPoint
Obj_AI_Camp
Obj_AI_Barracks
Obj_AI_Hero
Obj_AI_Minion
Obj_AI_Turret
Obj_AI_LineMissle
Obj_AI_Shop
 

 
 
 
 
OnProcessRecall(function(Object,recallProc) --Object is a pointer to the player which is recalling; recallProc is a struct with additional info
--recallProc.name = the name of the recall spell
--recallProc.isStart = returns a boolean = true if the player just started recalling
--recallProc.isFinish = returns a boolean = true if the player successfully recalled to spawn
-- if both (isStart == false and isFinish == false) then it means that recall got canceled/interrupted
--recallProc.passedTime = returns an integer with the passed time since the start of the recall
--recallProc.totalTime  = returns an integer with the total expected time for the recall spell
 
 
 
if recallProc.isStart == true then
PrintChat(string.format("Currently %s <font color='#ffffff'>STARTED</font> %s for total time %d", GetObjectName(Object), recallProc.name, recallProc.totalTime))
elseif recallProc.isFinish == true then
PrintChat(string.format("Currently %s <font color='#00aaff'>FINISHED</font> Recall to the base for passed time %d", GetObjectName(Object), recallProc.passedTime))
else
PrintChat(string.format("Currently %s <font color='#ffaa00'>FAILED</font> to Recall to the base for passed time %d", GetObjectName(Object), recallProc.passedTime))
end
 
 
end)
 
 
 
 
OnProcessSpell(function(Object,spellProc) --Object is a pointer to the caster of the spell; spellProc is a struct with some spell datas
--spellProc.name = the name of the current spell cast (including autoattacks and such)
--spellProc.windUpTime = number holding the value of the required animation time for an attack to complete
--spellProc.animationTime = number holding the full animation time of an attack or spell (always greater than windUpTime)
--spellProc.castSpeed = proportional to "GetAttackSpeed(myHero);", returns the speed value of the casted spell or attack.
--spellProc.startPos.x
--spellProc.startPos.y = returns a VECTOR holding the starting position of the spell cast (often the same as GetOrigin(Object))
--spellProc.startPos.z 
--||||||||||||||||||||
--spellProc.endPos.x
--spellProc.endPos.y = returns a VECTOR holding the ending position of the spell cast (often the same as GetOrigin(Object))
--spellProc.endPos.z 
--||||||||||||||||||||
--spellProc.target = returns a pointer to a target if there is any (for example Ryze Q is skillshot without target, but his W does have target)
 
if myher0 == Object then
--MessageBox(0,spellProc.name,tostring(spellProc.windUpTime),0);
end
 
end)
 
 
 
OnObjectLoop(function(Object,myHero) --Object is a pointer to the current object, ObjectLoopEvent is looping trough all objects each frame.
local Obj_Type = GetObjectType(Object);
if Obj_Type == Obj_AI_Hero then
if IsObjectAlive(Object) then
local HPBARPOS = GetHPBarPos(Object); --returns X/Y integer values holding the hpbar position of the object
if HPBARPOS.x > 0 then
if HPBARPOS.y > 0 then
DrawText("Champ HpBarPosition is Here!",12,HPBARPOS.x,HPBARPOS.y,0xffffff00);
end
end
end
end
end)
 
 
 
global_ticks = 0; --global variable with system ticks later used for potion drinking ...
OnLoop(function(myHero) --myHero is pointer to our champion; AfterObjectLoopEvent itself is happening every game frame.
 
myher0 = myHero;
 
local Obj_Type = GetObjectType(myHero); --returns string holding the name of the object type (champion, minion, turret, etc)
local Obj_BaseName = GetObjectBaseName(myHero); --returns a string holding the basename, often used when GetObjectName is empty or incorrect
local deadflag = IsDead(myHero); --returns a boolean, true if dead, false if alive
local team = GetTeam(myHero); --returns an int, holding the team (100;200 or 300 for jungle team)
local origin = GetOrigin(myHero); --returns a xyz VECTOR of the specific object in the world; in this case "origin.x" "origin.y" and "origin.z"
local currhp = GetCurrentHP(myHero); --returns the current health of the object
local maxhp = GetMaxHP(myHero);  --returns the maximum health of the object
local junglecampbool = IsCampusUp(myHero);  --this can't be used with myHero object, instead only for a jungle camp, will return true if it's UP
local currmana = GetCurrentMana(myHero);  --returns the current mana/energy of the champion (should be 0 for Katarina, Vladimir, etc)
local maxmana = GetMaxMana(myHero); --returns the maximum mana/energy of the champion
local magicshield = GetMagicShield(myHero); --returns the value of the magic damage shield applied to the champion (probably by Morgana E)
local dmgshield = GetDmgShield(myHero);  --returns the standart shield value a champion has (like Riven E; Lux W; and much more)
local champname = GetObjectName(myHero);  --returns a string with the champion name (for example Ryze, Annie etc)
local cdr = GetCDR(myHero);  --returns the cooldown reduction of the champion
local apf = GetArmorPenFlat(myHero);  --returns the flat armor penetration value of the champion (probably by runes or blrutalizer item)
local mpf = GetMagicPenFlat(myHero);  --returns the same thing as above, but for flat magic penetration
local app = GetArmorPenPercent(myHero);  --returns the percentage of armor penetration
local mpp = GetMagicPenPercent(myHero);  --returns the percentage of magic penetration
local bonusdmg = GetBonusDmg(myHero); --returns the bonus AD damage by items/runes/buffs etc
local bonusap = GetBonusAP(myHero); --returns the bonus AP damage by items/runes/buffs etc
local lifesteal = GetLifeSteal(myHero); --returns the lifesteal percentage of a champion
local spellvamp = GetSpellVamp(myHero); --returns the spellvamp percentage of a champion
local attspd = GetAttackSpeed(myHero); --returns the attack speed percentage of a champion
local basedmg = GetBaseDamage(myHero); --returns the base champion attack damage (works for minions and others too)
local crit = GetCritChance(myHero); --returns the critical strike percentage of a champion
local armor = GetArmor(myHero); --returns the total armor of an object
local magicres = GetMagicResist(myHero);  --returns the magic resist of an object
local hpregen = GetHPRegen(myHero);  --returns the health regeneration ratio of an object
local mpregen = GetMPRegen(myHero);  --returns the mana/energy regeneration of an object
local movespd = GetMoveSpeed(myHero);  --returns the move speed of an object
local range = GetRange(myHero); --returns the attack range of an object
 
 
local buffcnt = GotBuff(myHero,"OdinRecall"); --returns how much stacks we have of a specific buff; returns 0 if we don't have the buff
--test1 = GetBuffCount(myHero,4); --returns a value bigger than 1 (if the buff at index 4 is actually valid, min index 0, max index 63)
--testname = GetBuffName(myHero,4); --returns a string with a buffname (if the buff at index 4 is valid and has GetBuffCount(myHero,4) > 0)
--immune = IsImmune(Object,myHero); --returns a boolean true if the "Object" is immune to damage and can't be killed (Tryndamere ulti; etc)
 
local potionslot = GetItemSlot(myHero,2003); --returns a value > than 0 if the item is found; this value is used in CastSpell as slot
 
local castlevel = GetCastLevel(myHero,_Q); --returns how much the Q spell has been leveled up
local castrange = GetCastRange(myHero,_Q); --returns the range of the Q spell determined by the game engine
local castmana = GetCastMana(myHero,_Q,castlevel);  --returns the mana required to cast Q on the specific level it is
local castcd = GetCastCooldown(myHero,_Q,castlevel);  --returns the cooldown of the Q spell depending on the level it is currently
local castname = GetCastName(myHero,_Q);  --returns the current name of the Q spell (it changes for Nidalee and other champs depending on form)
local castusage = CanUseSpell(myHero,_Q); --returns the current state of the Q spell; READY=0;NOTAVAILABLE=1;NOTLEARNED=2;READYNONCAST=3;UNKNOWN=4;ONCOOLDOWN=5;NOMANA=6;
 
 
local hitboxsize = GetHitBox(myHero); --returns a value with the "size (range)" of the object's hitbox
local mylevel = GetLevel(myHero); --returns an int value from 1 to 18 with the player's level
local myexp = GetExperience(myHero);  --returns a value with the total experience gained so far
local amivisible = IsVisible(myHero);  --returns a boolean if an object is visible (not in Fog Of War)
local isobjalive = IsObjectAlive(myHero); --returns a boolean if the object is not dead and has health bigger than 0
local mypingval = GetLatency(); --returns an integer with the value of our ping ingame
local os_clock = GetTickCount(); --returns an integer with the passed ticks in the system
local mynetid = GetNetworkID(myHero); --returns an integer with the netID for an object
 
 
 
--CastTargetSpell(Object,_Q); --casts Q spell at target "Object"
--CastSkillShot(_Q,origin.x,origin.y,origin.z); --casts Q spell as a skillshot at target location "origin" (fixed a typo; it's CastSkillShot)
--MoveToXYZ(origin.x,origin.y,origin.z); --Moves your champion to "origin"
--HoldPosition(); --stops your champion from attacking and moving
--AttackUnit(Object);  --attacks "Object" with an auto-attack if it's an enemy.
 
local capspress = KeyIsDown(0x14); --Caps Lock key
if capspress then
if BuyItem(1027) then --Saphire Mana Crystal (400gold)
MessageBox(0,"Saphire bought!","Nice!",0);
end
end
 
--we got "origin" by GetOrigin(myHero);
DrawCircle(origin.x,origin.y,origin.z,300,0,0,0xffffffff); --draws a circle around object (params: x,y,z,radius,width,quality,colorARGB);
--width by default is 0; anything above that draws another extra circle
--quality by default is 0 so it will be handled by GoS settings which are set by the user
 
 
local myscreenpos = WorldToScreen(1,origin.x,origin.y,origin.z); --transforms xyz to screen xy coordinates; (params: visfix,x,y,z; and returns a struct x,y,flag)
if myscreenpos.flag then
DrawText("Testing... This text was changed",24,myscreenpos.x,myscreenpos.y,0xff00ff00); --draws a text to XY coords; (params: text,size,x,y,color)
--if "size" is not 12, but 0 it will use GoS setting set by the user for default text size
 
DrawTextSmall("hEllO wOrLd",myscreenpos.x,myscreenpos.y-20,0xff00ff00); --draws small text to XY coords; (params: text,x,y,color)
--note that this "smal" font is custom pixel made and it drains FPS on slow PC's if used in huge quantities
 
FillRect(myscreenpos.x-200,myscreenpos.y-200,100,100,0x50ffffff); --fills a rect pixels with a specific color; (params x,y,width,height,color)
 
DrawDmgOverHpBar(myHero,currhp,120,60,0xffffffff);  --draws specific damage over enemy or ally champion in a specific color, takes into account shields
--(params: heropointer,currenthp,adandtruedmg,apdmg,color)
end
 
local mousepos = GetMousePos(); --returns a xyz VECTOR of your mouse position in the 3d world
DrawCircle(mousepos.x,mousepos.y,mousepos.z,150,0,0,0xff00ff00); --draw a green circle around the mouse with 150 radius
 
 
local myTarget = GetCurrentTarget(); --returns your current target (if any available) based on current GoS logic.
 
 
if myTarget ~=nil then
mypred = GetPredictionForPlayer(origin,myTarget,GetMoveSpeed(myTarget),1700,250,castrange,50,true,true);
--Parameters: CastStartPosVec,EnemyChampionPtr,EnemyMoveSpeed,YourSkillshotSpeed,SkillShotDelay,SkillShotRange,SkillShotWidth,MinionCollisionCheck,AddHitBox;
--return value: ret.PredPos.x; ret.PredPos.y; ret.PredPos.z; ret.HitChance (1 or 0 for now)
if mypred.HitChance == 1 then
DrawCircle(mypred.PredPos.x,mypred.PredPos.y,mypred.PredPos.z,150,3,255,0xff00ff00) --draw a green circle if we can hit the enemy
else
DrawCircle(mypred.PredPos.x,mypred.PredPos.y,mypred.PredPos.z,150,3,255,0xffff0000) --draw a red circle if we can't hit the enemy
end
end
 
 
currtickz = GetTickCount();
if (global_ticks + 15000) < currtickz then   -- if the ticks + 15 seconds is smaller than "now" (GetTickCount), then 15 seconds have passed
local potionslot = GetItemSlot(myHero,2003);  --get potions slot if available
if potionslot > 0 then
if GetCurrentHP(myHero) < GetMaxHP(myHero) then  --check if we have less current HP than MAXHP
global_ticks = currtickz  --set global_ticks to "now" so a wait of 15 seconds will occur once again
CastSpell(potionslot)  -- "selfcast spell" at "potionslot" (whatever the slot is)
--Katarina R cast would look like CastSpell(_R)
end
end
    end
 
 
local shiftpress = KeyIsDown(0x10); --Shift Key
if shiftpress then
mymouse = GetMousePos();
CastSkillShot(_Q,mymouse.x,mymouse.y,mymouse.z); --start charging Xerath Q
end
local tabpress = KeyIsDown(9); --TAB key
if tabpress then
mymouse = GetMousePos();
CastSkillShot2(_Q,mymouse.x,mymouse.y,mymouse.z); --release charged Xerath Q
end
 
 
 
-- print all the local variables we got so far from myHero
DrawText("Remember that using DrawText so much in an actual script will obviously cause huge FPS drops. This is a test example.",24,0,0,0xffff0000);
DrawText(string.format("Obj_Type = %s", Obj_Type),12,0,30,0xff00ff00);
DrawText(string.format("Obj_BaseName = %s", Obj_BaseName),12,0,40,0xff00ff00);
DrawText(string.format("deadflag = %s", tostring(deadflag)),12,0,50,0xff00ff00);
DrawText(string.format("team = %d", team),12,0,60,0xff00ff00);
DrawText(string.format("x,y,z = %f; %f; %f", origin.x, origin.y, origin.z),12,0,70,0xff00ff00);
DrawText(string.format("currhp = %f", currhp),12,0,80,0xff00ff00);
DrawText(string.format("maxhp = %f", maxhp),12,0,90,0xff00ff00);
DrawText(string.format("currmana = %f", currmana),12,0,100,0xff00ff00);
DrawText(string.format("maxmana = %f", maxmana),12,0,110,0xff00ff00);
DrawText(string.format("magicshield = %f", magicshield),12,0,120,0xff00ff00);
DrawText(string.format("dmgshield = %f", dmgshield),12,0,130,0xff00ff00);
DrawText(string.format("champname = %s", champname),12,0,140,0xff00ff00);
DrawText(string.format("cdr = %f", cdr),12,0,150,0xff00ff00);
DrawText(string.format("armorpenflat = %f", apf),12,0,160,0xff00ff00);
DrawText(string.format("magicpenflat = %f", mpf),12,0,170,0xff00ff00);
DrawText(string.format("armorpenpercent = %f", app),12,0,180,0xff00ff00);
DrawText(string.format("magicpenpercent = %f", mpp),12,0,190,0xff00ff00);
DrawText(string.format("bonusdmg = %f", bonusdmg),12,0,200,0xff00ff00);
DrawText(string.format("bonusap = %f", bonusap),12,0,210,0xff00ff00);
DrawText(string.format("lifesteal = %f", lifesteal),12,0,220,0xff00ff00);
DrawText(string.format("spellvamp = %f", spellvamp),12,0,230,0xff00ff00);
DrawText(string.format("attspd = %f", attspd),12,0,240,0xff00ff00);
DrawText(string.format("basedmg = %f", basedmg),12,0,250,0xff00ff00);
DrawText(string.format("critchance = %f", crit),12,0,260,0xff00ff00);
DrawText(string.format("armor = %f", armor),12,0,270,0xff00ff00);
DrawText(string.format("magicres = %f", magicres),12,0,280,0xff00ff00);
DrawText(string.format("hpregen = %f", hpregen),12,0,290,0xff00ff00);
DrawText(string.format("mpregen = %f", mpregen),12,0,300,0xff00ff00);
DrawText(string.format("movespeed = %f", movespd),12,0,310,0xff00ff00);
DrawText(string.format("range = %f", range),12,0,320,0xff00ff00);
 
DrawText(string.format("Got OdinRecallBuff? = %d", buffcnt),12,0,340,0xff00ff00);
 
DrawText(string.format("HealthPotionSlot = %d", potionslot),12,0,360,0xff00ff00);
 
DrawText(string.format("Q CastLevel = %d", castlevel),12,0,380,0xff00ff00);
DrawText(string.format("Q CastRange = %f", castrange),12,0,390,0xff00ff00);
DrawText(string.format("Q CastMana  = %f", castmana),12,0,400,0xff00ff00);
DrawText(string.format("Q CastCD    = %f", (castcd + (castcd * cdr))),12,0,410,0xff00ff00);
DrawText(string.format("Q CastName  = %s", castname),12,0,420,0xff00ff00);
DrawText(string.format("Q CastUsage = %d", castusage),12,0,430,0xff00ff00);
 
DrawText(string.format("hitboxsize = %f", hitboxsize),12,0,450,0xff00ff00);
DrawText(string.format("mylevel = %d", mylevel),12,0,460,0xff00ff00);
DrawText(string.format("myexp = %f", myexp),12,0,470,0xff00ff00);
DrawText(string.format("amivisible? = %s", tostring(amivisible)),12,0,480,0xff00ff00);
DrawText(string.format("isobjectalive? = %s", tostring(isobjalive)),12,0,490,0xff00ff00);
DrawText(string.format("Ping(ms): %d", mypingval),12,0,500,0xff00ff00);
DrawText(string.format("GetTickCount = %d", os_clock),12,0,510,0xff00ff00);
DrawText(string.format("NetworkID    = %X", mynetid),12,0,520,0xff00ff00);
 
end)]]

-- Completly Annotated Script by me!
--[[
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
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 870) and Combo.Co3 and ValidTarget(unit, 860) then
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

]]
