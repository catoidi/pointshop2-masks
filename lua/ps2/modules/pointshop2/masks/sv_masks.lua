util.AddNetworkString( "RequestServerMasks" )
LibK.addContentFolder("materials/ps2_masks")

net.Receive( "RequestServerMasks", function( len, ply )
	if not PermissionInterface.query( ply, "pointshop2 createitems" ) then
		KLogf( 3, "Player %s wanted to request server masks but is not allowed to create items!", ply:Nick( ) )
		return
	end
	
	local files, folders = file.Find( "materials/ps2_masks/*", "GAME" )
	net.Start( "RequestServerMasks" )
		net.WriteTable( files )
	net.Send( ply )
end )