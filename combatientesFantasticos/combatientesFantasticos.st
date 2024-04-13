!classDefinition: #CombateTest category: #Ejercicio01!
TestCase subclass: #CombateTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 20:41:19'!
test_01_DesarrollarUnCombateHiereAlCombatienteFantasticoDeUnBando
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Humano new}.
	bando2 := Bando newWith: {Ogro new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: bando1 estanTodosHeridos .
	Assert isTrue: bando2 estanTodosHeridos .! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 20:42:11'!
test_02_DesarrollarUnCombateHiereATodosLosCombatientesFantasticosDeUnBando
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Ogro new. Mago new}.
	bando2 := Bando newWith: {Humano new. Hostigador new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: bando1 estanTodosHeridos.
	Assert isTrue: bando2 estanTodosHeridos.! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 20:57:50'!
test_03_AlDesarrollarUnCombateConUnBandoVacioGanaElOtroBandoFantasticamente
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Mago new}.
	bando2 := Bando newWith: {}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: combate ganoElBandoUno .
! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 20:59:27'!
test_04_AlDesarrollarUnCombateConCombatientesFantasticosIdenticosEnAmbosBandosGanaElQueAtacaPrimero
	|bando1 bando2 combate |
	
	bando1 := Bando newWith: {Mago new}.
	bando2 := Bando newWith: {Mago new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar. 
	
	Assert isTrue: combate ganoElBandoUno .
! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 20:43:25'!
test_05_SeCorrenLasNRondasFantasticasEsperadas
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Humano new}.
	bando2 := Bando newWith: {Humano new}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: combate rondas = 5.! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 21:03:47'!
test_06_SeDevuelveElNumeroCorrectoDePorcentajeDeVidaSiNoHayCombateFantastico
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Mago new}.
	bando2 := Bando newWith: {}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: bando1 porcentajeDeVidaRestante = 100.0.! !

!CombateTest methodsFor: 'test-combatienteFantastico' stamp: 'MB 4/1/2024 21:03:55'!
test_07_SeDevuelveElNumeroCorrectoDePorcentajeDeVidaRestanteCon2BandosFantasticosNoVacios
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Humano new}.
	bando2 := Bando newWith: {Humano new}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: bando1 porcentajeDeVidaRestante = 20.0.! !


!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 4/1/2024 20:41:30'!
test_01_DesarrollarUnCombateHiereAlCombatienteDeUnBando
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {Combatiente new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: bando1 estanTodosHeridos .
	Assert isTrue: bando2 estanTodosHeridos .! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'fs 3/23/2024 12:49:00'!
test_02_DesarrollarUnCombateHiereATodosLosCombatientesDeUnBando
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Combatiente new. Combatiente new}.
	bando2 := Bando newWith: {Combatiente new. Combatiente new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: bando1 estanTodosHeridos.
	Assert isTrue: bando2 estanTodosHeridos.! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 4/1/2024 20:55:33'!
test_03_AlDesarrollarUnCombateConUnBandoVacioGanaElOtroBando
	|bando1 bando2 combate|
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar.
	
	Assert isTrue: combate ganoElBandoUno .
! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 4/1/2024 21:03:21'!
test_04_AlDesarrollarUnCombateConCombatientesIdenticosEnAmbosBandosGanaElQueAtacaPrimero
	|bando1 bando2 combate |
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {Combatiente new}.
	
	combate := Combate newWith: bando1 and: bando2.
	
	combate desarrollar. 
	
	Assert isTrue: combate ganoElBandoUno .
! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 3/23/2024 14:56:45'!
test_05_SeCorrenLasNRondasEsperadas
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {Combatiente new}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: combate rondas = 5.! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 4/1/2024 21:03:36'!
test_06_SeDevuelveElNumeroCorrectoDePorcentajeDeVidaSiNoHayCombate
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: bando1 porcentajeDeVidaRestante = 100.0.! !

!CombateTest methodsFor: 'test-combatiente' stamp: 'MB 4/1/2024 21:04:02'!
test_07_SeDevuelveElNumeroCorrectoDePorcentajeDeVidaRestanteCon2BandosNoVacios
	|combate bando1 bando2|
	
	bando1 := Bando newWith: {Combatiente new}.
	bando2 := Bando newWith: {Combatiente new}.
	
	combate := Combate newWith: bando1 and: bando2.
	combate desarrollar.
	
	Assert isTrue: bando1 porcentajeDeVidaRestante = 20.0.! !


!classDefinition: #CombatienteFantasticoTest category: #Ejercicio01!
TestCase subclass: #CombatienteFantasticoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatienteFantasticoTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:30:36'!
test01PuedoDefinirleUnaEstrategiaADavid

	| goliat david |
	goliat := Humano new.
	david := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).! !

!CombatienteFantasticoTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:30:28'!
test02EnfocarseEnElMasSanoAtacaAlMenosDañado

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteFantasticoTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:28:04'!
test03EnfocarseEnElMasSanoAtacaAlMenosDañadoNoImportaElOrden

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {isaac. goliat.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteFantasticoTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:27:46'!
test04EnfocarseEnElMasHeridoAtacaAlMasDañado

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasHerido.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (goliat estaDañadoPor: 6).! !


!CombatienteFantasticoTest methodsFor: 'tests-colecciones' stamp: 'MB 4/1/2024 19:32:15'!
test_01_PruebaDeComoOrdenarYQueNoCopieElementosDeUnArray
	|victimas victimasOrdenadas|
	
	victimas := {Humano new. Humano new}.
	victimas first recibirDaño: 4.

	victimasOrdenadas :=  victimas sorted: [:a :b | a vidaRestante > b vidaRestante].
	
	victimasOrdenadas := victimasOrdenadas copyFrom: 1 to: (victimasOrdenadas size min: 2).
	victimasOrdenadas first recibirDaño: 10.

	victimas do: [:combatiente | Assert isFalse: combatiente estaSano. ].! !


!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 19:46:55'!
test_01_humanoAtacaAlMasSanoPorDefault
	|humano enemigoNoSano enemigoSano|
	
	humano := Humano new.
	
	enemigoNoSano := Humano new.
	enemigoNoSano recibirDaño: 10.
	
	enemigoSano := Humano new.
	
	humano asignarEnemigos: {enemigoSano. enemigoNoSano.}.
	humano atacar.
	
	Assert isFalse: enemigoSano estaSano.
	Assert isTrue: (enemigoSano estaDañadoPor: 4).
	
	
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 19:46:05'!
test_02_humanoAtacaAlMenosSanoCambiandoSuEstrategia
	|humano enemigoNoSano enemigoSano|
	
	humano := Humano new.
	humano enfocarseEnElMasHerido.
	
	enemigoNoSano := Humano new.
	enemigoNoSano recibirDaño: 10.
	
	enemigoSano := Humano new.
	
	humano asignarEnemigos: {enemigoSano. enemigoNoSano.}.
	humano atacar.
	
	Assert isTrue: enemigoSano estaSano.
	Assert isFalse: enemigoNoSano estaSano.
	
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 19:50:24'!
test_03_ogroHace8DeDanioAlAtacar
	|ogro enemigo|
	
	ogro := Ogro new.
	enemigo := Ogro new.
	
	ogro asignarEnemigos: {enemigo.}.
	ogro atacar.
	
	Assert isTrue: ogro estaSano.
	Assert isFalse: enemigo estaSano.
	Assert isTrue: (enemigo estaDañadoPor: 8).
	Assert isTrue: enemigo vidaRestante = 32.
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:01:55'!
test_04_hostigadorCambiaDeEstrategiaDespuesDeCadaAtaque
	|hostigador ogro mago|
	
	hostigador := Hostigador new.
	ogro := Ogro new.
	mago := Mago new.
	
	hostigador asignarEnemigos: {ogro. mago.}.
	hostigador atacar.
	
	Assert isFalse: ogro estaSano.
	Assert isTrue: (ogro estaDañadoPor: 4).
	Assert isTrue: mago estaSano.
	
	hostigador atacar.
	
	Assert isFalse: ogro estaSano.
	Assert isFalse: mago estaSano.
	Assert isTrue: (ogro estaDañadoPor: 4).
	Assert isTrue: (mago estaDañadoPor: 4).
	
	
! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:07:44'!
test_05_magoAtacaALos6EnemigosMasSanos
	|mago enemigo1 enemigo2 enemigo3 enemigo4 enemigo5 enemigo6 enemigo7|
	
	mago := Mago new.
	
	enemigo1 := Humano new.
	enemigo2 := Humano new.
	enemigo3 := Humano new.
	enemigo4 := Humano new.
	enemigo5 := Humano new.
	enemigo6 := Humano new.
	enemigo7 := Humano new.
	enemigo7 recibirDaño: 10.

	mago asignarEnemigos: {enemigo1. enemigo2. enemigo3. enemigo4. enemigo5. enemigo6. enemigo7}.
	mago atacar.
	
	Assert isTrue: (enemigo1 estaDañadoPor: 2).
	Assert isTrue: (enemigo2 estaDañadoPor: 2).
	Assert isTrue: (enemigo3 estaDañadoPor: 2).
	Assert isTrue: (enemigo4 estaDañadoPor: 2).
	Assert isTrue: (enemigo5 estaDañadoPor: 2).
	Assert isTrue: (enemigo6 estaDañadoPor: 2).
	Assert isTrue: (enemigo7 estaDañadoPor: 10).
	
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:07:08'!
test_06_magoAtacaATodosSiHayMenosDe6Enemigos
	|mago enemigo1 enemigo2 enemigo3 enemigo4|
	
	mago := Mago new.
	
	enemigo1 := Humano new.
	enemigo2 := Humano new.
	enemigo3 := Humano new.
	enemigo4 := Humano new.
	enemigo4 recibirDaño: 10.

	mago asignarEnemigos: {enemigo1. enemigo2. enemigo3. enemigo4.}.
	mago atacar.

	Assert isTrue: (enemigo1 estaDañadoPor: 2).
	Assert isTrue: (enemigo2 estaDañadoPor: 2).
	Assert isTrue: (enemigo3 estaDañadoPor: 2).
	Assert isTrue: (enemigo4 estaDañadoPor: 12).

	
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:10:34'!
test_07_ogroAtacaAlMasSanoPorDefault
	|ogro enemigoNoSano enemigoSano|
	
	ogro := Ogro new.
	
	enemigoNoSano := Humano new.
	enemigoNoSano recibirDaño: 10.
	
	enemigoSano := Humano new.
	
	ogro asignarEnemigos: {enemigoSano. enemigoNoSano.}.
	ogro atacar.
	
	Assert isFalse: enemigoSano estaSano.
	Assert isTrue: (enemigoSano estaDañadoPor: 8).
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:11:45'!
test_08_ogroAtacaAlMenosSanoCambiandoSuEstrategia
	|ogro enemigoNoSano enemigoSano|
	
	ogro := Ogro new.
	ogro enfocarseEnElMasHerido.
	
	enemigoNoSano := Humano new.
	enemigoNoSano recibirDaño: 10.
	
	enemigoSano := Humano new.

	ogro asignarEnemigos: {enemigoSano. enemigoNoSano.}.
	ogro atacar.
	
	Assert isTrue: enemigoSano estaSano.
	Assert isFalse: enemigoNoSano estaSano.
	! !

!CombatienteFantasticoTest methodsFor: 'test-ataques' stamp: 'MB 4/1/2024 20:17:47'!
test_09! !


!classDefinition: #CombatienteTest category: #Ejercicio01!
TestCase subclass: #CombatienteTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:46'!
test_01_GoliatEmpiezaSano

	| goliat |
	goliat := Combatiente new.
		
	self assert: goliat estaSano.
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:46'!
test_02_GoliatNoEstaSanoSiRecibeDaño

	| goliat |
	goliat := Combatiente new.

	goliat recibirDaño: 2.

	self deny: goliat estaSano.
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_03_CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Combatiente new.

	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_04_CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Combatiente new.
	goliat recibirDaño: 4.
	
	self deny: (goliat estaDañadoPor: 8).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_05_GoliatPuedeRecibirDañoMultiplesVeces

	| goliat |
	goliat := Combatiente new.

	goliat recibirDaño: 4.
	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 8).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_06_DavidPuedeAtacarAAlguien

	| david goliat |
	david := Combatiente new.
	goliat := Combatiente new.
	
	david atacarA: goliat.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_07_DavidPuedeAtacarEnemigosAsignados

	| david goliat |
	david := Combatiente new.
	goliat := Combatiente new.
		
	david asignarEnemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'MB 4/1/2024 19:30:47'!
