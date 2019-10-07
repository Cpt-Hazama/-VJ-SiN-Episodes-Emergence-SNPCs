	-- World Settings --
TRACER_FLAG_USEATTACHMENT	= 0x0002;
SOUND_FROM_WORLD			= 0;
CHAN_STATIC					= 6;

	-- Main Settings --
EFFECT.Speed				= 15000;
-- EFFECT.Length				= 100;
-- EFFECT.WhizSound			= Sound("cpt_base/cpt_fx/nearmiss.wav"); // Makes a sound by default so this isn't neccessary
EFFECT.WhizDistance			= 72;

	-- Texture Settings --
-- local cpt_MainTexture		= Material("sprites/beam_laser"); // mat_texture_list 1
-- local cpt_MainTextureSize 	= 20;
-- local cpt_MainTextureColor 	= Color(255,34,0);
-- local cpt_FrontTextureColor = Color(255,34,0);

function EFFECT:GetTracerOrigin( data )

	local start = data:GetStart();

	if(bit.band(data:GetFlags(),TRACER_FLAG_USEATTACHMENT) == TRACER_FLAG_USEATTACHMENT) then
		local entity = data:GetEntity();
		if(not IsValid(entity)) then return start; end
		if(not game.SinglePlayer() && entity:IsEFlagSet(EFL_DORMANT)) then return start; end
		if(entity:IsWeapon() && entity:IsCarriedByLocalPlayer()) then
			local ply = entity:GetOwner();
			if(IsValid(ply)) then
				local vm = ply:GetViewModel();
				if(IsValid(vm) && not LocalPlayer():ShouldDrawLocalPlayer()) then
					entity = vm;
				else
					if(entity.WorldModel) then
						entity:SetModel(entity.WorldModel);
					end
				end
			end
		end

		local attachment = entity:GetAttachment(data:GetAttachment());
		if(attachment) then
			start = attachment.Pos;
		end

	end

	return start;

end


function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin(data);
	self.EndPos = data:GetOrigin();
	self.Length = (self.StartPos - self.EndPos):Length()
	self.alreadyshot = false

	self.Entity:SetRenderBoundsWS(self.StartPos,self.EndPos);

	local diff = (self.EndPos -self.StartPos);

	self.Normal = diff:GetNormal();
	self.StartTime = 0;
	self.LifeTime = 1;
	local weapon = data:GetEntity();
	self.LaserTexture = Material("sprites/magnum_pulse")
	self.TextureSize = 10
	if(IsValid(weapon) && (not weapon:IsWeapon() or not weapon:IsCarriedByLocalPlayer())) then
		local dist, pos, time = util.DistanceToLine(self.StartPos,self.EndPos,EyePos());
	end

end


function EFFECT:Think()

	self.LifeTime = self.LifeTime -FrameTime();
	self.StartTime = self.StartTime +FrameTime(); 

	return self.LifeTime > 0;

end

function EFFECT:Render()

	local endDistance = self.Speed *self.StartTime;
	local startDistance = endDistance -self.Length;
	
	startDistance = math.max(0,startDistance);
	endDistance = math.max(0,endDistance);

	local startPos = self.StartPos +self.Normal *startDistance;
	local endPos = self.StartPos +self.Normal *endDistance;
	render.SetMaterial(self.LaserTexture)
	if self.alreadyshot == false then
		sound.Play("weapons/mortar/mortar_fire1.wav",endPos,80,100 *GetConVarNumber("host_timescale"))
		util.ScreenShake(endPos,10,100,0.6,120)
		self.alreadyshot = true
	end
	render.DrawBeam(startPos,endPos,self.TextureSize,math.Rand(0,20) /3,(math.Rand(0,20) /3) +self.Length /256);

end