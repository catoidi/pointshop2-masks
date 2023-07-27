ITEM.PrintName = "Pointshop Mask Base"
ITEM.baseClass = "base_pointshop_item"

ITEM.material = ""

ITEM.category = "Masks"
ITEM.color = ""

function ITEM:initialize( )
end

if CLIENT then
	matfix = {}
end
function ITEM:AttachMask( ply )
	if SERVER then
		return 
	end
		
	local supEngLight, setMat, drawQuad = render.SuppressEngineLighting, render.SetMaterial, render.DrawQuadEasy
	
	if not matfix[self.material] then
		local omat = Material( self.material )
		local nmat = CreateMaterial( "fix" .. omat:GetName( ), "UnlitGeneric", {
			["$basetexture"] = omat:GetTexture( "$basetexture" ),
			["$vertexcolor"] = 1,
			["$vertexalpha"] = 1,
			["$nolod"] = 1,
		} )
		matfix[self.material] = nmat
		nmat:SetTexture( "$basetexture", omat:GetTexture( "$basetexture" ) )
	end
	
	hook.Add("PostPlayerDraw", "DrawMaskFor_"..ply:UniqueID(), function(ply2)
		if ply2 != ply then return end -- WHOOPS! I FORGOT THIS!
		
		local boneindex = ply2:LookupBone("ValveBiped.Bip01_Head1")
		if not boneindex then return end 
		
		local pos, ang = ply2:GetBonePosition( boneindex ) 
		pos = pos + ang:Up()
		
		local distSqr = LocalPlayer():GetPos():DistToSqr( ply2:GetPos( ) )
		if distSqr > 1850000 then 
			return
		end

		ang:RotateAroundAxis(ang:Forward(), 80)
		ang:RotateAroundAxis(ang:Up(), -90)
		
		supEngLight( true )
			setMat( matfix[self.material] )
			local pos = pos + Vector(0, 0, 20)
			ang:RotateAroundAxis(ang:Forward(), 90)
			local alpha = 255 
			if distSqr > 1500000 then
				local dNorm = distSqr - 1500000
				local perc =  distSqr / 1850000
				alpha = ( 1 - perc ) * 255
			end
			drawQuad( pos, ply2:GetAimVector(), 10, 10, Color( 255, 255, 255, alpha ), 180 )
		supEngLight( false )

	end)
		
end
	
function ITEM:RemoveMask( ply )
	if SERVER then
		return 
	end
	
	hook.Remove("PostPlayerDraw", "DrawMaskFor_"..ply:UniqueID())
end

function ITEM:OnEquip( )
	local ply = self:GetOwner()
	if ply:Alive( ) and not (ply.IsSpec and ply:IsSpec()) then
		self:PlayerSpawn( ply )
	end
end

function ITEM:PlayerSpawn( ply )
	if ply == self:GetOwner( ) then
		self:AttachMask( ply )
	end
end
Pointshop2.AddItemHook( "PlayerSpawn", ITEM )

function ITEM:PlayerDeath( victim, inflictor, attacker )
	if victim == self:GetOwner( ) then
		self:RemoveMask( victim )
	end
end
Pointshop2.AddItemHook( "PlayerDeath", ITEM )

function ITEM:OnHolster( ply )
	self:RemoveMask( ply )
end

function ITEM.static:GetPointshopIconControl( )
	return "DPointshopMaskIcon"
end

function ITEM.static.getPersistence( )
	return Pointshop2.MaskPersistence
end

function ITEM.static.generateFromPersistence( itemTable, persistenceItem )
	ITEM.super.generateFromPersistence( itemTable, persistenceItem.ItemPersistence )
	itemTable.material = persistenceItem.material
end

function ITEM.static.GetPointshopIconDimensions( )
	return Pointshop2.GenerateIconSize( 2, 4 )
end

/*
	Inventory icon
*/
function ITEM:getIcon( )
	self.icon = vgui.Create( "DPointshopMaskInvIcon" )
	self.icon:SetItem( self )
	self.icon:SetSize( 64, 64 )
	return self.icon
end