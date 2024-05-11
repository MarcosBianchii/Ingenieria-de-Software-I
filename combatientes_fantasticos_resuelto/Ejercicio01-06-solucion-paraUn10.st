!classDefinition: #CombateTest category: #Ejercicio01!
TestCase subclass: #CombateTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombateTest methodsFor: 'tests' stamp: 'SF 3/25/2024 19:46:42'!
test01AlMenosUnMiembroDeCadaBandoEsDañado

	| bando1 bando2 combate |
	bando1 := {Combatiente humano.}.
	bando2 := {Combatiente humano.}.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	combate desarrollar.
	
	self assert: bando1 first estaSano not.
	self assert: bando2 first estaSano not.
	! !

!CombateTest methodsFor: 'tests' stamp: 'SF 3/25/2024 19:48:53'!
test02TodosLosMiembrosAtacan

	| bando1 bando2 combate |
	bando1 := {Combatiente humano. Combatiente humano.}.
	bando2 := {Combatiente humano. Combatiente humano.}.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	combate desarrollar.
	
	self assert: (bando1 allSatisfy: [:combatiente | combatiente estaSano not]).
	self assert: (bando2 allSatisfy: [:combatiente | combatiente estaSano not]).
	! !

!CombateTest methodsFor: 'tests' stamp: 'SF 3/25/2024 19:48:57'!
test03PuedeGanarElBando1

	| bando1 bando2 combate resultado |
	bando1 := {Combatiente humano.}.
	bando2 := {Combatiente humano.}.
	bando2 first recibirDaño: 16.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	resultado := combate desarrollar.
	
	self assert: 'bando1' equals: (resultado at: 'ganador').
	! !

!CombateTest methodsFor: 'tests' stamp: 'SF 3/25/2024 19:49:01'!
test04PuedeGanarElBando2

	| bando1 bando2 combate resultado |
	bando1 := {Combatiente humano.}.
	bando2 := {Combatiente humano.}.
	bando1 first recibirDaño: 16.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	resultado := combate desarrollar.
	
	self assert: 'bando2' equals: (resultado at: 'ganador').
	! !

!CombateTest methodsFor: 'tests' stamp: 'SF 4/5/2024 17:31:57'!
test05TodosLosMiembrosAtacan

	| bando1 bando2 combate resultado |
	bando1 := {Combatiente humano. Combatiente humano.}.
	bando2 := {Combatiente humano. Combatiente humano.}.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	resultado := combate desarrollar.
	
	self assert: 'bando1' equals: (resultado at: 'ganador').
	! !

!CombateTest methodsFor: 'tests' stamp: 'SF 4/5/2024 17:32:07'!
test06TodosLosMiembrosAtacan

	| bando1 bando2 combate resultado |
	bando1 := {Combatiente humano. Combatiente humano.}.
	bando2 := {Combatiente humano. Combatiente humano. Combatiente humano.}.
	combate := Combate enfrentarBando1: bando1 vsBando2: bando2.
	
	resultado := combate desarrollar.
	
	self assert: 'bando2' equals: (resultado at: 'ganador').
	! !


!classDefinition: #CombatienteTest category: #Ejercicio01!
TestCase subclass: #CombatienteTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/5/2024 17:35:30'!
test01GoliatEmpiezaSano

	| goliat |
	goliat := Combatiente humano.
		
	self assert: goliat estaSano.
	self assert: (goliat estaDañadoPor: 0).
	self assert: goliat puntosDeVida equals: 20.
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/5/2024 17:39:33'!
test02GoliatNoEstaSanoSiRecibeDaño

	| goliat |
	goliat := Combatiente humano.

	goliat recibirDaño: 2.

	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 2).
	self assert: goliat puntosDeVida equals: 18.
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/1/2024 19:13:33'!
test03CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Combatiente humano.

	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/1/2024 19:13:40'!
test04CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Combatiente humano.
	goliat recibirDaño: 4.
	
	self deny: (goliat estaDañadoPor: 8).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/1/2024 19:13:47'!
test05GoliatPuedeRecibirDañoMultiplesVeces

	| goliat |
	goliat := Combatiente humano.

	goliat recibirDaño: 4.
	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 8).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/1/2024 19:13:54'!
test06DavidPuedeAtacarAAlguien

	| david goliat |
	david := Combatiente humano.
	goliat := Combatiente humano.
	
	david atacarA: goliat.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/4/2024 12:24:27'!
