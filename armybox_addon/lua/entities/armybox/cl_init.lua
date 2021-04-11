include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("GetMenu", function()
    local armyBox = net.ReadEntity()
    local MainMenu = vgui.Create("DFrame")
    MainMenu:SetPos(ScrW() * .01, ScrH() * .25)
    MainMenu:SetSize(ScrW() / 2, ScrH() / 2)
    MainMenu:SetTitle(Translation.ArmyBox.Title)
    MainMenu:SetVisible(true)
    MainMenu:SetDraggable(false)
    MainMenu:ShowCloseButton(true)
    MainMenu:MakePopup()

    MainMenu.OnClose = function()
        if IsValid(SecondMenu) then
            SecondMenu:Close()
        end
    end

    function MainMenu:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
    end

    local ScrollPanel = vgui.Create("DScrollPanel", MainMenu)
    ScrollPanel:SetSize(ScrW() / 2 - 20, MainMenu:GetWide() * 0.58)
    ScrollPanel:SetPos(10, 30)

    for key, value in pairs(CustomShipments) do
        local WeaponList = vgui.Create("DButton", ScrollPanel)
        WeaponList:SetSize(ScrollPanel:GetTall(), ScrollPanel:GetWide() * 0.04)
        if value.pricesep then
            WeaponList:SetText(CustomShipments[key].name .. " | " .. Translation.ArmyBox.Price .. ": " .. value.pricesep)
        else
            WeaponList:SetText(CustomShipments[key].name)
            WeaponList:SetColor(Color(255, 0, 0))
            WeaponList:SetEnabled(false)
        end
        WeaponList:Dock(TOP)
        WeaponList:DockMargin(0, 0, 0, 5)
        WeaponList:SetFont("Weapon List Font")
        WeaponList.DoClick = function() return SecondMenuVoid(value.model, value.entity, CustomShipments[key].name, armyBox) end
    end
end)

function SecondMenuVoid(model, entity, Name, armyBox)
    if IsValid(SecondMenu) then
        SecondMenu:Close()
    end

    SecondMenu = vgui.Create("DFrame")
    SecondMenu:SetPos(ScrW() * .52, ScrH() * .25)
    SecondMenu:SetSize(ScrW() / 4, ScrH() / 4 - 7)
    SecondMenu:SetTitle(Translation.ArmyBox.SecondTitle)
    SecondMenu:SetVisible(true)
    SecondMenu:SetDraggable(false)
    SecondMenu:ShowCloseButton(false)
    SecondMenu:MakePopup()

    function SecondMenu:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
    end

    local Icon = vgui.Create("DModelPanel", SecondMenu)
    Icon:SetCamPos(Vector(50, 5, 20))
    Icon:SetLookAt(Vector(0, 0, 5))
    Icon:SetFOV(40)
    Icon:SetSize(100, 200)
    Icon:SetPos(5, 5)
    Icon:SetModel(model)
    Icon:Dock(TOP)
    Icon:Center()
    local BuyWeapon = vgui.Create("DButton", SecondMenu)
    BuyWeapon:Dock(FILL)
    BuyWeapon:SetText(Translation.ArmyBox.Buy .. ": " .. Name)
    BuyWeapon:Dock(TOP)
    BuyWeapon:DockMargin(0, 0, 0, 5)
    BuyWeapon:SetFont("Weapon Font")

    BuyWeapon.DoClick = function()
        net.Start("GetWeapon")
        net.WriteString(entity)
        net.WriteEntity(armyBox)
        net.SendToServer()
    end
end