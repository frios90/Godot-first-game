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
			"message" : "Te estaba esperando",
			"event"   : false
		},
		{
			"issuing" : "player",
			"title"   : "Gustavo",
			"message" : "...",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Nigromante lo ha destruido todo",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Eres nuestra última esperanza.",
			"event"   : false
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Ve al pueblo y salva lo que queda de este mundo.",
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
			"message" : "Pierdes tu tiempo intentando derrotarme",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Los Espiritus Elementales ya estan bajo mi control",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Y no hay nada que puedas hacer",
			"event"   : false
		}	
	]
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
			"message" : "Con esto recuperar la paz en el mundo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Suerte con los otros espiritus"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Espiritu de viento ya no podrá hacerte frente"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Nigromante agoto toda su vitalidad"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "y prentendia hacer lo mismo con el resto"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Recupera los 4 Cristirales."
		},		
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Adios Gustavo."
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
			"message" : "Gustavo, debo despedirme",
			"event"   : "false"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Para poder traerte a la vida hice un pacto con la Muerte",
			"event"   : "false"
		},
		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "ofreciendole mi vida y la de mi familia",
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
			"message" : "Por favor, haz que nuestras muertes no sean en vano",
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
			"message" : "Viejo...",
			"event"   : "false"
		},

		{
			"issuing" : "old-man",
			"title"   : "Viejo",
			"message" : "Adios Gustavo...",
			"event"   : "dead"
		},
		{
			"issuing" : "Death",
			"title"   : "Muerte",
			"message" : "De cualquier forma moriras. Nos vemos pronto, ja, ja, ja",
			"event"   : "end-dialig"
		}		
	]  
}
