!classDefinition: #MarsRoverTest category: #'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'drill path' stamp: 'MB 4/28/2024 17:32:28'!
test_drillPath01
	|marsRover|
	
	"Esto no es TDD pero nos hace felices ver que puede ejecutar varias instrucciones y resulta en lo esperado :)"
	
	marsRover := MarsRover newWith: 0@0 facing: East new.
	marsRover processInstructions: 'frfrffrfrflfrfbblllf'.
	
	self assertRover: marsRover isAt: -1@0 facing: South new.
	! !


!MarsRoverTest methodsFor: 'testing - utils' stamp: 'MB 4/28/2024 17:24:54'!
assertRover: aRover isAt: position facing: aDirection
	self assert: (aRover isAt: position).
	self assert: (aRover isFacing: aDirection).! !


!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:29:49'!
test01_TheRoverDoesNotMoveWhenNoInstructionsAreGiven
	|marsRover|
	
	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: ''.
	
	self assertRover: marsRover isAt: 0@0 facing: North new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:29:32'!
test02_TheMarsRoverFacesEastWhenAskedToTurnRightWhileFacingNorth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: 'r'.
	
	self assertRover: marsRover isAt: 0@0 facing: East new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:30:14'!
test03_TheMarsRoverFacesWestWhenAskedToTurnLeftWhileFacingNorth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: 'l'.
	
	self assertRover: marsRover isAt: 0@0 facing: West new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:30:33'!
test04_TheMarsRoverFacesEastWhenAskedToTurnLeftWhileFacingSouth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: South new.
	marsRover processInstructions: 'l'.

	self assertRover: marsRover isAt: 0@0 facing: East new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:30:50'!
test05_TheMarsRoverMovesOnePointNorthWhenAskedToMoveForwardFacingNorth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: 'f'.
	
	self assertRover: marsRover isAt: 0@1 facing: North new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:31:06'!
test06_TheMarsRoverMovesOnePointSouthWhenAskedToMoveBackwardsWhileFacingNorth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: 'b'.
	
	self assertRover: marsRover isAt: 0@-1 facing: North new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:31:20'!
test07_TheMarsRoverMovesOnePointEastWhenAskedToMoveForwardFacingEast
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: East new.
	marsRover processInstructions: 'f'.
	
	self assertRover: marsRover isAt: 1@0 facing: East new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:31:36'!
test08_TheMarsRoverRaisesAnErrorWhenEncounteredWithAnInvalidInstruction
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: East new.

	self 
	should: [marsRover processInstructions: 'x']  
	raise: Error
	withExceptionDo: [:anError | self assert: MarsRover instructionNotUnderstood equals: anError messageText].
	
	self assertRover: marsRover isAt: 0@0 facing: East new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MB 4/28/2024 17:31:52'!
test09_TheMarsRoverMovesTwoPointsNorthWhenAskedToMoveTwoPointsForwardNorth
	|marsRover|

	marsRover := MarsRover newWith: 0@0 facing: North new.
	marsRover processInstructions: 'ff'.
	
	self assertRover: marsRover isAt: 0@2 facing: North new.! !


!classDefinition: #CardinalDirection category: #'Mars-Rover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!CardinalDirection methodsFor: 'comparison' stamp: 'fs 4/28/2024 10:43:53'!
= anotherCardinalDirection
	^self class = anotherCardinalDirection class.
	! !


!CardinalDirection methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:26:07'!
cardinalDirectionToTheLeft

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:26:15'!
cardinalDirectionToTheRight

	self subclassResponsibility! !


!CardinalDirection methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:13:34'!
advanceBackwards: aCoordinate

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:13:52'!
advanceForward: aCoordinate

	self subclassResponsibility! !


!classDefinition: #East category: #'Mars-Rover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!East methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:27:52'!
cardinalDirectionToTheLeft
	^ North new.! !

!East methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:27:59'!
cardinalDirectionToTheRight
	^ South new.! !


!East methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:15:28'!
advanceBackwards: aCoordinate
	^ aCoordinate - (1@0).! !