test07DavidPuedeAtacarEnemigosAsignados

	| david goliat |
	david := Combatiente humano.
	goliat := Combatiente humano.
		
	david enemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/1/2024 19:14:04'!
test08DavidNoAtacaAUnEnemigoNoAsignado

	| david goliat |
	david := Combatiente humano.
	goliat := Combatiente humano.
		
	david atacar.
	
	self assert: goliat estaSano.
! !

!CombatienteTest methodsFor: 'tests-combatir' stamp: 'SF 4/4/2024 12:24:27'!
test09DavidNoAtacaAUnEnemigoSiEstaFueraDeCombate

	| david goliat |
	david := Combatiente humano.
	goliat := Combatiente humano.
	david enemigos: {goliat}.
	david recibirDaño: 20.
		
	david atacar.
	
	self assert: goliat estaSano.
! !


!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'SF 4/4/2024 12:24:27'!
test01PuedoDefinirleUnaEstrategiaADavid

	| goliat david |
	goliat := Combatiente humano.
	david := Combatiente humano.
	
	david enfocarseEnElMasSano.
	david enemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'SF 4/4/2024 12:24:27'!
test02EnfocarseEnElMasSanoAtacaAlMenosDañado

	| david goliat isaac |
	david := Combatiente humano.
	goliat := Combatiente humano.
	goliat recibirDaño: 2.
	isaac := Combatiente humano.
	
	david enfocarseEnElMasSano.
	david enemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'SF 4/4/2024 12:24:27'!
test03EnfocarseEnElMasSanoAtacaAlMenosDañadoNoImportaElOrden

	| david goliat isaac |
	david := Combatiente humano.
	goliat := Combatiente humano.
	goliat recibirDaño: 2.
	isaac := Combatiente humano.
	
	david enfocarseEnElMasSano.
	david enemigos: {isaac. goliat.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'SF 4/4/2024 12:24:27'!
test04EnfocarseEnElMasHeridoAtacaAlMasDañado

	| david goliat isaac |
	david := Combatiente humano.
	goliat := Combatiente humano.
	goliat recibirDaño: 2.
	isaac := Combatiente humano.
	
	david enfocarseEnElMasHerido.
	david enemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (goliat estaDañadoPor: 6).! !

!CombatienteTest methodsFor: 'tests-estrategia' stamp: 'SF 4/4/2024 12:24:27'!
test05PorDefectoUnCombatienteAtacaAlMasSano

	| goliat david |
	goliat := Combatiente humano.
	david := Combatiente humano.
	
	david enemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).! !


!classDefinition: #HostigadorTest category: #Ejercicio01!
TestCase subclass: #HostigadorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!HostigadorTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:24:27'!
test01UnHostigadorAtacaPrimeroAlMasSano
	| hostigador victimas |
	hostigador := Combatiente hostigador.
	victimas := {Combatiente humano. Combatiente humano.}.
	victimas second recibirDaño: 2.
	hostigador enemigos: victimas.
	
	hostigador atacar.
	
	self assert: (victimas first estaDañadoPor: 4).
	! !

!HostigadorTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:24:27'!
test02UnHostigadorAtacaSegundoAlMasHerido
	| hostigador victimas |
	hostigador := Combatiente hostigador.
	victimas := {Combatiente humano. Combatiente humano.}.
	victimas second recibirDaño: 2.
	hostigador enemigos: victimas.
	hostigador atacar.

	hostigador atacar.
	
	self assert: (victimas first estaDañadoPor: 8).
	! !

!HostigadorTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:33:27'!
test03UnHostigadorVaAlternandoSusDosEstrategiasEnCadaAtaque
	| hostigador victimas |
	hostigador := Combatiente hostigador.
	victimas := {Combatiente humano. Combatiente humano.}.
	victimas second recibirDaño: 2.
	hostigador enemigos: victimas.
	hostigador atacar.
	hostigador atacar.

	hostigador atacar.
	
	self assert: (victimas second estaDañadoPor: 6).
	! !


!classDefinition: #MagoTest category: #Ejercicio01!
TestCase subclass: #MagoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!MagoTest methodsFor: 'as yet unclassified' stamp: 'SF 4/4/2024 12:24:27'!
test01LosAtaquesDelMagoHace2DeDaño
	| enemigo mago |
	mago := Combatiente mago.
	enemigo := Combatiente humano.
	mago enemigos: {enemigo}.
	
	mago atacar.
	
	self assert: (enemigo estaDañadoPor: 2).
	
	! !

