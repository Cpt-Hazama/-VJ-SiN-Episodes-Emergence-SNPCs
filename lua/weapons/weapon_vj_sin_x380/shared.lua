if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "X380 Prototype Scattergun"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ SiN"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 3 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_EnableDontUseRegulate 	= true -- Used for VJ Base SNPCs, if enabled the SNPC will remove use regulate
SWEP.NPC_NextPrimaryFire 		= 0.9 -- Next time it can use primary fire
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/vj_sin/weapons/v_scattergun/v_scattergun.mdl"
SWEP.WorldModel					= "models/vj_sin/weapons/w_scattergun/w_scattergun.mdl"
SWEP.HoldType 					= "shotgun"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.AdminSpawnable				= false
SWEP.Reload_TimeUntilAmmoIsSet	= 1.8 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 2.2 -- How much time until the player can play idle animation, shoot, etc.
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 6 -- Damage
SWEP.Primary.PlayerDamage		= "Double" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.NumberOfShots		= 7 -- How many shots per attack?
SWEP.Primary.ClipSize			= 6 -- Max amount of bullets per clip
SWEP.Primary.Cone				= 12 -- How accurate is the bullet? (Players)
SWEP.Primary.Delay				= 0.8 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Ammo				= "Buckshot" -- Ammo type
SWEP.Primary.Sound				= {"vj_sin/weapons/shotgun/shotgun_fire6.wav","vj_sin/weapons/shotgun/shotgun_fire7.wav"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"vj_sin/weapons/shotgun/shotgun_fire_npc.wav"}
SWEP.Primary.DistantSoundVolume	= 0.55 -- Distant sound volume
SWEP.NPC_ReloadSound			= {"vj_sin/weapons/shotgun/shotgun_full_reload.wav"}
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound				= {"vj_sin/weapons/shotgun/shotgun_full_reload.wav"}
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.8 -- How much time until it plays the idle animation after attacking(Primary)
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
	timer.Simple(0.3,function()
	if IsValid(self) then
	if self.Owner:IsValid() && self.Owner:IsPlayer() then
		self.Weapon:EmitSound(Sound("vj_sin/weapons/shotgun/shotgun_cock.wav"),80,100)
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		end
	end
 end)
end