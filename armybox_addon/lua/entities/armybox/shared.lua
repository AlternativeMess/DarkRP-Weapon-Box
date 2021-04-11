ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Коробка с оружием"
ENT.Author = "Alternative"
ENT.Spawnable = true

WeaponsArm = {
    {
        Name = "Револьвер",
        Weapon = "weapon_357",
        model = "models/weapons/w_357.mdl",
        allowed = TEAM_CITIZEN

    },
    {
        Name = "Пистолет",
        Weapon = "weapon_pistol",
        model = "models/weapons/w_pistol.mdl",
        allowed = TEAM_CITIZEN
    },

    {
        Name = "Пистолет",
        Weapon = "weapon_pistol",
        model = "models/weapons/w_pistol.mdl",
        allowed = TEAM_POLICE
    },
    {
        Name = "Снайперская винтовка",
        Weapon = "ls_sniper",
        model = "models/weapons/w_snip_g3sg1.mdl",
        allowed = TEAM_CITIZEN
    }
}
