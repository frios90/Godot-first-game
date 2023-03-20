extends Node

var forgot    = false
var in_dialog = false

var dlg_001 = {
	"active"     : false,
	"can_repeat" : false,
	"is_done"    : true,
	"description" : "Dialogo con oldman. se conocen"
}

var dlg_002 = {
	"active"     : false,
	"can_repeat" : false,
	"is_done"    : false,
	"description" : "Dialogo con oldman en la entrada de la cueva"
}

var dlg_003 = {
	"active"      : false,
	"can_repeat"  : false,
	"is_done"     : false,
	"description" : "Dialogo con el nigromante solomon previo a la batalla"
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
			"message" : "Gustavo ?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Realmente eres tú ?"
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Tú debes ser el Estíritu del Viento. Como es que saber quien soy ?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Ya veo, no recuerdas nada"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Pues presta atención que te contaré todo..."
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Que ? tu vas a ayudarme ?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Calla y escucha..."
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "...?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Luego de tu muerte, tu legado comenzo de diluirse con el pasar del tiempo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "con cada nueva generacíon tu historia se iba olvidando y con ello las bases que constituyeron " + Env.town_name
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "siguieron pasando los años y los mas jovenes quisieron conocer el mundo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "partian guiados por su curiosidad pero volvian envenados por la codicia y el poder"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "corrompieron el espiritu de los mas debiles e instalaron su gerarquia"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "así fue como, haciendo mal uso de tu nombre, levantaron esta Iglesia"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "este lugar se convirtio en nuestra carcel Gustavo."
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Hubo una persona que tenia mas ser de poder que todas las demas"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Esta persona paso años fuera del " + Env.town_name 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "en sus viajes adquirio conocimientos prohibidos. La misma magia que nosotros compartimos contigo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "pero el quizo más y poco a poco fue quebrantando nuestra escencia"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "La Iglesía fue construida sobre las ruinas del altar que eregimos como simbolo de nuestra amistad"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "en este altar conjuraste buena manera a los espiritus del norte"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "pero desde tu muerte nadie mas fue capaz de hacerlo."
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Eras especial Gustavo. Pero moriste y con ello nuestro pacto con los humanos"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Así fue como presenciamos el deterioro de tu linage hasta llegar a esto"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "El brujo que nos arrebata la escencia hizo un pacto con un espiritu maligno"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Quien le otorgo poderes oscuros a cambio de su cuerpo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "De esta manera " + Env.final_boss_name + " pudo materializarce en este mundo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "y con esto distorcianar el orden natural de las cosas"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "despertando un ejercito de muertos y criaturas magicas que hacen lo que él les pide"
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Ya he acabado con él..."
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "No querido Gustavo, solo acabaste con su cuerpo fisico, osea el cuerpo con el cual pacto"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Eventualmente volverá, como te mencione, son muchos los que se dejaron arrastrar por el poder"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "por lo tanto son muchos los 'contenedores' a su disposición"
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Entonces como acab..."
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "mi cabeza... duele... recuerdo que tú... Elisa"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Sí querido Gustavo, ese es el nombre que me diste, es como me llamabas cuando me enseñabas el amor de los humanos"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "pero eso ya quedo atras, yo ahora estoy destinada a permanecer en este encierro y lo único que puedo hacer"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "es apostar todas mis cartas en tí entregando mi fragmento. "
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Debes reunir los cuatro fragmentos de esta for... "
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Espera un momento... Elisa... si me entregas tu fragmento que pasará contigo ?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Todo espiritu necesita un objeto para poder materializar su escencia en este mundo"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Luego de entender nuestras energias, tú nos ayudaste a materializarnos en cuatro piedras especiales"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Juntando estos cuatro fragmentos podras tener la energía necesaria para pasar al " + Env.name_other_world
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Respondeme ! que pasará contigo al entregarme tu fragmento"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Gustavo, " +Env.final_boss_name+" acabo hace mucho con nuestras fuentes..." 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Sin su fuente, un espiritu deja de existir. No es como la muerte humana, es algo mas intenso y fuera del alcance de tu comporensión" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "la única razón por la que seguimos aquí es porqué nos utiliza como sus guardianes " 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Es en este lugar donde se encuentra el portal hacia su fuente. Debes ir y acabar con el ahí. No hay otra forma" 
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Entonces tú ... ?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Sí, solo soy el remanente de lo que alguna vez fui. Pero el amor que alguna vez senti por ti yace en este contenedor, en mi fragmento" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Es eso lo que me llevo a romper el hechizo que me controlaba." 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Gustavo, no entiendo como es que has podido volver, pero eso no importa" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "aprovecha esta oportunidad y salva tu mundo. Tengo la esperanza de que podrás acabar con " + Env.final_boss_name 
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Debe existir un manera Elisa. Alguna forma de que tú, Hermes, Rollo y Wiskhy puedan salarvarse"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "No la hay querido. no busques en vano, ya estamos canzados. mis hermanos quiza no serán capaces de romper en conjuro" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "así que no dudes que acabar con sus contenedores. Estoy segura de que si algo hay aun de ellos en sus fragmentos" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Estaran felices de haber vuelto a verte." 
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "(llanto) Llegue hasta aquí buscando respuestas y esto es todo? recuperar la memoría para esto?"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Gustavo, aún sigues siendo el mismo testarudo que conocí hace tantos años (rie con ternura)" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "dime... has encontrado las runas que te hicimos?" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "cuando te fuiste el mundo humano a ratos nos parecía aburrido, por eso confeccionamos runas" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "por si algún día aparecia alguien parecido a tí y que pudiera hacer uso de ellas" 
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "quien hubiera dicho que serías tu mismo quien las usaría..." 
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "(llanto)"
		},
		{
			"issuing" : "Wind",
			"title"   : "Espiritu del Aire",
			"message" : "Adios querido, te entrego mi fragmento. se que haras lo correcto con él. Y suerte con los chicos." 
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "(llanto) Elisa... sí. Les daré tus saludos. Desearia volver a verte. Adios gran espiritu del viento"
		},
		{
			"issuing" : "Player",
			"title"   : "Gustavo",
			"message" : "Adios querida Elisa..."
		},
	]  
}
