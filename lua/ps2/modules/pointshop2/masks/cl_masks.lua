local callback
function Pointshop2.RequestServerMasks( onReceived )
	callback = onReceived
	net.Start( "RequestServerMasks" )
	net.SendToServer( )
end

net.Receive( "RequestServerMasks", function( )
	local masks = net.ReadTable( )
	print( "Got ", #masks )
	callback( masks )
end )