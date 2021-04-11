AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("GetMenu")
util.AddNetworkString("GetWeapon")

function ENT:Initialize()
    self:SetModel("models/Items/ammoCrate_Rockets.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.CanUse = true
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator)
    if activator:IsPlayer() then
        net.Start("GetMenu")
        net.WriteEntity(self)
        net.Send(activator)
    end
end

net.Receive("GetWeapon", function(len, ply)
    local sid = ply:SteamID64()
    local entity = net.ReadString()
    local doent = net.ReadEntity()
    local teamserver = false
    local value = false

    if not Customization.ArmyBox.GunDealerNeed then
        for k, v in pairs(player.GetAll()) do
            if v:Team() == Customization.ArmyBox.GunDealerTeam then
                teamserver = true
                DarkRP.notify(ply, 1, 4, Translation.ArmyBox.GunDealer)
                break
            end
        end

        if teamserver then return end
    end

    for k, v in pairs(CustomShipments) do
        if entity == v.entity and v.pricesep then
            price = v.pricesep
            value = true
            break
        end
    end

    if not value then return end

    if Customization.ArmyBox.NeedTimer and timer.Exists(sid .. "WeaponTimerTakeIt") then
        DarkRP.notify(ply, 1, 4, Translation.ArmyBox.TimeLeft .. " " .. string.format("%i", timer.TimeLeft(sid .. "WeaponTimerTakeIt")) .. " " .. Translation.ArmyBox.Seconds)

        return
    end

    if (ply:GetPos():Distance(doent:GetPos()) < 200) then
        if ply:canAfford(price) then
            ply:addMoney(-price)
            ply:Give(entity)

            if Customization.ArmyBox.NeedTimer then
                timer.Create(sid .. "WeaponTimerTakeIt", Customization.ArmyBox.TimerTime, 1, function() end)
            end
        else
            DarkRP.notify(ply, 1, 4, Translation.ArmyBox.NoMoney)
        end
    end
end)