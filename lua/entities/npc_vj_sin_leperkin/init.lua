AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_sin/characters/mutants/major/major.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 150
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
ENT.MeleeAttackDamage = 18
ENT.TimeUntilMeleeAttackDamage = 1
ENT.FootStepTimeRun = 0.38 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.38 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.GeneralSoundPitch1 = 100
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackAnimationStopMovement = false
ENT.AnimTbl_RangeAttack = {"vjges_spit_gesture"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_sin_spit" -- The entity that is spawned when range attacking
ENT.RangeDistance = 700 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Acid_spit" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.6 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = math.random(2,3) -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.7 -- How much time until it can use any attack again? | Counted in Seconds
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_GLIDE} -- Melee Attack Animations
ENT.LeapDistance = 600 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 3 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.6 -- How much time until it can use any attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.4,0.7} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 250 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 300 -- How much upward force should it apply?
ENT.LeapAttackDamage = 30
ENT.LeapAttackDamageDistance = 80 -- How far does the damage go?
ENT.BreathSoundLevel = 82
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"vjges_flinchbig_flinchgest","vjges_flinchbig_flinchgest2","vjges_flinchbig_flinchgest3"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_sin/npc/leperkin/leperkin_step1.wav","vj_sin/npc/leperkin/leperkin_step2.wav","vj_sin/npc/leperkin/leperkin_step3.wav","vj_sin/npc/leperkin/leperkin_step4.wav"}
ENT.SoundTbl_Breath = {"vj_sin/npc/leperkin/stage2_idle.wav"}
ENT.SoundTbl_Alert = {"vj_sin/npc/leperkin/stage2_jump1.wav","vj_sin/npc/leperkin/stage2_jump2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_sin/npc/leperkin/stage2_frenzyattack1.wav","vj_sin/npc/leperkin/stage2_frenzyattack2.wav","vj_sin/npc/leperkin/stage2_frenzyattack3.wav","vj_sin/npc/leperkin/stage2_frenzyattack4.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_sin/npc/leperkin/stage2_spitgest1.wav","vj_sin/npc/leperkin/stage2_spitgest2.wav"}
ENT.SoundTbl_BeforeLeapAttack = {"vj_sin/npc/leperkin/stage2_leap1.wav","vj_sin/npc/leperkin/stage2_leap2.wav"}
ENT.SoundTbl_Pain = {
	"vj_sin/npc/leperkin/stage2_pain1.wav",
	"vj_sin/npc/leperkin/stage2_pain2.wav",
	"vj_sin/npc/leperkin/stage2_pain3.wav",
	"vj_sin/npc/leperkin/stage2_pain4.wav",
	"vj_sin/npc/leperkin/stage2_pain5.wav",
	"vj_sin/npc/leperkin/stage2_pain6.wav",
	"vj_sin/npc/leperkin/stage2_pain7.wav"
}
ENT.SoundTbl_Death = {
	"vj_sin/npc/leperkin/stage2_death1.wav",
	"vj_sin/npc/leperkin/stage2_death2.wav",
	"vj_sin/npc/leperkin/stage2_death3.wav",
	"vj_sin/npc/leperkin/stage2_death4.wav"
}
ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13,13,60), Vector(-13,-13,0))
	self:ManipulateBoneJiggle(41,1)
	self:ManipulateBoneJiggle(43,1)
	self:ManipulateBoneJiggle(45,1)
	self:ManipulateBoneJiggle(34,1)
	self:ManipulateBoneJiggle(32,1)
	self:ManipulateBoneJiggle(30,1)
	self.HasLeadPipe = false
	if (self.WasMutated != nil && self.WasMutated == true) && self:GetModel() == "models/vj_sin/characters/mutants/major/majorconverted.mdl" && math.random(1,3) == 1 then
		self.HasLeadPipe = true
		local leadpipe = ents.Create("prop_physics")
		if math.random(1,2) == 1 then
			leadpipe:SetModel("models/vj_sin/weapons/w_leadpipe/w_leadpipe.mdl")
		else
			leadpipe:SetModel("models/vj_sin/weapons/w_2x4/w_2x4.mdl")
		end
		leadpipe:SetParent(self)
		leadpipe:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		leadpipe:Spawn()
		leadpipe:Activate()
		leadpipe:Fire("SetParentAttachment","hrmmm",0)
		leadpipe:SetSolid(SOLID_NONE)
		leadpipe:AddEffects(EF_BONEMERGE)
		self:DeleteOnRemove(leadpipe)
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("idle_blunt_weapon"))}
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("walk_fast_blunt_weapon"))}
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("walk_fast_blunt_weapon"))}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()-(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) +self:GetUp()*220 +self:GetForward()*200
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if self.HasLeadPipe == true then
		local randattack = math.random(1,2)
		if randattack == 1 then
			self.AnimTbl_MeleeAttack = {"vjseq_Melee_01_blunt_weapon","vjseq_Melee_blunt_weapon"}
			self.TimeUntilMeleeAttackDamage = 0.85
			self.MeleeAttackDamage = 25
		else
			self.AnimTbl_MeleeAttack = {"vjseq_Melee_01_blunt_weapon_lefthand02","vjseq_Melee_blunt_weapon_lefthand01"}
			self.TimeUntilMeleeAttackDamage = 0.7
			self.MeleeAttackDamage = 18
		end
	else
		local randattack = math.random(1,2)
		if randattack == 1 then
			self.AnimTbl_MeleeAttack = {"vjseq_Melee_01_fast","vjseq_Melee_01_medium","vjseq_Melee_fast","vjseq_Melee_medium"}
			self.TimeUntilMeleeAttackDamage = 0.6
			self.MeleeAttackDamage = 14
		else
			self.AnimTbl_MeleeAttack = {"vjseq_Melee","vjseq_Melee_01"}
			self.TimeUntilMeleeAttackDamage = 0.7
			self.MeleeAttackDamage = 18
		end
	end
	self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation) -self.TimeUntilMeleeAttackDamage
	self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation) -self.TimeUntilMeleeAttackDamage
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/