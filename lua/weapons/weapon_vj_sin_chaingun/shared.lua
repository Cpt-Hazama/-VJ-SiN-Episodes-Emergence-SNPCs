if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Chaingun"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ SinTek"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_smg1.mdl"
SWEP.WorldModel					= "models/vj_sin/weapons/w_sintek_gun/w_sintek_gun.mdl"
SWEP.HoldType 					= "shotgun"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.NPC_CustomSpread	 		= 0.5
SWEP.MadeForNPCsOnly 			= true
SWEP.NPC_EnableDontUseRegulate 	= true -- Used for VJ Base SNPCs, if enabled the SNPC will remove use regulate
SWEP.NPC_NextPrimaryFire 		= 0.3 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0.01 -- How much time until the bullet/projectile is fired?
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound				= {"vj_sin/weapons/assault/assault_reload1.wav"}
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 7 -- Damage
SWEP.Primary.ClipSize			= 9999 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.09 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"vj_sin/weapons/chaingun/chaingun_fire2.wav","vj_sin/weapons/chaingun/chaingun_fire3.wav","vj_sin/weapons/chaingun/chaingun_fire4.wav"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"vj_sin/weapons/chaingun/chaingun_fire1.wav"}
SWEP.NPC_ReloadSound			= {"vj_sin/weapons/pistol/pistol_reload1.wav"}
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.1 -- How much time until it plays the idle animation after attacking(Primary)
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPCShoot_PrimaryExtra(ShootPos,ShootDir)
	if (!self:IsValid()) or (!self.Owner:IsValid()) then return end
	if (!self.Owner:GetEnemy()) then return end
	if self.Owner.IsVJBaseSNPC == true then
		self.Owner.Weapon_TimeSinceLastShot = 0
		self.Owner.NextWeaponAttackAimPoseParametersReset = CurTime() + 1
		self.Owner:WeaponAimPoseParameters()
	end
	self:PrimaryAttack()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPC_ServerNextFire()
	if (CLIENT) then return end
	if !self:IsValid() && !IsValid(self.Owner) && !self.Owner:IsValid() && !self.Owner:IsNPC() then return end
	if self:IsValid() && IsValid(self.Owner) && self.Owner:IsValid() && self.Owner:IsNPC() && self.Owner:GetActivity() == nil then return end

	self:RunWorldModelThink()
	self:CustomOnThink()
	self:CustomOnNPC_ServerThink()

	if self.Owner.IsReloadingWeapon_ServerNextFire == false && self.AlreadyPlayedNPCReloadSound == false && (VJ_IsCurrentAnimation(self.Owner,self.CurrentAnim_WeaponReload) or VJ_IsCurrentAnimation(self.Owner,self.CurrentAnim_ReloadBehindCover) or VJ_IsCurrentAnimation(self.Owner,self.NPC_ReloadAnimationTbl) or VJ_IsCurrentAnimation(self.Owner,self.NPC_ReloadAnimationTbl_Custom)) then
		self.Owner.NextThrowGrenadeT = self.Owner.NextThrowGrenadeT + 2
		self.Owner.IsReloadingWeapon_ServerNextFire = true
		self:CustomOnNPC_Reload()
		self.AlreadyPlayedNPCReloadSound = true
		if self.NPC_HasReloadSound == true then VJ_EmitSound(self.Owner,self.NPC_ReloadSound,self.NPC_ReloadSoundLevel) end
		timer.Simple(3,function() if IsValid(self) then self.AlreadyPlayedNPCReloadSound = false end end)
	end

	local function FireCode()
		timer.Simple(0.1, function() if IsValid(self) then self:NPCShoot_PrimaryExtra(ShootPos,ShootDir) end end)
		timer.Simple(0.2, function() if IsValid(self) then self:NPCShoot_PrimaryExtra(ShootPos,ShootDir) end end)
		self:NPCShoot_Primary(ShootPos,ShootDir)
		hook.Remove("Think", self)
		timer.Simple(0.15, function() hook.Add("Think",self,self.NPC_ServerNextFire) end)
	end
	if self:NPCAbleToShoot() == true then FireCode() end
end