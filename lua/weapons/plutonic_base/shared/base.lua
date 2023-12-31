--      Copyright (c) 2022-2023, Nick S. All rights reserved      --
-- Plutonic is a project built for Landis Games. --

-- [ File Details ]
-- Purpose: Loads the inital basic values, loads first!

SWEP.IsPlutonic = true
SWEP.PrintName = "Plutonic Weapon Base"
SWEP.Category = "Plutonic"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CustomEvents = {}

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.13

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 12

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.EmptySound = Sound("Weapon_Pistol.Empty")
SWEP.IronsightsRocking = 16
SWEP.SwayFactor = 8
SWEP.Sway = 1
SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.5
SWEP.Spread.IronsightsMod = 0.1
SWEP.Spread.CrouchMod = 0.6
SWEP.Spread.AirMod = 1.2
SWEP.Spread.RecoilMod = 0.025
SWEP.Spread.VelocityMod = 0.5
SWEP.IronsightsSpeed = 4
SWEP.IronsightsPos = Vector( -5.9613, -3.3101, 2.706 )
SWEP.IronsightsAng = Angle( 0, 0, 0 )
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.UseIronsightsRecoil = true
SWEP.scopedIn = SWEP.scopedIn or false
SWEP.CanBreachDoors = false
SWEP.SwayScale = 0
SWEP.BobScale = 0

SWEP.Reverb = {}
SWEP.Reverb.Primary = {}
SWEP.Reverb.Primary.IndoorEnabled = false
SWEP.Reverb.Primary.Indoor = Sound("")
SWEP.Reverb.Primary.IndoorRange = 1200
SWEP.Reverb.Primary.OutdoorEnabled = false
SWEP.Reverb.Primary.Outdoor = Sound("")
SWEP.Reverb.Primary.OutdoorRange = 5000

sound.Add({
	name = "Plutonic.Draw",
	sound = {
		"weapons/ins2/uni/uni_weapon_draw_01.wav",
		"weapons/ins2/uni/uni_weapon_draw_02.wav",
		"weapons/ins2/uni/uni_weapon_draw_03.wav"
	},
	level = 60,
	channel = CHAN_AUTO,
	pitch = {95,105}
})

sound.Add({
	name = "Plutonic.Raise",
	sound = {
		"weapons/ins2/uni/uni_lean_in_01.wav",
		"weapons/ins2/uni/uni_lean_in_02.wav",
		"weapons/ins2/uni/uni_lean_in_03.wav",
		"weapons/ins2/uni/uni_lean_in_04.wav"
	},
	level = 60,
	channel = CHAN_AUTO,
	pitch = {95,105}
})

-- impulse
function SWEP:OnLowered()
	self:EmitSound("Plutonic.Raise", nil, nil, nil, nil, SND_NOFLAGS, 1)
end

function SWEP:Dirty()
	if CLIENT then
		self.VMPos = Vector()
		self.VMAng = Angle()
		self.VMIronsights = 0
		self.VMCrouch = 0
		self.VMBlocked = 1
		self.VMRDBEF = 0
		self.VMBobCycle = 0
		self.VMSwayX = 0
		self.VMDeltaX = 0
		self.VMRoll = 0
		self.VMSwayY = 0
		self.VMDeltaX = 0
		self.VMRattle = 0
		self.VMSprint = 0
		self.VMVel = 0
		self.VMIdle = 0
		self.VMRecoil = Vector()
		self.VMRecoilAng = Angle()
	end

end

function SWEP:Initialize()

	if CLIENT then
		self.VMPos = Vector()
		self.VMAng = Angle()
		self.VMIronsights = 0
		self.VMCrouch = 0
		self.VMBlocked = 1
		self.VMRDBEF = 0
		self.VMBobCycle = 0
		self.VMSwayX = 0
		self.VMDeltaX = 0
		self.VMRoll = 0
		self.VMSwayY = 0
		self.VMDeltaX = 0
		self.VMRattle = 0
		self.VMSprint = 0
		self.VMVel = 0
		self.VMIdle = 0
		self.VMRecoil = Vector()
		self.VMRecoilAng = Angle()
	end

	self:SetIronsights(false)

	self:SetReloading(false)
	self:SetReloadTime(0)

	self:SetRecoil(0)
	self:SetNextIdle(0)

	self:SetHoldType(self.HoldType)

	if SERVER and self.CustomMaterial then
		self.Weapon:SetMaterial(self.CustomMaterial)
	end
end

function SWEP:OnReloaded()
	timer.Simple(0, function()
		self:SetHoldType(self.HoldType)
	end)
end



