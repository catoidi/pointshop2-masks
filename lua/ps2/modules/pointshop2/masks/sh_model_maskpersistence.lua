Pointshop2.MaskPersistence = class( "Pointshop2.MaskPersistence" )
local MaskPersistence = Pointshop2.MaskPersistence 

MaskPersistence.static.DB = "Pointshop2"

MaskPersistence.static.model = {
	tableName = "ps2_maskpersistence",
	fields = {
		itemPersistenceId = "int",
		material = "string"
	},
	belongsTo = {
		ItemPersistence = {
			class = "Pointshop2.ItemPersistence",
			foreignKey = "itemPersistenceId",
			onDelete = "CASCADE"
		}
	}
}

MaskPersistence:include( DatabaseModel )
MaskPersistence:include( Pointshop2.EasyExport )


function MaskPersistence.static.createOrUpdateFromSaveTable( saveTable, doUpdate )
	return Pointshop2.ItemPersistence.createOrUpdateFromSaveTable( saveTable, doUpdate )
	:Then( function( itemPersistence )
		if doUpdate then
			return MaskPersistence.findByItemPersistenceId( itemPersistence.id )
		else
			local mask = MaskPersistence:new( )
			mask.itemPersistenceId = itemPersistence.id
			return mask
		end
	end )
	:Then( function( mask )
		mask.material = saveTable.material
		return mask:save( )
	end )
end