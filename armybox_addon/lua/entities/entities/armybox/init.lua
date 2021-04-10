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
    local phys = ENT:GetPhysicsObject()

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

net.Receive("GetWeapon", function(player)
    local sid = player:SteamID64()
    local Weapon = net.ReadString()
    local ent = net.ReadEntity()

    for k, v in pairs(WeaponsArm) do
        if Weapon == v.Weapon then
            value = true
            break
        end
    end

    if not value then return end

    if timer.Exists(sid .. "WeaponTimerTakeIt") then
        player:ChatPrint("Перед взятием оружия нужно подождать " .. string.format("%i", timer.TimeLeft(sid .. "WeaponTimerTakeIt")) .. " секунд!")

        return
    end

    if (player:GetPos():Distance(ent:GetPos()) < 200) then
        player:Give(Weapon)
        timer.Create(sid .. "WeaponTimerTakeIt", 180, 1, function() end)
    else
        DarkRP.notify(player, 0, 4, "Вы не можете себе этого позволить!")
    end
end)