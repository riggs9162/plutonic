# plutonic
 
this is my fixed version of plutonic

## new features
* cool muzzleflash effect
* Functionality for custom sequence animations
```lua
hook.Add("LongswordWeaponReload", "Weaon.MP7.Reload", function(ply, weapon, time)
    if ( SERVER and ply:IsOnGround() and weapon:GetClass() == "plutonic_mp7" and ply.ForceSequence ) then
        ply:SetLocalVelocity(Vector(0, 0, 0))
        ply:ForceSequence("reload_smg1", nil, time)
    end
end)

// disables the Player:DoReloadEvent() function to hide the gesture of reloading
SWEP.NoReloadEvent = true
```
