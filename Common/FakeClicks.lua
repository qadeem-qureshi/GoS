require("Inspired")
myspriteID = { 
["Attack"] = CreateSpriteFromFile("\\FakeClicks\\Attack.png"),
["Cursor"] = CreateSpriteFromFile("\\FakeClicks\\Mouse.png"),
}
Callback.Add("IssueOrder", function(order) IssueOrders(order) end)
function IssueOrders(order)
	if order.flag == 3 then
		Callback.Add("Draw", function()
		DrawSprite(myspriteID["Attack"],GetCursorPos().x, GetCursorPos().y,0,0,0,0,ARGB(255,255,255,255))
		end)
	end
	if order.flag == 2 then
		Callback.Add("Draw", function()
		DrawSprite(myspriteID["Cursor"],GetCursorPos().x, GetCursorPos().y,0,0,0,0,ARGB(255,255,255,255))
		end)
	end 
end
PrintChat("Disable Show mouse in obs or whatever, this does not show clicks (greens things), this does show mouse and attack but they are glitched if you attack and move
not recommended for use because of lag. tl;dr right now it is pretty much worthless.")
