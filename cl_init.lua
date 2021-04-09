include("shared.lua")

surface.CreateFont("Weapon Font", {
    font = "Comic Sans MS",
    extended = true,
    size = 20,
    weight = 500,
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

function ENT:Draw()
    self:DrawModel()
end

function Menu()
    local MainMenu = vgui.Create("DFrame")
    MainMenu:SetPos(ScrW() * .01, ScrH() * .25)
    MainMenu:SetSize(ScrW() / 2, ScrH() / 2)
    MainMenu:SetTitle("Оружейная стойка")
    MainMenu:SetVisible(true)
    MainMenu:SetDraggable(true)
    MainMenu:ShowCloseButton(true)
    MainMenu:MakePopup()

    function MainMenu:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
    end

    for key, value in pairs(WeaponsArm) do
        if LocalPlayer():Team() == value.allowed then
            local WeaponList = vgui.Create("DButton", MainMenu)
            WeaponList:Dock(FILL)
            WeaponList:SetText(value.Name)
            WeaponList:Dock(TOP)
            WeaponList:DockMargin(0, 0, 0, 5)
            WeaponList.DoClick = function() return SecondMenuVoid(value.model, value.Weapon, value.Name) end
        end
    end
end

net.Receive("GetMenu", Menu)

function SecondMenuVoid(model, Weapon, Name)
    local SecondMenu = vgui.Create("DFrame")
    SecondMenu:SetPos(ScrW() * .52, ScrH() * .25)
    SecondMenu:SetSize(ScrW() / 4, ScrH() / 4 - 7)
    SecondMenu:SetTitle("Оружейная стойка")
    SecondMenu:SetVisible(true)
    SecondMenu:SetDraggable(true)
    SecondMenu:ShowCloseButton(true)
    SecondMenu:MakePopup()

    function SecondMenu:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
    end

    local Icon = vgui.Create("SpawnIcon", SecondMenu)
    Icon:SetPos(110, 28)
    Icon:SetSize(200, 200)
    Icon:SetModel(model)
    Icon:Dock(TOP)
    Icon:Center()
    local BuyWeapon = vgui.Create("DButton", SecondMenu)
    BuyWeapon:Dock(FILL)
    BuyWeapon:SetText("Купить: " .. Name)
    BuyWeapon:Dock(TOP)
    BuyWeapon:DockMargin(0, 0, 0, 5)
    BuyWeapon:SetFont("Weapon Font")

    BuyWeapon.DoClick = function()
        net.Start("GetWeapon")
        net.WriteString(Weapon)
        net.SendToServer()
    end
end