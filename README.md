# plutonic
 
this is my fixed version of plutonic

## new features
* empty sound functionality
* cool muzzleflash effect (somewhat accurate sometimes)

![image](https://github.com/riggs9162/plutonic/assets/49407096/9bbe6686-6288-4b1e-b94b-f668ebd2d9f3)
![image](https://github.com/riggs9162/plutonic/assets/49407096/326a41ce-c35c-4735-b688-736c022a664d)

* Functionality for custom sequence animations
```lua
hook.Add("LongswordWeaponCanReload", "Weapon.MP7.CanReload", function(ply, weapon, time)
    return ply:IsOnGround() // for the animations
end)

hook.Add("LongswordWeaponReload", "Weaon.MP7.Reload", function(ply, weapon, time)
    if ( SERVER and ply:IsOnGround() and weapon:GetClass() == "plutonic_mp7" ) then
        ply:SetLocalVelocity(Vector(0, 0, 0))
        ply:ForceSequence("reload_smg1", nil, time)
    end
end)

// disables the Player:DoReloadEvent() function to hide the gesture of reloading
SWEP.NoReloadEvent = true
```
