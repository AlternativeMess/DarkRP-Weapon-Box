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
end

function ENT:Use(activator)
    if activator:IsPlayer() then
        net.Start("GetMenu")
        net.WriteEntity(self)
        net.Send(activator)
    end
end

local function SpawnSArmOne()
    for key, value in pairs(SpawnSArm) do
        local ent = ents.Create("armybox")
        ent:SetPos(SpawnSArm[key])
        ent:Spawn()
        ent:Activate()
        local phys = ent:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
        end
    end
end

hook.Add("InitPostEntity", "SpawnSArmOne", SpawnSArmOne)

net.Receive("GetWeapon", function(player)
    local sid = player:SteamID64()
    local Weapon = net.ReadString()
    ent = net.ReadEntity()
    local value = false

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

    if (ply:GetPos():Distance(ent:GetPos()) < 100) then
        player:Give(Weapon)
        timer.Create(sid .. "WeaponTimerTakeIt", 180, 1, function() end)
    end
end)