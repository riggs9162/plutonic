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

// add support for other frameworks
local function getModelClass(model)
    if ( ix ) then
        return ix.anim.GetModelClass(model)
    elseif ( nut ) then
        return nut.anim.getModelClass(model)
    elseif ( impulse ) then
        return impulse.GetModelClass(model)
    elseif ( Clockwork ) then
        return Clockwork.animation:GetModelClass(model)
    end

    return "citizen_male"
end

hook.Add("LongswordWeaponReload", "Weaon.MP7.Reload", function(ply, weapon, time)
    if ( SERVER and ply:IsOnGround() and weapon:GetClass() == "plutonic_mp7" ) then
        ply:SetLocalVelocity(Vector(0, 0, 0))

        local data = animationTranslator[getModelClass(ply:GetModel())]
        if ( data ) then
            local animation = istable(data) and ( ply:Crouching() and data[2] or data[1] ) or data
            if ( ply.ForceSequence ) then // helix, impulse
                ply:ForceSequence(animation, nil, time)
            elseif ( ply.forceSequence ) then // nutscript
                ply:forceSequence(animation, nil, time)
            elseif ( ply.SetForcedAnimation ) then // clockwork
                ply:SetForcedAnimation(animation, time) // not sure if thats how it works for clockwork
            end
        end
    end
end)

// disables the Player:DoReloadEvent() function to hide the gesture of reloading
SWEP.NoReloadEvent = true
```
