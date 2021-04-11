-- Do not change these values
Translation.ArmyBox = {}
Customization.ArmyBox = {}
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = Translation.ArmyBox.Name
ENT.Author = "Alternative"
ENT.Spawnable = true
ENT.Category = "Alternative Dev"
-- Customization | You can edit it here
Translation.ArmyBox.Buy = "Buy Weapon"
Translation.ArmyBox.Title = "Weapon Box"
Translation.ArmyBox.SecondTitle = "Weapon Showcase"
Translation.ArmyBox.Price = "Price"
Translation.ArmyBox.TimeLeft = "We'll have to wait"
Translation.ArmyBox.Seconds = "Seconds"
Translation.ArmyBox.NoMoney = "No Money"
Translation.ArmyBox.Name = "Weapon Box"
Translation.ArmyBox.GunDealer = "Gun dealer on server"
-- Set it to true if you want the player to not be able to take weapons if there is an arms dealer on the server.
Customization.ArmyBox.GunDealerNeed = false
-- Set you team GunDealer.
Customization.ArmyBox.GunDealerTeam = TEAM_GUN
-- Set to false if you don't need buy timer.
Customization.ArmyBox.NeedTimer = true
-- Timer for last option
Customization.ArmyBox.TimerTime = 180

-- Customizing fonts (Not delele if CLIENT then end).
if CLIENT then
    surface.CreateFont("Weapon Font", {
        font = "Comic Sans MS",
        extended = true,
        size = 20,
        weight = 600,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = true,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })

    surface.CreateFont("Weapon List Font", {
        font = "Comic Sans MS",
        extended = true,
        size = 25,
        weight = 100,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })
end