test_08_DavidNoAtacaAUnEnemigoNoAsignado

	| david goliat |
	david := Combatiente new.
	goliat := Combatiente new.
		
	david atacar.
	
	self assert: goliat estaSano.
! !


!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:31:38'!
test01PuedoDefinirleUnaEstrategiaADavid

	| goliat david |
	goliat := Combatiente new.
	david := Combatiente new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:31:29'!
test02EnfocarseEnElMasSanoAtacaAlMenosDañado

	| david goliat isaac |
	david := Combatiente new.
	goliat := Combatiente new.
	goliat recibirDaño: 2.
	isaac := Combatiente new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:31:18'!
test03EnfocarseEnElMasSanoAtacaAlMenosDañadoNoImportaElOrden

	| david goliat isaac |
	david := Combatiente new.
	goliat := Combatiente new.
	goliat recibirDaño: 2.
	isaac := Combatiente new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {isaac. goliat.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'MB 4/1/2024 19:31:06'!
test04EnfocarseEnElMasHeridoAtacaAlMasDañado

	| david goliat isaac |
	david := Combatiente new.
	goliat := Combatiente new.
	goliat recibirDaño: 2.
	isaac := Combatiente new.
	
	david enfocarseEnElMasHerido.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (goliat estaDañadoPor: 6).! !


!classDefinition: #Bando category: #Ejercicio01!
Object subclass: #Bando
	instanceVariableNames: 'combatientes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Bando methodsFor: 'public' stamp: 'fs 3/23/2024 12:08:56'!
asignarBandoEnemigo: unBandoEnemigo
	combatientes  do:[:combatiente| combatiente asignarEnemigos: unBandoEnemigo combatientes].! !

!Bando methodsFor: 'public' stamp: 'fs 3/23/2024 13:23:59'!
atacar
	combatientes  do: [:combatiente| combatiente estaMuerto ifFalse: [
			combatiente atacar
		].
	].! !

!Bando methodsFor: 'public' stamp: 'fs 3/23/2024 11:39:51'!
combatientes
	^combatientes.! !

!Bando methodsFor: 'public' stamp: 'MB 4/1/2024 21:01:21'!
estaDerrotado
	^ self porcentajeDeVidaRestante = 0.0.! !

!Bando methodsFor: 'public' stamp: 'fs 3/23/2024 12:47:07'!
estanTodosHeridos
	combatientes  do:[:combatiente| 
		(combatiente estaSano) ifTrue: [
			^false.
		] 
	].
	^true.! !

!Bando methodsFor: 'public' stamp: 'MB 4/1/2024 21:02:11'!
porcentajeDeVidaRestante
	|acumuladorDeVidas vidaMaximaTotal|

	combatientes isEmpty ifTrue: [ ^ 0.0 ].
	
	acumuladorDeVidas := 0.
	vidaMaximaTotal := 0.
	combatientes do: [:combatiente |
		acumuladorDeVidas := acumuladorDeVidas + combatiente vidaRestante.
		vidaMaximaTotal := vidaMaximaTotal + combatiente vidaMaxima.
	].

	^ acumuladorDeVidas * 100 / vidaMaximaTotal.! !


!Bando methodsFor: 'initialization' stamp: 'fs 3/23/2024 11:36:11'!
initializeWith: unConjuntoDecombatientes
	combatientes  := unConjuntoDecombatientes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bando class' category: #Ejercicio01!
Bando class
	instanceVariableNames: ''!

!Bando class methodsFor: 'as yet unclassified' stamp: 'fs 3/23/2024 11:35:43'!
newWith: combatientes
	^self new initializeWith: combatientes.! !


!classDefinition: #Combate category: #Ejercicio01!
Object subclass: #Combate
	instanceVariableNames: 'bando1 bando2 ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combate methodsFor: 'initialization' stamp: 'fs 3/23/2024 12:10:23'!
initializeWith: primerBando and: segundoBando
	bando1 := primerBando.
	bando2 := segundoBando.
	bando1 asignarBandoEnemigo: segundoBando .
	bando2 asignarBandoEnemigo: primerBando.
	ronda := 0.! !


!Combate methodsFor: 'public' stamp: 'MB 4/1/2024 21:04:49'!
desarrollar
	[bando1 estaDerrotado not & bando2 estaDerrotado not ] whileTrue: [
		self desarrollarRonda.
	].
	
! !

!Combate methodsFor: 'public' stamp: 'MB 4/1/2024 21:02:39'!
ganoElBandoDos
	bando1 estaDerrotado ifTrue: [ ^ true. ].
	ronda = 0 ifTrue: [ ^ false. ].
	^ bando2 porcentajeDeVidaRestante > 0.! !

!Combate methodsFor: 'public' stamp: 'MB 4/1/2024 21:02:34'!
ganoElBandoUno
	bando2 estaDerrotado ifTrue: [ ^ true. ].
	ronda = 0 ifTrue: [ ^ false. ].
	^ bando1 porcentajeDeVidaRestante > 0.! !

!Combate methodsFor: 'public' stamp: 'MB 3/23/2024 14:59:19'!
rondas
	^ ronda.! !


!Combate methodsFor: 'private' stamp: 'fs 3/23/2024 12:10:42'!
desarrollarRonda
	bando1 atacar.
	bando2 atacar.
	ronda  := ronda + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combate class' category: #Ejercicio01!
Combate class
	instanceVariableNames: ''!

!Combate class methodsFor: 'as yet unclassified' stamp: 'fs 3/23/2024 11:37:25'!
newWith: primerBando and: segundoBando
	^self new initializeWith: primerBando and: segundoBando.! !


!classDefinition: #Combatiente category: #Ejercicio01!
Object subclass: #Combatiente
	instanceVariableNames: 'enemigos estrategia dañoRecibido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
asignarEnemigos: unConjuntoDeCombatientes 
	enemigos := unConjuntoDeCombatientes.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
atacar
	| victimaElegida |
	enemigos isEmpty ifTrue: [^self].
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
atacarA: unCombatiente
	unCombatiente recibirDaño: 4.! !

!Combatiente methodsFor: 'public' stamp: 'MB 4/1/2024 20:34:48'!
dañoRecibido
	^ dañoRecibido! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente dañoRecibido]].
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente dañoRecibido]].
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:07'!
estaDañadoPor: unaCantidadDeDaño
	^dañoRecibido = unaCantidadDeDaño.! !

