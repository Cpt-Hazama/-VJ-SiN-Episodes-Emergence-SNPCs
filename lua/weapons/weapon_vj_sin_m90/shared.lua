if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "M90 Magnum"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ SiN"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 1 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 1 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 4 -- Default is 1, The scale of the viewmodel sway
SWEP.UseHands					= true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_EnableDontUseRegulate 	= false -- Used for VJ Base SNPCs, if enabled the SNPC will remove use regulate
SWEP.NPC_NextPrimaryFire 		= 0.3 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.5 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/vj_sin/weapons/v_magnum/v_magnum.mdl"
SWEP.WorldModel					= "models/vj_sin/weapons/w_npc_pistol/w_npc_pistol.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.Reload_TimeUntilAmmoIsSet	= 0.6 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 1.2 -- How much time until the player can play idle animation, shoot, etc.
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 12 -- Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 18 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 2 -- How much recoil does the player get?
SWEP.Primary.Cone				= 1 -- How accurate is the bullet? (Players)
SWEP.Primary.Delay				= 0.13 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Ammo				= "357" -- Ammo type
SWEP.Primary.Sound				= {"vj_sin/weapons/pistol/pistol_fire1.wav","vj_sin/weapons/pistol/pistol_fire1.wav"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"vj_sin/weapons/pistol/pistol_npc_fire.wav"}
SWEP.Primary.DistantSoundVolume	= 0.7 -- Distant sound volume
SWEP.NPC_ReloadSound			= {"vj_sin/weapons/pistol/pistol_reload1.wav"}
SWEP.HasReloadSound = true
SWEP.ReloadSound				= {"vj_sin/weapons/pistol/pistol_reload1.wav"}
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.6 -- Time until it can shoot again after deploying the weapon
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.5 -- How much time until it plays the idle animation after attacking(Primary)
SWEP.WorldModel_UseCustomPosition = false
SWEP.WorldModel_CustomPositionAngle = Vector(-8,1,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1.5,7.5,1)
SWEP.LaserTexture = "sprites/magnum_pulse"
SWEP.TextureSize = 15
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	if self.Owner:IsNPC() then
		self.WorldModel	= "models/vj_sin/weapons/w_npc_pistol/w_npc_pistol.mdl"
		self.WorldModel_UseCustomPosition = false
		if math.random(1,50) == 1 && CurTime() > self:GetNextSecondaryFire() && self.Owner:GetEnemy() != nil && (self.Owner:GetForward():Dot((self.Owner:GetEnemy():GetPos() -self.Owner:GetPos()):GetNormalized()) > math.cos(math.rad(self.Owner.SightAngle))) && self.Owner:GetPos():Distance(self.Owner:GetEnemy():GetPos()) <= self.Owner.Weapon_FiringDistanceFar && self.Owner:Visible(self.Owner:GetEnemy()) then
			self:SecondaryAttack(ShootPos,ShootDir)
		end
	else
		self.WorldModel	= "models/vj_sin/weapons/w_magnum/w_magnum.mdl"
		self.WorldModel_UseCustomPosition = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack(ShootPos,ShootDir)
	//if self.Owner:KeyDown(IN_RELOAD) then return end
	//self.Owner:SetFOV( 45, 0.3 )
	//if !IsFirstTimePredicted() then return end
	self:SetNextSecondaryFire(CurTime() + 1)
	if self.Reloading == true then return end
	if self.Owner:IsNPC() && self.Owner.VJ_IsBeingControlled == false && self.Owner:GetEnemy() == nil then return end
	if self.Owner:IsPlayer() && self.Primary.AllowFireInWater == false && self.Owner:WaterLevel() == 3 && self.Reloading == false then self.Weapon:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if self:Clip1() <= 0 && self.Reloading == false then self.Weapon:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if (!self:CanPrimaryAttack()) then return end
	self:CustomOnPrimaryAttack_BeforeShoot()
	if (SERVER) then
		if self.Owner:IsNPC() then
			timer.Simple(self.NPC_ExtraFireSoundTime,function()
				if IsValid(self) && IsValid(self.Owner) then
					VJ_EmitSound(self.Owner,self.NPC_ExtraFireSound,self.NPC_ExtraFireSoundLevel,math.Rand(self.NPC_ExtraFireSoundPitch1,self.NPC_ExtraFireSoundPitch2))
				end
			end)
		end
		sound.Play("vj_sin/weapons/pistol/pistol_uraniumshot.wav",self:GetPos(),80,math.random(90,100))
		if self.Primary.HasDistantSound == true then
			sound.Play("vj_sin/weapons/pistol/pistol_npcuraniumshot.wav",self:GetPos(),self.Primary.DistantSoundLevel,math.random(self.Primary.DistantSoundPitch1,self.Primary.DistantSoundPitch2),self.Primary.DistantSoundVolume)
		end
	end
	//self.Weapon:EmitSound(Sound(self.Primary.Sound),80,self.Primary.SoundPitch)
	if self.Primary.DisableBulletCode == false then
		local bullet = {}
			bullet.Num = self.Primary.NumberOfShots
			local spawnpos = self.Owner:GetShootPos()
			if self.Owner:IsNPC() then
				spawnpos = self:GetNWVector("VJ_CurBulletPos")
			end
			//print(spawnpos)
			//VJ_CreateTestObject(spawnpos,self:GetAngles(),Color(0,0,255))
			bullet.Src = spawnpos
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Callback = function(attacker,tr,dmginfo)
				self:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
			end
				/*bullet.Callback = function(attacker, tr, dmginfo)
				local laserhit = EffectData()
				laserhit:SetOrigin(tr.HitPos)
				laserhit:SetNormal(tr.HitNormal)
				laserhit:SetScale(80)
				util.Effect("VJ_Small_Explosion1", laserhit)
				
				bullet.Callback = function(attacker, tr, dmginfo)
				local laserhit = EffectData()
				laserhit:SetOrigin(tr.HitPos)
				laserhit:SetNormal(tr.HitNormal)
				laserhit:SetScale(25)
				util.Effect("AR2Impact", laserhit)
				end*/
				//tr.HitPos:Ignite(8,0)
				//return true end
			if self.Owner:IsPlayer() then
				bullet.Spread = Vector((self.Primary.Cone /60)/4,(self.Primary.Cone /60)/4,0)
			end
			bullet.Tracer = self.Primary.Tracer
			bullet.TracerName = "vj_tracer_sinmagnum"
			bullet.Force = self.Primary.Force *3
			bullet.Damage = self.Primary.Damage *8
			bullet.AmmoType = self.Primary.Ammo
			self.Owner:FireBullets(bullet)
			local vel = self.Owner:GetVelocity()
			local velZ = vel.z
			vel = vel +self.Owner:GetForward() *-750
			vel.z = velZ
			self.Owner:SetLocalVelocity(vel)
	else
		if self.Owner:IsNPC() && self.Owner.IsVJBaseSNPC == true then
			self.Owner.Weapon_ShotsSinceLastReload = self.Owner.Weapon_ShotsSinceLastReload + 1
		end
	end
	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then self.Owner:MuzzleFlash() end
	self:PrimaryAttackEffects()
	if self.Owner:IsPlayer() then
	self:ShootEffects("ToolTracer")
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:ViewPunch(Angle(-12,0,0)) end
	if !self.Owner:IsNPC() then
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	timer.Simple(1,function() if self:IsValid() then self:DoIdleAnimation() end end)
end