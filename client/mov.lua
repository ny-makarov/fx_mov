---MARK: VARIABLES
InCrouch = false

---MARK: FUNCTIONS
function Crouch()
    DisableControlAction(0,36,true)
    local ped = PlayerPedId()
    
    local wasInCombat = IsPedUsingActionMode(ped)
    if wasInCombat then
        SetPedUsingActionMode(ped, false, -1, "DEFAULT_ACTION")
    end
    
    if not IsPedInAnyVehicle(ped, false) then
        if InCrouch then
            ResetPedMovementClipset(ped, Config.Crouch.TransitionSpeed)
            ResetPedStrafeClipset(ped)
            InCrouch = false
            
            if wasInCombat and not Config.Crouch.DisableCombatMode then
                SetPedUsingActionMode(ped, true, -1, "DEFAULT_ACTION")
            end
        else
            RequestAnimSet(Config.Crouch.AnimationSet)
            RequestAnimSet(Config.Crouch.StrafingAnimationSet)
            SetPedMovementClipset(ped, Config.Crouch.AnimationSet, Config.Crouch.TransitionSpeed)
            SetPedStrafeClipset(ped, Config.Crouch.StrafingAnimationSet)
            InCrouch = true 
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if InCrouch then    
            local ped = PlayerPedId()
            
            if Config.Crouch.DisableCombatMode and IsPedUsingActionMode(ped) then
                SetPedUsingActionMode(ped, false, -1, "DEFAULT_ACTION")
            end
            
            if Config.Crouch.DisableDamageCancels then
                if HasEntityBeenDamagedByAnyPed(ped) or HasEntityBeenDamagedByAnyVehicle(ped) or HasEntityBeenDamagedByAnyObject(ped) then
                    ClearEntityLastDamageEntity(ped)
                    SetPedMovementClipset(ped, Config.Crouch.AnimationSet, Config.Crouch.TransitionSpeed)
                    SetPedStrafeClipset(ped, Config.Crouch.StrafingAnimationSet)
                end
            end
            
            if not IsEntityPlayingAnim(ped, Config.Crouch.AnimationSet, "idle", 3) then
                SetPedMovementClipset(ped, Config.Crouch.AnimationSet, Config.Crouch.TransitionSpeed)
                SetPedStrafeClipset(ped, Config.Crouch.StrafingAnimationSet)
            end
            
            if Config.Crouch.DisableRagdoll then
                SetPedCanRagdoll(ped, false)
            end
            
            if Config.Crouch.DisableMelee then
                DisableControlAction(0, 140, true) -- Ataque corpo a corpo
                DisableControlAction(0, 141, true) -- Ataque corpo a corpo pesado
                DisableControlAction(0, 142, true) -- Ataque corpo a corpo alternativo
                SetWeaponAnimationOverride(ped, `WEAPON_UNARMED`) -- Previne animações de coronhada
            end
            
            if Config.Crouch.DisableFire then
                DisableControlAction(0, 24, true)  -- Botão esquerdo do mouse
                DisableControlAction(0, 69, true)  -- Input para atirar em veículos
                DisableControlAction(0, 70, true)  -- Input para atirar em veículos
                DisableControlAction(0, 91, true)  -- Input para atirar em veículos
                DisableControlAction(0, 92, true)  -- Input para atirar em veículos
                DisableControlAction(0, 257, true) -- Input para atirar
                DisableControlAction(0, 263, true) -- Input para atirar de melee
                DisableControlAction(0, 264, true) -- Input para atirar
            end
        else
            if Config.Crouch.DisableRagdoll then
                SetPedCanRagdoll(PlayerPedId(), true)
            end
            if Config.Crouch.DisableMelee then
                SetWeaponAnimationOverride(PlayerPedId(), `Default`)
            end
        end
    end
end)


if Config.Sprint.UnlimitedSprint then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) then
                ResetPlayerStamina(PlayerId())
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            local speedToUse = Config.Sprint.NormalSpeed
            
            -- Verifica se há velocidade temporária ativa
            if isTemporarySpeedActive and temporarySpeed > 0.0 then
                speedToUse = temporarySpeed
            elseif IsControlPressed(0, 21) then -- 21 = SHIFT
                speedToUse = Config.Sprint.TurboSpeed
            end
            
            SetRunSprintMultiplierForPlayer(PlayerId(), speedToUse)
            SetPedMoveRateOverride(ped, speedToUse)
        else
            SetRunSprintMultiplierForPlayer(PlayerId(), Config.Sprint.WalkSpeed)
        end
    end
end)

