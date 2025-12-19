function GetSettings()
    return Config
end
_settings = GetSettings()

function CrouchState()
    return InCrouch
end

function SetCurrentSpeed(speed)
    if not type(speed) == "number" then
        print("Speed must be a number")
        return
    end
    Config.Sprint.TurboSpeed = speed
end


temporarySpeed = 0.0
isTemporarySpeedActive = false
function SetTemporarySpeed(speed, time)
    if type(speed) ~= "number" or type(time) ~= "number" then
        print("Speed and time must be a number")
        return
    end
    temporarySpeed = speed
    isTemporarySpeedActive = true
    Citizen.CreateThread(function()
        Citizen.Wait(time * 1000)
        temporarySpeed = 0.0
        isTemporarySpeedActive = false
    end)
    return temporarySpeed
end

function GetTemporarySpeed()
    return temporarySpeed
end

function IsTemporarySpeedActive()
    return isTemporarySpeedActive
end

function GetCurrentSpeed()
    return Config.Sprint.TurboSpeed
end

---MARK: KEYS
RegisterKeyMapping("FX:Crouch","Agachar","keyboard","LCONTROL")
RegisterKeyMapping("FX:Point","Apontar","keyboard",Config.Point.PointKey)

---MARK: EVENTS
RegisterNetEvent("fx_mov:SetTemporarySpeed")
AddEventHandler("fx_mov:SetTemporarySpeed", function(speed, time)
    SetTemporarySpeed(speed, time)
end)

---MARK: EXPORTS
exports("CrouchState",CrouchState)
exports("SetCurrentSpeed",SetCurrentSpeed)
exports("GetCurrentSpeed",GetCurrentSpeed)
exports("SetTemporarySpeed",SetTemporarySpeed)
exports("GetTemporarySpeed",GetTemporarySpeed)
exports("IsTemporarySpeedActive",IsTemporarySpeedActive)



