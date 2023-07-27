local MODULE = {}

--Pointshop2 Masks Store
MODULE.Name = "Pointshop 2 Masks"
MODULE.Author = "Phoenixf129"

--This defines blueprints that players can use to create items.
--base is the name of the class that is used as a base
--creator is the name of the derma control that is used to create new items from the blueprint
MODULE.Blueprints = {
	{
		label = "PNG Hats",
		base = "base_mask",
		icon = "pointshop2/fedora.png",
		creator = "DMaskCreator"
	}
}

MODULE.SettingButtons = {}

MODULE.Settings = {}
MODULE.Settings.Server = {}

Pointshop2.RegisterModule( MODULE )