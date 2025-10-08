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

function GetCurrentSpeed()
    return Config.Sprint.TurboSpeed
end

---MARK: KEYS
RegisterKeyMapping("FX:Crouch","Agachar","keyboard","LCONTROL")
RegisterKeyMapping("FX:Point","Apontar","keyboard",Config.Point.PointKey)
---MARK: EXPORTS
exports("CrouchState",CrouchState)
exports("SetCurrentSpeed",SetCurrentSpeed)
exports("GetCurrentSpeed",GetCurrentSpeed)