function SWEP:Deploy()

	if CLIENT then
		self.VMPos = Vector()
		self.VMAng = Angle()
		self.VMIronsights = 0
		self.VMCrouch = 0
		self.VMBlocked = 1 -- The oddball, due to the way it works needs to be set to 1
		self.VMRDBEF = 0
		self.VMBobCycle = 0
		self.VMSwayX = 0
		self.VMDeltaX = 0
		self.VMRoll = 0
		self.VMSwayY = 0
		self.VMDeltaX = 0
		self.VMRattle = 0
		self.VMSprint = 0
		self.VMVel = 0
		self.VMIdle = 0
		self.VMRecoil = Vector()
		self.VMRecoilAng = Angle()
	end

	if self.CustomMaterial then
		if CLIENT then
			self.Owner:GetViewModel():SetMaterial(self.CustomMaterial)
			self.CustomMatSetup = true
		end
	end
	self.DrawTime = UnPredictedCurTime()
	self:PlayAnim(ACT_VM_DRAW)
	if self.Owner:IsPlayer() then
		self.Owner:GetViewModel():SetPlaybackRate(1)
	end
	self:EmitSound(Sound("Plutonic.Draw"), nil, nil, nil, nil, SND_NOFLAGS, 1)

	return true
end

function SWEP:ShootBullet(damage, num_bullets, aimcone, override_src, override_dir)

	if self.UseBallistics then
		if CLIENT then return end
		local bulllet = ents.Create("plutonic_ballistic")
		bulllet:SetPos(self.Owner:GetShootPos())
		bulllet:SetAngles(self.Owner:GetAimVector():Angle())
		bulllet:SetOwner(self.Owner)
		
		bulllet:Spawn()
		bulllet:Launch()
		return
	end

	local bullet = {}

	bullet.Num 	= num_bullets
	bullet.Src 	= override_src or self.Owner:GetShootPos() -- Source
	bullet.Dir 	= override_dir or self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	-- Aim Cone

	bullet.TracerName = self.Primary.Tracer or "tracer"

	if self.Primary.Range then
		bullet.Distance = self.Primary.Range
	end

	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.AmmoType = "Pistol"

	Plutonic.Framework.FireBullets(self, bullet)
	self:ShootEffects()
end

function SWEP:GetShootSrc()
    local owner = self:GetOwner()

    if !IsValid(owner) then return self:GetPos() end
    if owner:IsNPC() then return owner:GetShootPos() end

	local ang = owner:EyeAngles()
    local dir = ang
    local offset = Vector(0, 0, 0)
    local src = owner:GetShootPos()

	local att = self.MuzzleFlashAttachment or self.IronsightsMuzzleFlashAttachment or "muzzle"
	att = self:LookupAttachment(att)
	if ( att ) then
		att = self:GetAttachment(att)
		src = att.Pos
	end

    src = src + dir:Right() * offset[1]
    src = src + dir:Forward() * offset[2]
    src = src + dir:Up() * offset[3]

    return src
end


function SWEP:ShootEffects()
	if CLIENT then
		self.CrosshairGapBoost = 16
		self.VMRecoilPos = self.BlowbackPos
		self.VMRecoilAng = self.BlowbackAngle
		self:ProceduralRecoil(1)

		if self.Primary.Shell then
			local vm = self.Owner:GetViewModel()
			local att = vm:GetAttachment(self.Primary.ShellAttachment or 2)
			if ( att ) then
			local fx = EffectData()
				fx:SetEntity(self)
				fx:SetOrigin(att.Pos)
				fx:SetAngles(att.Ang)
				fx:SetScale(self.Primary.ShellScale or 1)
				util.Effect(self.Primary.Shell, fx)
			end
		end
	end

	self.VMRecoilFOV = 1
	if not self:GetIronsights() or not self.UseIronsightsRecoil then
		
		if self.PrimaryFireSequence then
			local vm = self.Owner:GetViewModel()
			vm.ResetSequenceInfo( vm )
			vm.SetSequence( vm, self.PrimaryFireSequence )
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self.PrimaryFireSequence))
		else
			self:PlayAnim(ACT_VM_PRIMARYATTACK)
			self:QueueIdle()
		end
		
	else
		self.CanDecreaseBlowback = CurTime() + 0.1
	end

	local muzzleFlashEffect = self.MuzzleEffect or self.IronsightsMuzzleFlash or "MuzzleEffect"
	local att = self.MuzzleFlashAttachment or self.IronsightsMuzzleFlashAttachment or "muzzle"
	att = self.Owner:GetViewModel():LookupAttachment(att)
	
	if ( CLIENT and att ) then
		local pos, ang = self.Owner:GetViewModel():WorldSpaceCenter(), self.Owner:GetViewModel():GetAngles()
		pos = pos + ang:Forward() * 32 + ang:Right() * 12 - ang:Up() * 2
		if ( hook.Run("ShouldDrawLocalPlayer", self.Owner) ) then
			pos = self:GetShootSrc()
		end

		local ed = EffectData()
		ed:SetStart(pos)
		ed:SetOrigin(pos)
		ed:SetAngles(self.Owner:GetAimVector():Angle())
		ed:SetScale(1)
		ed:SetEntity(self.OverrideWMEntity or self)
		ed:SetAttachment(att)
		util.Effect(muzzleFlashEffect, ed)
	end

	self:PlayAnimWorld(ACT_VM_PRIMARYATTACK)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	if CLIENT then self:PlayAmmoIndicator() end

	if self.CustomShootEffects then
		self.CustomShootEffects(self)
	end
