extends Node

var forgot    = false
var in_dialog = false

var dlg_001 = {
	"active"     : false,
	"can_repeat" : false,
	"is_done"    : false,
	"description" : "Dialogo con oldman. se conocen",
	"msgs"        : [
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "( ... )",
		"event"   : false
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Has revivido",
		"event"   : false
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Te hemos estado esperando hace bastante",
		"event"   : false
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Ya era hora.",
		"event"   : false
	},
	{
		"issuing" : "player",
		"title"   : "Gustavo",
		"message" : "que es lo que pasa?",
		"event"   : false
	},
	
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Este no es un buen lugar para explicar.",
		"event"   : false
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Ve al pueblo",
		"event"   : false
	},

	]
}

var dlg_002 = {
	"active"     : false,
	"can_repeat" : false,
	"is_done"    : false,
	"description" : "Dialogo con oldman en la entrada de la cueva",
	"msgs" : [
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "...",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Hola, ya estas avanzando",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Necesito llegar a la iglesia pero algo esta haciendo guardia en el puente",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Ten esto y ayudame",
			"event"   : false
		},
		{
			"issuing" : "system",
			"title"   : "Sistema",
			"message" : "Has recibido una runa",
			"event"   : false
		},
		{
			"issuing" : "system",
			"title"   : "Sistema",
			"message" : "Suerte",
			"event"   : false
		}	
	]	
}

var dlg_003 = {
	"active"      : false,
	"can_repeat"  : false,
	"is_done"     : false,
	"description" : "Dialogo con nigromante",
	"msgs" : [
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "...",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Veo que la muerte te ha traido de vuelta...",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Aunque no podras vencerme",
			"event"   : false
		}	
	]
}

var dlg_004 = {
	"active"      : false,
	"can_repeat"  : false,
	"is_done"     : false,
	"description" : "Dialogo con el nigromante solomon al morir"
}

var dlg_005 = {
	"active"      : false,
	"can_repeat"  : false,
	"is_done"     : false,
	"description" : "Encuentro con el espiritu del viento",
	"msgs"        : [
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "..."
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Atras a quedado nuestra amistad Gustavo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Pero es el recuerdo de esta lo que me ha liberado de esta maldición"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "No obstante he de morir para poder ayudarte"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Y hacerlo me complace"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Con esto te ayudo a recuperar la paz en el mundo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Suerto con los otros espiritus"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Recupera los 4 Cristirales."
		},
		
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Adios Gustavo. Ya es hora de que descanse"
		},
	]  
}

var dlg_006 = {
	"active"      : false,
	"can_repeat"  : false,
	"is_done"     : false,
	"description" : "Encuentro con final con el viejo",
	"msgs"        : [
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "...",
			"event"   : "false"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Gustavo, por fin llegaste",
			"event"   : "false"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Para poder traerte a la vida, tuve que sacrificar la mía",
			"event"   : "false"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Pacte con la muerte para poder hacerlo",
			"event"   : "false"
		},
		{
			"issuing" : "Death",
			"title"   : "Muerte",
			"message" : "Aprovecha tu oportunidad...",
			"event"   : "init"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Adios Gustavo, salvanos!",
			"event"   : "false"
		},	
		{
			"issuing" : "Death",
			"title"   : "Muerte",
			"message" : "Muere viejo!",
			"event"   : "attack"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Adios Viejo, tu sacrificio no será en vano",
			"event"   : "false"
		},

		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "...",
			"event"   : "dead"
		},
		{
			"issuing" : "Death",
			"title"   : "Muerte",
			"message" : "Hasta tu muerte...",
			"event"   : "end-dialig"
		}		
	]  
}
