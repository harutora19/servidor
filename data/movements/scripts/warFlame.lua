local wtp = {
{frompos = {x=125,y=892,z=6}, topos = {x=125,y=890,z=6}},
{frompos = {x=126,y=892,z=6}, topos = {x=126,y=890,z=6}},

{frompos = {x=111,y=877,z=6}, topos = {x=114,y=877,z=6}},
{frompos = {x=111,y=878,z=6}, topos = {x=114,y=878,z=6}},

{frompos = {x=139,y=877,z=6}, topos = {x=136,y=877,z=6}},
{frompos = {x=139,y=878,z=6}, topos = {x=136,y=878,z=6}},

{frompos = {x=124,y=857,z=6}, topos = {x=124,y=859,z=6}},
{frompos = {x=125,y=857,z=6}, topos = {x=125,y=859,z=6}},

{frompos = {x=140,y=881,z=6}, topos = {x=140,y=878,z=6}},
{frompos = {x=140,y=879,z=6}, topos = {x=140,y=882,z=6}},

{frompos = {x=110,y=881,z=6}, topos = {x=110,y=878,z=6}},
}

function onStepIn(cid, item, position, fromPosition)

	for i,v in pairs(wtp) do
		if v.frompos.x == position.x and v.frompos.y == position.y then
			doTeleportThing(cid, v.topos)
			break
		end
	end
return true
end