!MagoTest methodsFor: 'as yet unclassified' stamp: 'SF 4/4/2024 12:24:27'!
test02LosAtaquesDelMagoDañanAMasDeUnEnemigo
	| mago enemigos |
	mago := Combatiente mago.
	enemigos := {Combatiente humano. Combatiente humano}.
	mago enemigos: enemigos.
	
	mago atacar.
	
	self assert: (enemigos allSatisfy: [:each | each estaDañadoPor: 2]).
	
	! !

!MagoTest methodsFor: 'as yet unclassified' stamp: 'SF 4/4/2024 12:24:27'!
test03LosAtaquesDelMagoDañanANoMasSeisEnemigos
	| mago enemigos |
	mago := Combatiente mago.
	enemigos := {Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano}.
	mago enemigos: enemigos.
	
	mago atacar.
	
	self assert: (enemigos count: [:each | each estaDañadoPor: 2]) equals: 6.
	self assert: (enemigos anySatisfy: [:each | each estaSano])
	
	! !

!MagoTest methodsFor: 'as yet unclassified' stamp: 'SF 4/4/2024 12:24:27'!
test04LosAtaquesDelMagoDañanALosMasSanos
	| mago enemigos |
	mago := Combatiente mago.
	enemigos := {Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano. Combatiente humano}.
	mago enemigos: enemigos.
	
	mago atacar.
	mago atacar.
	
	self assert: (enemigos count: [:each | each estaDañadoPor: 2]) equals: 12.
	
	! !


!classDefinition: #OgroTest category: #Ejercicio01!
TestCase subclass: #OgroTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!OgroTest methodsFor: 'tests' stamp: 'SF 3/25/2024 17:52:03'!
test01UnOgroRecienCreadoEstaSano
	| ogro |
	ogro := Combatiente ogro.
	
	self assert: ogro estaSano.
! !

!OgroTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:24:27'!
test02UnOgroAguantaAlMenos39PuntosDeDaño
	| ogro otroOgro |
	ogro := Combatiente ogro.
	otroOgro := Combatiente ogro.
	ogro enemigos: {otroOgro}.
	
	ogro recibirDaño: 39.
	ogro atacar.
	
	self assert: otroOgro estaSano not.
	
! !

!OgroTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:24:27'!
test03UnOgroQuedaFueraDeCombateAlRecibir40PuntosDeDaño
	| ogro otroOgro |
	ogro := Combatiente ogro.
	otroOgro := Combatiente ogro.
	ogro enemigos: {otroOgro}.

	ogro recibirDaño: 40.
	
	ogro atacar.
	self assert: otroOgro estaSano.
! !

!OgroTest methodsFor: 'tests' stamp: 'SF 4/4/2024 12:24:27'!
test04UnOgroHace8PuntosDeDañoCuandoAtaca
	| ogro otroOgro |
	ogro := Combatiente ogro.
	otroOgro := Combatiente ogro.
	ogro enemigos: {otroOgro}.
	
	ogro atacar.
	
	self assert: (otroOgro estaDañadoPor: 8).
! !


!classDefinition: #Combate category: #Ejercicio01!
Object subclass: #Combate
	instanceVariableNames: 'bando1 bando2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combate methodsFor: 'initialization' stamp: 'SF 3/25/2024 16:12:51'!
initializeBando1: unosCombatientes bando2: otrosCombatientes
	bando1 := unosCombatientes.
	bando2 := otrosCombatientes.! !


!Combate methodsFor: 'private' stamp: 'SF 3/25/2024 17:35:30'!
desarollarUnaRonda

	bando1 do: [:combatiente | combatiente atacar].
	bando2 do: [:combatiente | combatiente atacar]! !

!Combate methodsFor: 'private' stamp: 'SF 3/25/2024 17:34:47'!
estaFueraDeCombateBando1

	^ bando1 allSatisfy: [:each | each estaFueraDeCombate]! !

!Combate methodsFor: 'private' stamp: 'SF 3/25/2024 17:35:03'!
estaFueraDeCombateBando2

	^ bando2 allSatisfy: [:each | each estaFueraDeCombate]! !

!Combate methodsFor: 'private' stamp: 'SF 3/25/2024 21:23:57'!
hayAlgunBandoFueraDeCombate

	^ self estaFueraDeCombateBando1 or: [self estaFueraDeCombateBando2 ]! !