!Combatiente methodsFor: 'public' stamp: 'MB 3/23/2024 15:14:33'!
estaMuerto
	^ self vidaRestante = 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:36'!
estaSano
	^dañoRecibido = 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:43:20'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	self enfocarseEnElMasSano.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:46'!
recibirDaño: unaCantidadDeDaño
	dañoRecibido := dañoRecibido + unaCantidadDeDaño.! !

!Combatiente methodsFor: 'public' stamp: 'MB 3/23/2024 15:11:24'!
vidaRestante
	^ (20 - dañoRecibido) max: 0.! !


!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
asignarEnemigos: unConjuntoDeCombatientes 
	enemigos := unConjuntoDeCombatientes.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
atacar
	| victimaElegida |
	enemigos isEmpty ifTrue: [^self].
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
atacarA: unCombatiente
	unCombatiente recibirDaño: 4.! !

!Combatiente methodsFor: 'public' stamp: 'MB 4/1/2024 20:34:48'!
dañoRecibido
	^ dañoRecibido! !

!Combatiente methodsFor: '-- all --' stamp: 'SF 3/20/2024 19:25:43'!
elegirVictima
	^estrategia value: enemigos.
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente dañoRecibido]].
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente dañoRecibido]].
! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:07'!
estaDañadoPor: unaCantidadDeDaño
	^dañoRecibido = unaCantidadDeDaño.! !

