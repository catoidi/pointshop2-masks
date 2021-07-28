Pointshop2.AddEquipmentSlot( "Mask", function( item )
	--Check if the item is a mask
	return instanceOf( Pointshop2.GetItemClassByName( "base_mask" ), item )
end )
