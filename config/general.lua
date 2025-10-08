Config = {}

Config.Crouch = {
    DisableCombatMode                   = true, ---Disable combat mode before crounch    
    DisableDamageCancels                = true, ---Disable damage cancels before crounch    
    DisableRagdoll                      = true,        ---Disable ragdoll before crounch    
    DisableMelee                        = true,    ---Disable melee before crounch    
    DisableFire                         = false,   --Disable fire before crounch    
    TransitionSpeed                     = 0.5,        
    AnimationSet                        = "move_ped_crouched",          
    StrafingAnimationSet                = "move_ped_crouched_strafing"
}

Config.Sprint = {
    UnlimitedSprint                     = true,
    TurboSpeed                          = 1.15, ---Max 1.45
    NormalSpeed                         = 0.8, ---Min 0.5
    WalkSpeed                           = 1.0, ---Min 0.5
}

Config.Point = {
    EnablePoint                         = true,
    PointKey                            = "B", ---[B Key is better popular in brazil]
}