!Combatiente methodsFor: 'public' stamp: 'MB 3/23/2024 15:14:33'!
estaMuerto
	^ self vidaRestante = 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:36'!
estaSano
	^dañoRecibido = 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:43:20'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	self enfocarseEnElMasSano.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:46'!
recibirDaño: unaCantidadDeDaño
	dañoRecibido := dañoRecibido + unaCantidadDeDaño.! !

!Combatiente methodsFor: 'as yet unclassified' stamp: 'MB 4/1/2024 20:31:51'!
vidaMaxima
	^ 20.! !

!Combatiente methodsFor: 'public' stamp: 'MB 3/23/2024 15:11:24'!
vidaRestante
	^ (20 - dañoRecibido) max: 0.! !


!Combatiente methodsFor: 'as yet unclassified' stamp: 'MB 4/1/2024 20:31:51'!
vidaMaxima
	^ 20.! !


!classDefinition: #CombatienteFantastico category: #Ejercicio01!
Object subclass: #CombatienteFantastico
	instanceVariableNames: 'vida vidaMaxima poderDeDanio enemigos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 20:33:05'!
asignarEnemigos: unConjuntoDeCombatientes 
	enemigos := unConjuntoDeCombatientes.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:26:04'!
atacar
	self subclassResponsibility.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:19:04'!
