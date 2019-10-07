AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_sin/characters/elexis/naked_elexis.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 700
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.HullSizeNormal = false -- set to false to cancel out the self:SetHullSizeNormal()
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_SINTEK"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Red"
ENT.Weapon_NoSpawnMenu = true
ENT.HasItemDropsOnDeath = false
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.SquadName = "vj_SinTek" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackModel = "models/vj_sin/weapons/grenades/frag_grenade.mdl"
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav",
}
ENT.SoundTbl_WeaponReload = {"vj_sin/jessica/jess_bttrreload.wav"}
ENT.SoundTbl_Alert = {"vj_sin/jessica/jess_igotatarg.wav","vj_sin/jessica/jess_mvidonthavetm.wav","vj_sin/jessica/jess_incoming2.wav"}
ENT.SoundTbl_CombatIdle = {"vj_sin/jessica/jess_ifguygetwy.wav",}
ENT.SoundTbl_FollowPlayer = {"vj_sin/jessica/jess_woahfelleye.wav","vj_sin/jessica/jess_getmndoutgt.wav","vj_sin/jessica/jess_newgame.wav","vj_sin/jessica/jess_ithtelextype.wav"}
ENT.SoundTbl_UnFollowPlayer = {"vj_sin/jessica/jess_friends.wav","vj_sin/jessica/jess_kicknotlick.wav"}
ENT.SoundTbl_OnPlayerSight = {"vj_sin/jessica/jess_doihavesmbutt.wav","vj_sin/jessica/jess_hey.wav","vj_sin/jessica/jess_neverfigass.wav"}
ENT.SoundTbl_OnGrenadeSight = {"vj_sin/jessica/jess_takecover2.wav","vj_sin/jessica/jess_jzwatchnds.wav"}
ENT.SoundTbl_Pain = {
	"vj_sin/jessica/jess_notfeelinsohot.wav",
	"vj_sin/jessica/jess_pain1.wav",
	"vj_sin/jessica/jess_pain2.wav",
	"vj_sin/jessica/jess_pain3.wav",
	"vj_sin/jessica/jess_pain4.wav",
	"vj_sin/jessica/jess_pain5.wav",
	"vj_sin/jessica/jess_pain6.wav",
	"vj_sin/jessica/jess_pain7.wav",
	"vj_sin/jessica/jess_pain8.wav",
	"vj_sin/jessica/jess_pain9.wav",
	"vj_sin/jessica/jess_pain10.wav",
	"vj_sin/jessica/jess_pain11.wav"
}
ENT.SoundTbl_Death = {
	"vj_sin/jessica/jess_death1.wav",
	"vj_sin/jessica/jess_death2.wav",
	"vj_sin/jessica/jess_death3.wav",
	"vj_sin/jessica/jess_death4.wav",
}

ENT.GeneralSoundPitch1 = 100
function ENT:Elexis_PlaySound(snd,time)
	timer.Simple(time,function()
		if self:IsValid() then
			VJ_EmitSound(self,snd,80,100)
		end
	end)
end

function ENT:CustomOnInitialize()
	self:ManipulateBoneJiggle(105,1) -- Breasts
	self:ManipulateBoneJiggle(107,1)
	self:ManipulateBoneJiggle(110,1) -- Necklace
	self:ManipulateBoneJiggle(67,1) -- Hair
	self:ManipulateBoneJiggle(69,1)
	self:ManipulateBoneJiggle(75,1)
	self:ManipulateBoneJiggle(87,1)
	self:ManipulateBoneJiggle(100,1)

	self.GodMode = true
	self.DisableMakingSelfEnemyToNPCs = true
	self.MoveOrHideOnDamageByEnemy = false
	self.RunAwayOnUnknownDamage = false
	timer.Simple(0.1,function()
		if self:IsValid() then
			self.GodMode = false
			self:SetNPCState(NPC_STATE_SCRIPT)
			self:SetAngles(Angle(self:GetAngles().x,self:GetAngles().y,self:GetAngles().z))
			local animtime = self:SequenceDuration(self:LookupSequence("Dream_Sequence")) +0.1
			self:VJ_PlaySequence("Dream_Sequence",1,true,animtime)
			self:Elexis_PlaySound("vj_sin/elexis/elex_ohblddd.wav",1)
			self:Elexis_PlaySound("vj_sin/elexis/elex_uthnknaught.wav",2.75)
			self:Elexis_PlaySound("vj_sin/elexis/elex_hmmmicrocosm.wav",6.8)
			self:Elexis_PlaySound("vj_sin/elexis/elex_ivisionary.wav",11)
			self:Elexis_PlaySound("vj_sin/elexis/elex_iwillchngwrld.wav",13.9)
			timer.Simple(animtime,function()
				if self:IsValid() then
					self.DisableMakingSelfEnemyToNPCs = false
					self.MoveOrHideOnDamageByEnemy = true
					self.RunAwayOnUnknownDamage = true
					self:SetNPCState(NPC_STATE_NONE)
					self:StartEngineTask(GetTaskList("TASK_RESET_ACTIVITY"),0)
					self:ClearSchedule()
				end
			end)
		end
	end)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/