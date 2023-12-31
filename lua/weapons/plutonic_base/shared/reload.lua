-- Separating for my fucking brains sake.
function SWEP:CanReload()
	if self.Owner:IsNPC() then
		return self:Clip1() < self.Primary.ClipSize
		and not self:GetReloading() and self:GetNextPrimaryFire() < CurTime()
	end

	if self:GetReloading() then
		return
	end

	if hook.Run("LongswordWeaponCanReload", self.Owner, self) == false then
		return
	end

	if (self:GetNextPrimaryFire() > CurTime()) then
		return
	end

	if self:Ammo1() == 0 then
		return false
	end

	-- Chambering
	if self.CannotChamber then
		return self:Clip1() < self.Primary.ClipSize
	else
		if self:Clip1() == 0 then
			return self:Clip1() < self.Primary.ClipSize + 1
		end
		return self:Clip1() < self.Primary.ClipSize + 1	
	end
end

function SWEP:Reload()
	if not self:CanReload() then return end

	if not self.NoReloadEvent then
		self.Owner:DoReloadEvent()
	end

	if not self.DoEmptyReloadAnim or self:Clip1() != 0 then
		self:PlayAnim(ACT_VM_RELOAD)
	else
		self:PlayAnim(ACT_VM_RELOAD_EMPTY)
	end
	self:QueueIdle()

	if self.ReloadSound then 
		self:EmitSound(Sound(self.ReloadSound))
	elseif self.OnReload then
		self.OnReload(self)
	end

	if self.ReloadWorldSound then
		if SERVER then self:EmitWorldSound(self.ReloadWorldSound) end 
	end

	local time = self.Owner:GetViewModel():SequenceDuration()
	self:SetReloading( true )
	self:SetReloadTime( CurTime() + time )

	hook.Run("LongswordWeaponReload", self.Owner, self, time)
end



function SWEP:FinishReload()
	self:SetReloading( false )

    local amount

    -- one in the chamber
	if self.CannotChamber then
		amount = math.min( self:GetMaxClip1() - self:Clip1(), self:Ammo1() )
	else
    	if self:Clip1() == 0 then
        	amount = math.min( self:GetMaxClip1() - self:Clip1(), self:Ammo1() )
    	else
        	amount = math.min( (self:GetMaxClip1() + 1) - self:Clip1(), self:Ammo1() )
    	end
	end

	self:SetClip1( self:Clip1() + amount )
	self.Owner:RemoveAmmo( amount, self:GetPrimaryAmmoType() )
end