dañoRecibido
	^ vidaMaxima - vida.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:18:37'!
estaDañadoPor: unaCantidadDeDaño
	^self dañoRecibido = unaCantidadDeDaño.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:14:06'!
estaMuerto
	^ vida = 0.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:14:51'!
estaSano
	^ vida = vidaMaxima.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:14:38'!
recibirDaño: unaCantidadDeDaño
	vida := vida - (vida min: unaCantidadDeDaño)! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 20:32:08'!
vidaMaxima
	^ vidaMaxima.! !

!CombatienteFantastico methodsFor: 'public' stamp: 'MB 4/1/2024 17:17:29'!
vidaRestante
	^ vida.! !


!CombatienteFantastico methodsFor: 'private' stamp: 'MB 4/1/2024 17:15:55'!
atacarA: unCombatiente
	unCombatiente recibirDaño: poderDeDanio.! !


!classDefinition: #Hostigador category: #Ejercicio01!
CombatienteFantastico subclass: #Hostigador
	instanceVariableNames: 'estrategia tipoDeEstrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Hostigador methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:01'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
	self swapEstrategia.
	
! !

!Hostigador methodsFor: 'public' stamp: 'fs 3/26/2024 21:31:50'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 4.
	self enfocarseEnElMasSano.! !


!Hostigador methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:01'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
	self swapEstrategia.
	
! !

!Hostigador methodsFor: '-- all --' stamp: 'fs 3/26/2024 21:26:36'!
elegirVictima
	^estrategia value: enemigos.
! !

!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 20:01:05'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
	tipoDeEstrategia := #enfocarseEnElMasHerido.! !

!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 20:01:01'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
	tipoDeEstrategia := #enfocarseEnElMasSano.
! !

!Hostigador methodsFor: 'public' stamp: 'fs 3/26/2024 21:31:50'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 4.
	self enfocarseEnElMasSano.! !

