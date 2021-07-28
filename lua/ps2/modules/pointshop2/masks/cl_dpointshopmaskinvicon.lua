local PANEL = {}

function PANEL:Init( )
	self.image = vgui.Create( "DImage", self )
	self.image:Dock( FILL )
end

function PANEL:SetItem( item )
	self.item = item 
	self.image:SetMaterial( Material( item.class.material ) )
end

vgui.Register( "DPointshopMaskInvIcon", PANEL, "DPointshopInventoryItemIcon" )