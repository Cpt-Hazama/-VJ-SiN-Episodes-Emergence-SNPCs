AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_sin/characters/sintekgrunt/sintekgrunt.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 100
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.DropWeaponOnDeath = false
ENT.HullSizeNormal = false -- set to false to cancel out the self:SetHullSizeNormal()
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_SINTEK"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Red"
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 10
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.SquadName = "vj_SinTek" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackModel = "models/vj_sin/weapons/grenades/frag_grenade.mdl"
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchAnimation_UseSchedule = true -- false = SCHED_ | true = ACT_
ENT.ScheduleTbl_Flinch = {SCHED_FLINCH_PHYSICS} -- If it uses schedule-based animation, implement the schedule types here | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_sin/npc/grunt/gear1.wav",
	"vj_sin/npc/grunt/gear2.wav",
	"vj_sin/npc/grunt/gear3.wav",
	"vj_sin/npc/grunt/gear4.wav",
	"vj_sin/npc/grunt/gear5.wav",
	"vj_sin/npc/grunt/gear6.wav",
	"vj_sin/npc/grunt/gear7.wav",
	"vj_sin/npc/grunt/gear8.wav",
	"vj_sin/npc/grunt/gear9.wav",
	"vj_sin/npc/grunt/gear10.wav"
}
ENT.SoundTbl_Idle = {"vj_sin/vo/npc/elite/scannbio.wav","vj_sin/vo/npc/elite/scansect.wav","vj_sin/vo/npc/elite/reqrecon.wav",}
ENT.SoundTbl_Alert = {"vj_sin/vo/npc/elite/weaponlss.wav","vj_sin/vo/npc/elite/takefire.wav","vj_sin/vo/npc/elite/iminpurs.wav","vj_sin/vo/npc/elite/imtakiny.wav","vj_sin/vo/npc/elite/finishthis.wav","vj_sin/vo/npc/elite/comeon.wav",}
ENT.SoundTbl_CombatIdle = {"vj_sin/vo/npc/elite/unstopp.wav","vj_sin/vo/npc/elite/targconf.wav","vj_sin/vo/npc/elite/targrng.wav","vj_sin/vo/npc/elite/thatall.wav","vj_sin/vo/npc/elite/alteringappv.wav"}
ENT.SoundTbl_OnGrenadeSight = {"vj_sin/vo/npc/elite/grenade.wav","vj_sin/vo/npc/elite/grenade3.wav"}
ENT.SoundTbl_CallForHelp = {"vj_sin/vo/npc/elite/requback.wav","vj_sin/vo/npc/elite/flanktarget.wav","vj_sin/vo/npc/elite/flankpos.wav","vj_sin/vo/npc/elite/coverme.wav"}
ENT.SoundTbl_Pain = {"vj_sin/vo/npc/elite/dammit.wav","vj_sin/vo/npc/elite/pain1.wav","vj_sin/vo/npc/elite/pain2.wav","vj_sin/vo/npc/elite/pain3.wav","vj_sin/vo/npc/elite/pain4.wav","vj_sin/vo/npc/elite/pain5.wav"}
ENT.SoundTbl_WeaponReload = {"vj_sin/vo/npc/elite/coverme.wav"}
ENT.SoundTbl_OnPlayerSight = {"vj_sin/vo/npc/elite/sinsold_farenough.wav","vj_sin/vo/npc/elite/lockedon.wav","vj_sin/vo/npc/elite/holdhispos.wav",}

	-- Custom --
ENT.NextSparkT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	-- if (dmginfo:IsBulletDamage()) then
		self:EmitSound("vj_sin/npc/grunt/helmet_impact" .. math.random(1,2) .. ".wav",70)
		dmginfo:SetDamage(math.Round(dmginfo:GetDamage() /4))
		if DamageType == DMG_ACID then return false end
		if DamageType == DMG_RADIATION then return false end
		if DamageType == DMG_POISON then return false end
		if DamageType == DMG_CRUSH then return false end
		if DamageType == DMG_SLASH then return false end
		if DamageType == DMG_GENERIC then return false end
		if (self:IsOnFire()) then return false end
		if CurTime() > self.NextSparkT then
			self.NextSparkT = CurTime() +0.05
			local effectdataspk = EffectData()
			effectdataspk:SetOrigin(dmginfo:GetDamagePosition())
			effectdataspk:SetAngles(self:GetAngles())
			effectdataspk:SetScale(40)
			util.Effect("StunstickImpact",effectdataspk)
		end
	-- end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/