!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 17:34:35'!
swapEstrategia
	tipoDeEstrategia = #enfocarseEnElMasSano ifTrue: [
		self enfocarseEnElMasHerido.
	] ifFalse: [
		self enfocarseEnElMasSano.
	].! !


!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 20:01:05'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
	tipoDeEstrategia := #enfocarseEnElMasHerido.! !

!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 20:01:01'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
	tipoDeEstrategia := #enfocarseEnElMasSano.
! !

!Hostigador methodsFor: 'private' stamp: 'MB 4/1/2024 17:34:35'!
swapEstrategia
	tipoDeEstrategia = #enfocarseEnElMasSano ifTrue: [
		self enfocarseEnElMasHerido.
	] ifFalse: [
		self enfocarseEnElMasSano.
	].! !


!classDefinition: #Humano category: #Ejercicio01!
CombatienteFantastico subclass: #Humano
	instanceVariableNames: 'estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:28'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:56'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
! !

!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:52'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
! !

!Humano methodsFor: 'public' stamp: 'fs 3/26/2024 21:19:07'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 4.
	self enfocarseEnElMasSano.! !


!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:28'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Humano methodsFor: '-- all --' stamp: 'fs 3/26/2024 21:11:44'!
elegirVictima
	^estrategia value: enemigos.
! !

!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:56'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
! !

!Humano methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:52'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
! !

!Humano methodsFor: 'public' stamp: 'fs 3/26/2024 21:19:07'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 4.
	self enfocarseEnElMasSano.! !


!classDefinition: #Mago category: #Ejercicio01!
CombatienteFantastico subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:41'!
atacar
	| victimas |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimas := self elegirVictimas.
	self atacarEnemigos: victimas.
! !

!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 17:42:34'!
atacarEnemigos: conjuntoDeEnemigos
	conjuntoDeEnemigos do: [ :enemigo | self atacarA: enemigo ].! !

!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 17:41:43'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 2.! !


!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:41'!
atacar
	| victimas |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimas := self elegirVictimas.
	self atacarEnemigos: victimas.
! !

!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 17:42:34'!
atacarEnemigos: conjuntoDeEnemigos
	conjuntoDeEnemigos do: [ :enemigo | self atacarA: enemigo ].! !

!Mago methodsFor: '-- all --' stamp: 'MB 4/1/2024 18:43:42'!
elegirVictimas
	|victimas|
	victimas := enemigos sorted: [:enemigo1 :enemigo2 | enemigo1 vidaRestante > enemigo2 vidaRestante ].
	victimas := victimas copyFrom: 1 to: (victimas size min: 6).
	^ victimas.! !

!Mago methodsFor: 'public' stamp: 'MB 4/1/2024 17:41:43'!
initialize
	enemigos := #().
	vidaMaxima := 20.
	vida := vidaMaxima.
	poderDeDanio := 2.! !


!classDefinition: #Ogro category: #Ejercicio01!
CombatienteFantastico subclass: #Ogro
	instanceVariableNames: 'estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:48'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:46'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
! !

!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:43'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
! !

!Ogro methodsFor: 'public' stamp: 'fs 3/26/2024 21:23:24'!
initialize
	enemigos := #().
	vidaMaxima := 40.
	vida := vidaMaxima.
	poderDeDanio := 8.
	self enfocarseEnElMasSano.! !


!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:19:48'!
atacar
	| victimaElegida |
	(self estaMuerto | enemigos isEmpty) ifTrue: [ ^ self].

	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Ogro methodsFor: '-- all --' stamp: 'fs 3/26/2024 21:23:01'!
elegirVictima
	^estrategia value: enemigos.
! !

!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:46'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente vidaRestante]].
! !

!Ogro methodsFor: 'public' stamp: 'MB 4/1/2024 20:00:43'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente vidaRestante]].
! !

!Ogro methodsFor: 'public' stamp: 'fs 3/26/2024 21:23:24'!
initialize
	enemigos := #().
	vidaMaxima := 40.
	vida := vidaMaxima.
	poderDeDanio := 8.
	self enfocarseEnElMasSano.! !