!Combate methodsFor: 'public' stamp: 'SF 4/4/2024 12:24:27'!
desarrollar
	
	| ganador rondasDesarrolladas |
	rondasDesarrolladas := 0.
	bando1 do: [:combatiente | combatiente enemigos: bando2].
	bando2 do: [:combatiente | combatiente enemigos: bando1].
	
	[self hayAlgunBandoFueraDeCombate] whileFalse: [
		self desarollarUnaRonda.
		rondasDesarrolladas := rondasDesarrolladas + 1].

	self estaFueraDeCombateBando1 ifTrue: [ganador := 'bando2'].
	self estaFueraDeCombateBando2 ifTrue: [ganador := 'bando1'].
	^Dictionary
		with: 'ganador' -> ganador
		with: 'duracionEnRondas' -> rondasDesarrolladas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combate class' category: #Ejercicio01!
Combate class
	instanceVariableNames: ''!

!Combate class methodsFor: 'public' stamp: 'SF 3/25/2024 16:10:29'!
enfrentarBando1: bando1 vsBando2: bando2
	^self new initializeBando1: bando1 bando2: bando2.! !


!classDefinition: #Combatiente category: #Ejercicio01!
Object subclass: #Combatiente
	instanceVariableNames: 'enemigos dañoRecibido puntosDeVidaMaximo dañoPorAtaque'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combatiente methodsFor: 'public' stamp: 'SF 4/5/2024 12:10:54'!
atacar
	self siPuedeAtacarHace: [
		self elegirYAtacar.
	].! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/25/2024 18:09:43'!
atacarA: unCombatiente
	unCombatiente recibirDaño: dañoPorAtaque.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:29:48'!
dañoRecibido
	^dañoRecibido! !

!Combatiente methodsFor: 'public' stamp: 'SF 4/4/2024 12:24:27'!
enemigos: unConjuntoDeCombatientes 
	enemigos := unConjuntoDeCombatientes.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:07'!
estaDañadoPor: unaCantidadDeDaño
	^dañoRecibido = unaCantidadDeDaño.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/25/2024 17:59:13'!
estaFueraDeCombate
	^ dañoRecibido >= puntosDeVidaMaximo! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:36'!
estaSano
	^dañoRecibido = 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 4/5/2024 17:40:10'!
puntosDeVida
	^puntosDeVidaMaximo - dañoRecibido.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:46'!
recibirDaño: unaCantidadDeDaño
	dañoRecibido := dañoRecibido + unaCantidadDeDaño.! !


!Combatiente methodsFor: 'private' stamp: 'SF 4/5/2024 12:07:56'!
elegirYAtacar

	self subclassResponsibility! !

!Combatiente methodsFor: 'private' stamp: 'SF 4/5/2024 18:38:31'!
estrategiaEnfocarseEnElMasHerido
	^[:candidatos | candidatos detectMin: [:combatiente | combatiente puntosDeVida]] ! !

!Combatiente methodsFor: 'private' stamp: 'SF 4/5/2024 18:38:44'!
estrategiaEnfocarseEnElMasSano
	^[:candidatos | candidatos detectMax: [:combatiente | combatiente puntosDeVida]] ! !

!Combatiente methodsFor: 'private' stamp: 'SF 4/4/2024 12:23:41'!
siPuedeAtacarHace: hacerMiAtaque

	enemigos isEmpty ifTrue: [^self].
	self estaFueraDeCombate ifTrue: [^self].
	hacerMiAtaque value.! !


!Combatiente methodsFor: 'initialization' stamp: 'SF 3/25/2024 19:50:04'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	dañoPorAtaque := 4.
	puntosDeVidaMaximo := 20.
! !

!Combatiente methodsFor: 'initialization' stamp: 'SF 3/25/2024 18:09:23'!
initializeWithPuntosDeVidaMaximo: maximosPuntosDeVida dañoPorAtaque: unaCantidadDeDaño 
	puntosDeVidaMaximo := maximosPuntosDeVida.
	dañoPorAtaque := unaCantidadDeDaño.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combatiente class' category: #Ejercicio01!
Combatiente class
	instanceVariableNames: ''!

!Combatiente class methodsFor: 'instance creation' stamp: 'SF 3/25/2024 20:52:50'!
hostigador
	^Hostigador new! !

!Combatiente class methodsFor: 'instance creation' stamp: 'SF 4/4/2024 12:21:48'!
humano
	^CombatienteConEstrategia new.! !