!East methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:16:42'!
advanceForward: aCoordinate
	^ aCoordinate + (1@0).! !


!classDefinition: #North category: #'Mars-Rover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!North methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:28:10'!
cardinalDirectionToTheLeft
	^ West new.! !

!North methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:28:17'!
cardinalDirectionToTheRight
	^ East new.! !


!North methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:16:10'!
advanceBackwards: aCoordinate
	^ aCoordinate  - (0@1).! !

!North methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:16:17'!
advanceForward: aCoordinate
	^ aCoordinate  + (0@1).! !


!classDefinition: #South category: #'Mars-Rover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!South methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:17:22'!
advanceBackwards: aCoordinate
	^aCoordinate  + (0@1).! !

!South methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:17:20'!
advanceForward: aCoordinate
	^aCoordinate  - (0@1).! !


!South methodsFor: 'rotation' stamp: 'fs 4/28/2024 11:25:22'!
cardinalDirectionToTheLeft
	^ East new.! !

!South methodsFor: 'rotation' stamp: 'fs 4/28/2024 11:25:26'!
cardinalDirectionToTheRight
	^West new.! !


!classDefinition: #West category: #'Mars-Rover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!West methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:18:23'!
advanceBackwards: aCoordinate
	^aCoordinate + (1@0).! !

!West methodsFor: 'positioning' stamp: 'fs 4/28/2024 11:17:57'!
advanceForward: aCoordinate
	^aCoordinate  - (1@0).
	! !


!West methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:28:58'!
cardinalDirectionToTheLeft
	^South new.! !

!West methodsFor: 'rotation' stamp: 'fs 4/28/2024 10:29:08'!
cardinalDirectionToTheRight
	^North new.! !


!classDefinition: #MarsRover category: #'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate cardinalDirection instructionSet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'MB 4/28/2024 17:59:47'!
initilizeWith: aCoordinatePoint  facing: aCardinalDirection
	coordinate := aCoordinatePoint.
	cardinalDirection := aCardinalDirection.
	
	instructionSet := Dictionary new.

	instructionSet add: $l->[
		cardinalDirection := cardinalDirection cardinalDirectionToTheLeft.
	].

	instructionSet add: $r->[
		cardinalDirection := cardinalDirection cardinalDirectionToTheRight.
	].

	instructionSet add: $f->[
		coordinate := cardinalDirection advanceForward: coordinate.
	].

	instructionSet add: $b->[
		coordinate := cardinalDirection advanceBackwards: coordinate.
	].
! !


!MarsRover methodsFor: 'private' stamp: 'MB 4/28/2024 17:58:19'!
processSingleInstruction: singleInstruction
	|instructionToExecute|

	"
	Discutimos crear otra jerarquía del tipo `Instruction` o `InstructionProcessor` aplicando un switch dinámico con envío de un
	mensaje polimórfico pero complejizaría mucho el modelo. Para extender el repertorio de instrucciones del rover basta con
	agregar 	otra entrada al diccionario.
	"

	instructionToExecute := instructionSet at: singleInstruction ifAbsent: [
		^ self error: self class instructionNotUnderstood.
	].

	instructionToExecute value.

	! !


!MarsRover methodsFor: 'public' stamp: 'MB 4/28/2024 12:14:42'!
isAt: aCoordinate
	^ aCoordinate = coordinate.! !

!MarsRover methodsFor: 'public' stamp: 'MB 4/28/2024 12:14:35'!
isFacing: aCardinalDirection	
	^ cardinalDirection class = aCardinalDirection class.! !

!MarsRover methodsFor: 'public' stamp: 'MB 4/28/2024 17:55:49'!
processInstructions: instructionString

	instructionString do: [ :singleInstruction |
		self processSingleInstruction: singleInstruction
	].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'fs 4/28/2024 11:51:03'!
instructionNotUnderstood
	^'The instruction given is invalid'.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'fs 4/26/2024 20:11:56'!
newWith: anInitialPoint facing: anInitialDirection
	^ self new initilizeWith: anInitialPoint  facing: anInitialDirection.
	! !