end

function SWEP:IsSprinting()
	return ( self.Owner:GetVelocity():Length2D() > self.Owner:GetRunSpeed() - 50 )
		and self.Owner:IsOnGround()
end

function SWEP:PrimaryAttack()
	local clip = self:Clip1()
	if clip < 1 then
		self:EmitSound(self.EmptySound, nil, nil, nil, CHAN_STATIC)
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return
	end

	if not self:CanShoot() then return end

	if self.Primary.Burst and clip >= 3 then
		self:SetBursting(true)
		self.Burst = 3

		local delay = CurTime() + ((self.Primary.Delay * 3) + (self.Primary.BurstEndDelay or 0.3))
		self:SetNextPrimaryFire(delay)
		self:SetReloadTime(delay)
	elseif clip >= 1 then
		self:TakePrimaryAmmo(1)

		self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self:CalculateSpread())

		self:AddRecoil()
		self:ViewPunch()

		if self.Primary.Sound_World then
			if CLIENT then 
				local owner = self:GetOwner()
				if owner == LocalPlayer() then
					local shouldPlay = impulse and impulse.GetSetting("view_thirdperson", false)

					if shouldPlay == false then
						self:EmitSound(self.Primary.Sound, nil, nil, nil, CHAN_STATIC, SND_NOFLAGS, 0)
					end
				end 
			end
			if SERVER then self:EmitWorldSound(self.Primary.Sound_World) end
		else
			self:EmitSound(self.Primary.Sound, nil, nil, nil, CHAN_WEAPON, nil, 1)
		end
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetReloadTime(CurTime() + self.Primary.Delay)
	end
end

function SWEP:SecondaryAttack() 
end

function SWEP:Holster()
	-- reset everything when we holster
	self:SetIronsights( false )
	self:SetIronsightsRecoil( 0 )

	self:SetReloading( false )
	self:SetReloadTime( 0 )

	self:SetRecoil( 0 )
	self:SetNextIdle( 0 )

	if CLIENT then
		self.ViewModelPos = Vector( 0, 0, 0 )
		self.ViewModelAng = Angle( 0, 0, 0 )
		self.FOV = nil

		if self.TexGunLight then
			self.TexGunLight:Remove()
			self.TexGunLight = nil
		end

		if self.heatedbarrel then
			self.heatedbarrel:Remove()
			self.heatedbarrel = nil
		end
	end

	if self.CustomMaterial then
		if CLIENT then
			if self.Owner == LocalPlayer() then
				self.Owner:GetViewModel():SetMaterial("")
			end
		end
	end

	if self.ExtraHolster then
		self.ExtraHolster(self)
	end
	
	return true
end

function SWEP:OnRemove()
	if self.CustomMaterial then
		if CLIENT then
			if not self.Owner.GetViewModel then -- disconnect errors
				return
			end

			if not self.Owner == LocalPlayer() then
				return
			end

			if not IsValid(self.Owner) then
				return
			end

			if not IsValid(self.Owner:GetViewModel()) then
				return
			end

			self.Owner:GetViewModel():SetMaterial("")
		end
	end
end

function SWEP:QueueIdle()
	if self.Owner:IsNPC() then return end
	self:SetNextIdle( CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.1 )
end



function SWEP:CanShoot()
	return self:CanPrimaryAttack() and not self:GetBursting() and not (self.LoweredPos and self:IsSprinting()) and self:GetReloadTime() < CurTime()
end

function SWEP:ViewPunch()

	if self.Owner:IsNPC() then return end
	if IsFirstTimePredicted() and ( CLIENT or game.SinglePlayer() ) then
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() -
			Angle( self.Primary.Recoil * ( self:GetIronsights() and 0.5 or 1 ), 0, 0 ) )
	end
end

function SWEP:CanIronsight()
	if self.NoIronsights then
		return false
	end
	
	local att = self:GetCurAttachment()
	if att != "" and self.Attachments[att] and self.Attachments[att].Behaviour == "sniper_sight" and hook.Run("ShouldDrawLocalPlayer", self.Owner) then
		return false
	end

	return not self:IsSprinting() and not self:GetReloading() and self.Owner:IsOnGround()
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	
	--print(options)
	-- Disables animation based muzzle event
	return true

end