!Combatiente class methodsFor: 'instance creation' stamp: 'SF 3/25/2024 19:32:21'!
mago
	^Mago new initializeWithPuntosDeVidaMaximo: 20 dañoPorAtaque: 2.! !

!Combatiente class methodsFor: 'instance creation' stamp: 'SF 3/25/2024 19:51:03'!
ogro
	^CombatienteConEstrategia new initializeWithPuntosDeVidaMaximo: 40 dañoPorAtaque: 8.! !


!classDefinition: #CombatienteConEstrategia category: #Ejercicio01!
Combatiente subclass: #CombatienteConEstrategia
	instanceVariableNames: 'estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatienteConEstrategia methodsFor: 'public' stamp: 'SF 4/5/2024 18:45:34'!
enfocarseEnElMasHerido
	estrategia := self estrategiaEnfocarseEnElMasHerido.
! !

!CombatienteConEstrategia methodsFor: 'public' stamp: 'SF 4/5/2024 18:46:03'!
enfocarseEnElMasSano
	estrategia := self estrategiaEnfocarseEnElMasSano.
! !


!CombatienteConEstrategia methodsFor: 'initialization' stamp: 'SF 3/25/2024 19:50:22'!
initialize
	super initialize.
	self enfocarseEnElMasSano.
 ! !


!CombatienteConEstrategia methodsFor: '-- all --' stamp: 'SF 4/5/2024 18:25:02'!
elegirVictima
	^estrategia value: enemigos.
! !

!CombatienteConEstrategia methodsFor: 'private' stamp: 'SF 4/5/2024 12:08:08'!
elegirYAtacar

	| victimaElegida |
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida! !

!CombatienteConEstrategia methodsFor: 'public' stamp: 'SF 4/5/2024 18:45:34'!
enfocarseEnElMasHerido
	estrategia := self estrategiaEnfocarseEnElMasHerido.
! !

!CombatienteConEstrategia methodsFor: 'public' stamp: 'SF 4/5/2024 18:46:03'!
enfocarseEnElMasSano
	estrategia := self estrategiaEnfocarseEnElMasSano.
! !

!CombatienteConEstrategia methodsFor: 'initialization' stamp: 'SF 3/25/2024 19:50:22'!
initialize
	super initialize.
	self enfocarseEnElMasSano.
 ! !


!CombatienteConEstrategia methodsFor: 'private' stamp: 'SF 4/5/2024 12:08:08'!
elegirYAtacar

	| victimaElegida |
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida! !


!classDefinition: #Hostigador category: #Ejercicio01!
Combatiente subclass: #Hostigador
	instanceVariableNames: 'estrategia estrategiaTemporal estrategiaVigente estrategiaAlternativa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Hostigador methodsFor: 'private' stamp: 'SF 4/5/2024 18:12:04'!
alternarEstrategia
         
	estrategiaTemporal := estrategiaVigente.
	estrategiaVigente := estrategiaAlternativa.
	estrategiaAlternativa := estrategiaTemporal
! !

!Hostigador methodsFor: 'private' stamp: 'SF 4/5/2024 18:25:02'!
elegirVictima
	^estrategiaVigente value: enemigos.
! !

!Hostigador methodsFor: 'private' stamp: 'SF 4/5/2024 17:50:07'!
elegirYAtacar

	| victimaElegida |
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
	self alternarEstrategia.! !


!Hostigador methodsFor: 'initialization' stamp: 'SF 4/5/2024 18:46:09'!
initialize
	super initialize.
	estrategiaVigente := self estrategiaEnfocarseEnElMasSano.
	estrategiaAlternativa := self estrategiaEnfocarseEnElMasHerido.
 ! !


!classDefinition: #Mago category: #Ejercicio01!
Combatiente subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Mago methodsFor: 'public' stamp: 'SF 4/5/2024 18:46:16'!
elegirVictimas

	| estrategia |
	estrategia := self estrategiaEnfocarseEnElMasSano.
	^(enemigos sorted: [:one :another |
		(estrategia value: {one. another.}) = one]) firstAvailable: 6.
! !


!Mago methodsFor: 'private' stamp: 'SF 4/5/2024 12:08:40'!
elegirYAtacar

	| victimaElegidas |
		victimaElegidas := self elegirVictimas.
		victimaElegidas do: [:each | self atacarA: each]! !
