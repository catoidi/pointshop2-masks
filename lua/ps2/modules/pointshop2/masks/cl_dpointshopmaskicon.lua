local PANEL = {}

function PANEL:Init( )
	self.image = vgui.Create( "DImage", self )
	self.image:Dock( TOP )
	self.image:SetSize( 64, 64 )
	self.image:DockMargin( 5, 0, 5, 5 )
end

function PANEL:SetItemClass( itemClass )
	self.BaseClass.SetItemClass( self, itemClass )
	
	self.NormalTexture = Material( itemClass.material )

end

function PANEL:SetItem( item )
	self:SetItemClass( item.class )
end

function PANEL:Think( )
	if not self.NormalTexture then
		return
	end

	self.image:SetMaterial( self.NormalTexture )
end

function PANEL:PerformLayout( )
	self.image:SetTall( self.image:GetWide( ) )
	local border = ( ( self:GetTall( ) - self.Label:GetTall( ) ) - self.image:GetTall( ) ) / 2
	self.image:DockMargin( 5, border, 5, border )
end

derma.DefineControl( "DPointshopMaskIcon", "", PANEL, "DPointshopItemIcon" )