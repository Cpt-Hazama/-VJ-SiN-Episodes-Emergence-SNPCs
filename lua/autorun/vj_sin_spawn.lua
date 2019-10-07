/*--------------------------------------------------
	=============== SiN Episodes: Emergence SNPCs Spawn ===============
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to load spawns for SiN Episodes: Emergence SNPCs
--------------------------------------------------*/
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('autorun/vj_controls.lua')

local vCat = "SiN Episodes: Emergence"
VJ.AddNPC_HUMAN("Jessica","npc_vj_sin_jessica",{"weapon_vj_sin_m90","weapon_vj_sin_m590","weapon_vj_sin_x380"},vCat)

VJ.AddNPC("Leperkin","npc_vj_sin_leperkin",vCat)
-- VJ.AddNPC("Hopper","npc_vj_sin_hopper",vCat)
-- VJ.AddNPC("Quadralex","npc_vj_sin_quadralex",vCat)

VJ.AddNPC_HUMAN("Elexis","npc_vj_sin_elexis",{"weapon_vj_sin_x380"},vCat)
VJ.AddNPC("Elexis (Dream)","npc_vj_sin_elexis_naked",vCat)
VJ.AddNPC_HUMAN("SinTek Grunt","npc_vj_sin_sintek",{"weapon_vj_sin_chaingun"},vCat)
VJ.AddNPC_HUMAN("SinTek Soldier","npc_vj_sin_sintek_soldier",{"weapon_vj_sin_m90","weapon_vj_sin_m590","weapon_vj_sin_x380"},vCat)

VJ.AddNPCWeapon("VJ_SiN-M90_Magnum","weapon_vj_sin_m90")
VJ.AddNPCWeapon("VJ_SiN-M590_Assault_Rifle","weapon_vj_sin_m590")
VJ.AddNPCWeapon("VJ_SiN-X380_Prototype_Scattergun","weapon_vj_sin_x380")
VJ.AddNPCWeapon("VJ_SiN-Chaingun","weapon_vj_sin_chaingun")