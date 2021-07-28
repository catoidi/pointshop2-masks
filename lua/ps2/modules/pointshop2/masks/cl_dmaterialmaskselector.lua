local PANEL = {}

function PANEL:Init( )
	self:SetSkin( Pointshop2.Config.DermaSkin )
	self:SetSize( 25 + 64*8+63*4, 400 )
	
	self:SetTitle( "Select a Material" )
	
	local scroll = vgui.Create( "DScrollPanel", self )
	scroll:Dock( FILL )
	
	self.layout = vgui.Create( "DIconLayout", scroll )
	self.layout:SetSpaceX( 5 )
	self.layout:SetSpaceY( 5 )
	self.layout:DockMargin( 0, 2, 0, 5 )
	self.layout:SetWide( 25 + 64*8+63*4 )
	
	Pointshop2.RequestServerMasks( function( files )
		self:SetMasks( files )
	end )
end

function PANEL:SetMasks( files )
	local materials = {}
	for k, v in pairs( files ) do
		v = string.Replace( v, ".vmt", "" )
		v = string.Replace( v, ".vtf", "" )
		v = "ps2_masks/" .. v
		if not table.HasValue( materials, v ) then
			table.insert( materials, v )
		end
	end
	
	for k, v in pairs( materials ) do
		local btn = self.layout:Add( "DImageButton" )
		btn:SetSize( 64, 64 )
		btn:SetImage( v )
		btn.NormalMat = Material( v )

		function btn:Think( )
			self.m_Image:SetMaterial( self.NormalMat )
		end
		
		function btn.DoClick( )
			self.selectedMaterial = btn.NormalMat
			self.matName = v
			self:OnChange( )
			self:Close( )
		end
	end
	self.layout:InvalidateLayout( true )
end

function PANEL:OnChange( )
	--for overwriting 20089331
end

vgui.Register( "DMaterialMaskSelector", PANEL, "DFrame" )