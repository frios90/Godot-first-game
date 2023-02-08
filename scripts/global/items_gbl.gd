 extends Node

var list_items = [
	{
		"key"         : 0,
		"code"        : 1001,
		"name"        : "Posión de vida S",
		"on"          : "hp",
		"percentage"  : 40,
		"duration"    : false,
		"icon"        : "res://assets/Items/PotaHpS.png",
		"description" : "Recupera el 40% de los puntos de vida",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 1,
		"code"       : 1002,
		"name"       : "Posión de vida M",
		"on"         : "hp",
		"percentage" : 60,
		"duration"   : false,
		"icon"       : "res://assets/Items/PotaHpM.png",
		"description" : "Recupera el 60% de los puntos de vida",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 2,
		"code"       : 1003,
		"name"       : "Posión de vida L",
		"on"         : "hp",
		"percentage" : 90,
		"duration"   : false,
		"icon"       : "res://assets/Items/PotaHpL.png",
		"description" : "Recupera el 90% de los puntos de vida",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 3,
		"code"       : 1004,
		"name"       : "Posión de magia S",
		"on"         : "mp",
		"percentage" : 50,
		"duration"   : false,
		"icon"       : "res://assets/Items/PotaMpS.png",
		"description" : "Recupera el 50% de los puntos de magia",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 4,
		"code"       : 1005,
		"name"       : "Posión de mágia M",
		"on"         : "mp",
		"percentage" : 75,
		"duration"   : false,
		"icon"       : "res://assets/Items/PotaMpM.png",
		"description" : "Recupera el 75% de los puntos de magia",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 5,
		"code"       : 1006,
		"name"       : "Posión de mágia L",
		"on"         : "mp",
		"percentage" : 100,
		"duration"   : false,
		"icon"       : "res://assets/Items/PotaMpL.png",
		"description" : "Recupera el 100% de los puntos de magia",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 6,
		"code"       : 1007,
		"name"       : "Tónico de aguante S",
		"on"         : "stamine",
		"percentage" : 0.2, 
		"duration"   : 10,
		"icon"       : "res://assets/Items/TonicoStamineS.png",
		"description" : "Aumenta la velocidad de RECUPERACIÓN DE AGUANTE en un 50% por 10 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 7,
		"code"       : 1008,
		"name"       : "Tónico de aguante M",
		"on"         : "stamine",
		"percentage" : 0.4, 
		"duration"   : 12,
		"icon"       : "res://assets/Items/TonicStamineM.png",
		"description" : "Aumenta la velocidad de RECUPERACIÓN DE AGUANTE en un 100% por 12 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 8,
		"code"       : 1009,
		"name"       : "Tónico de aguante L",
		"on"         : "stamine",
		"percentage" : 0.6,
		"duration"   : 14,
		"icon"       : "res://assets/Items/TonicStamineL.png",
		"description" : "Aumenta la velocidad de RECUPERACIÓN DE AGUANTE en un 150% por 14 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 9,
		"code"       : 1010,
		"name"       : "Tónico de fuerza S",
		"on"         : "strength",
		"percentage" : 30,
		"duration"   : 15,
		"icon"       : "res://assets/Items/TonicStrengthS.png",
		"description" : "Aumenta la FUERZA en un 30% por 15 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 10,
		"code"       : 1011,
		"name"       : "Tónico de fuerza M",
		"on"         : "strength",
		"percentage" : 60,
		"duration"   : 15,
		"icon"       : "res://assets/Items/TonicStrengthM.png",
		"description" : "Aumenta la FUERZA en un 60% por 15 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 11,
		"code"       : 1012,
		"name"       : "Tónico de fuerza L",
		"on"         : "strength",
		"percentage" : 90, 
		"duration"   : 15,
		"icon"       : "res://assets/Items/TonicStrengthL.png",
		"description" : "Aumenta la FUERZA en un 90% por 15 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 12,
		"code"       : 1013,
		"name"       : "Tónico de agilidad",
		"on"         : "speed",
		"percentage" : 20,
		"duration"   : 15,
		"icon"       : "res://assets/Items/TonicAgility.png",
		"description" : "Aumenta la AGILIDAD en un 20% por 15 segundos",
		"can_use"     : true,
		"can_select"  : true,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 15,
		"code"       : 1016,
		"name"       : "Cristal de vida",
		"on"         : "hp",
		"percentage" : 1.2,
		"duration"   : false, 
		"icon"       : "res://assets/Items/hp-stone-icon.png",
		"description" : "Aumenta en 20% los PUNTOS DE VIDA",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 16,
		"code"       : 1017,
		"name"       : "Cristal de mágia",
		"on"         : "mp",
		"percentage" : 1.1,
		"duration"   : false, 
		"icon"       : "res://assets/Items/mp-stone-icon.png",
		"description" : "Aumenta en 10% los PUNTOS DE MAGIA",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 17,
		"code"       : 1018,
		"name"       : "Cristal de aguante",
		"on"         : "stamine",
		"percentage" : 1.3,
		"duration"   : false, 
		"icon"       : "res://assets/Items/stamine-stone-icon.png",
		"description" : "Aumenta en 30% el AGUANTE",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 18,
		"code"       : 1019,
		"name"       : "Cristal de fuerza",
		"on"         : "strength",
		"percentage" : 1.2,
		"duration"   : false, 
		"icon"       : "res://assets/Items/strength-stone-icon.png",
		"description" : "Aumenta en 20% la FUERZA",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 19,
		"code"       : 1020,
		"name"       : "Cristal de inteligencia",
		"on"         : "intelligence",
		"percentage" : 1.1,
		"duration"   : false, 
		"icon"       : "res://assets/Items/intelligence-stone-icon.png",
		"description" : "Aumenta en 10% la INTELIGENCIA",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 20,
		"code"       : 1021,
		"name"       : "Cristal de agilidad",
		"on"         : "speed",
		"percentage" : 1.1,
		"duration"   : false, 
		"icon"       : "res://assets/Items/speed-stone-icon.png",
		"description" : "Aumenta en 10% la AGILIDAD",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 21,
		"code"       : 1022,
		"name"       : "Cristal de suerte",
		"on"         : "luck",
		"percentage" : 1.1,
		"duration"   : false, 
		"icon"       : "res://assets/Items/luck-stone-icon.png" ,
		"description" : "Aumenta en 10% la SUERTE",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 22,
		"code"       : 1023,
		"name"       : "Fragmento rojo",
		"on"         : "rune-flame",
		"percentage" : false,
		"duration"   : false, 
		"icon"       : "res://assets/Items/fragmentRed.png",
		"description" : "Un extraño fragmento de color ROJO. parece ser parte de un objeto extraño.",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 23,
		"code"       : 1024,
		"name"       : "Fragmento marron",
		"on"         : "rune-sand",
		"percentage" : false,
		"duration"   : false, 
		"icon"       : "res://assets/Items/fragmentBrown.png",
		"description" : "Un extraño fragmento de color MARRON. parece ser parte de un objeto extraño.",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 24,
		"code"       : 1025,
		"name"       : "Fragmento azul",
		"on"         : "rune-liquid",
		"percentage" : false,
		"duration"   : false, 
		"icon"       : "res://assets/Items/fragmentBlue.png" ,
		"description" : "Un extraño fragmento de color AZUL. parece ser parte de un objeto extraño.",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 25,
		"code"       : 1026,
		"name"       : "Fragmento blanco",
		"on"         : "rune-wind",
		"percentage" : false,
		"duration"   : false, 
		"icon"       : "res://assets/Items/fragmentWhite.png",
		"description" : "Un extraño fragmento de color BLANCO. parece ser parte de un objeto extraño.",
		"can_use"     : true,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 26,
		"code"       : 1027,
		"name"       : "Runa de la falma lvl.1",
		"on"         : "flame",
		"percentage" : 30,

		"icon"       : "res://assets/Gui/Stats/FlameRune.png",
		"description" : "Runa cargada de poder mágico (lvl01). Al equiparla en tu espada potenciara tus ataques de elemento fuego. si la equipas en tu armadura, potenciarás tu resistencia al fuego.",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : true,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 27,
		"code"       : 1028,
		"name"       : "Runa de la arena lvl.1",
		"on"         : "sand",
		"percentage" : 30,
		"duration"   : false, 
		"icon"       : "res://assets/Gui/Stats/sandRune.png",
		"description" : "Runa cargada de poder mágico (lvl01). Al equiparla en tu espada potenciara tus ataques de elemento tierra. si la equipas en tu armadura, potenciarás tu resistencia a la arena.",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : true,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 28,
		"code"       : 1029,
		"name"       : "Runa de la aire lvl.1",
		"on"         : "wind",
		"percentage" : 30,
		"duration"   : false, 
		"icon"       : "res://assets/Gui/Stats/windrune.png",
		"description" : "Runa cargada de poder mágico (lvl01). Al equiparla en tu espada potenciara tus ataques de elemento aire. si la equipas en tu armadura, potenciarás tu resistencia a la aire.",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : true,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 29,
		"code"       : 1030,
		"name"       : "Runa de la liquida lvl.1",
		"on"         : "liquid",
		"percentage" : 30,
		"duration"   : false, 
		"icon"       : "res://assets/Gui/Stats/waterrune.png",
		"description" : "Runa cargada de poder mágico (lvl01). Al equiparla en tu espada potenciara tus ataques de elemento aire. si la equipas en tu armadura, potenciarás tu resistencia a la aire.",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : true,
		"is_weapon"   : false,
		"is_armory"   : false
	},
	{
		"key"        : 30,
		"code"       : 1031,
		"name"       : "Espada Vieja",
		"attack"     : 5,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword1.PNG",
		"description" : "Vieja espada sin filo. Peor es nada... mejor tenerla",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 31,
		"code"       : 1032,
		"name"       : "Espada de Bronce",
		"attack"     : 38,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword2.PNG",
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 32,
		"code"       : 1033,
		"name"       : "Gran espada",
		"attack"     : 54,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword3.PNG",
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 33,
		"code"       : 1034,
		"name"       : "Gran espada de plata",
		"attack"     : 64,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword4.PNG" ,
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 34,
		"code"       : 1035,
		"name"       : "Espada ",
		"attack"     : 84,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword5.PNG" ,
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 35,
		"code"       : 1036,
		"name"       : "Espada jade",
		"attack"     : 72,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword6.PNG" ,
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 36,
		"code"       : 1037,
		"name"       : "Espada sentimiento",
		"attack"     : 50,
		"on"         : "weapon",
		"icon"       : "res://assets/swords/sword6.PNG" ,
		"description" : "la espada 002",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : true,
		"is_armory"   : false
	},
	{
		"key"        : 37,
		"code"       : 1038,
		"name"       : "Armadura vieja",
		"defense"   : 10,
		"on"         : "armory",
		"icon"       : "res://assets/armor/001.png" ,
		"description" : "La armadura pendiente de descripcion",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : true
	},
	{
		"key"         : 38,
		"code"        : 1039,
		"name"        : "Armadura bronce",
		"defense"     : 40,
		"on"         : "armory",
		"icon"        : "res://assets/armor/002.png",
		"description" : "La armadura pendiente de descripcion",
		"can_use"     : false,
		"can_select"  : false,
		"is_accesory" : false,
		"is_rune"     : false,
		"is_weapon"   : false,
		"is_armory"   : true
	},
]

func _get_item_by_code(code):
	for i in range(len(self.list_items)):
		if self.list_items[i].code == code :
			return self.list_items[i]
	return false