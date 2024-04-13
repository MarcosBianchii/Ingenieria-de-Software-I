!classDefinition: #NumeroTest category: #'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'MB 4/13/2024 15:21:01'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'MB 4/13/2024 15:49:33'!
test07EnteroDividesEnteroCorrectly

	|a b|
	a := one.
	b := two / two.

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'fs 4/12/2024 20:53:16'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths a|

	sevenTenths := (Entero with: 7) / (Entero with: 10).
	a := oneFifth + oneHalf.
	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'MB 4/13/2024 15:24:40'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs a |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	
	
	a := one - fiveHalfs.
	
	self assert: negativeThreeHalfs equals: a.! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'MB 4/13/2024 15:13:42'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor
	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'MB 4/13/2024 14:50:15'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.! !


!classDefinition: #Numero category: #'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:23:04'!
negated

	self subclassResponsibility! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: #'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 11:04:52'!
* aMultiplier 
	
	^ aMultiplier timesInteger: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fs 4/12/2024 20:22:53'!
+ anAdder 

	^ anAdder addInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 12:07:59'!
- aSubtrahend 
	
	^ aSubtrahend subtractsInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 11:52:51'!
/ aDivisor 
	
	^ aDivisor dividesInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 14:28:05'!
fibonacci

	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:23:16'!
negated

	self subclassResponsibility! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'MB 4/13/2024 15:03:36'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 15:51:33'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:26:44'!
addFraction: aFraction
	| numerator denominator |
	
	denominator := aFraction denominator.
	numerator := self * denominator + aFraction numerator.
	^ numerator / denominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 15:29:54'!
addInteger: anInteger
	^ Entero with: value + anInteger integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:58:51'!
dividesFraction: aFraction
	^ aFraction numerator / (aFraction denominator * self).! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:28:45'!
dividesInteger: anInteger

	^ Fraccion with: anInteger over: self.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 15:30:10'!
greatestCommonDivisorWith: anEntero 
	
	^ Entero with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:18:19'!
subtractsFraction: aFraction
	| numerator denominator |
	denominator := aFraction denominator.
	numerator := aFraction numerator - (self * denominator).
	^ numerator / denominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 15:30:17'!
subtractsInteger: anInteger
	^ Entero with: anInteger integerValue - value.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:14:24'!
timesFraction: aFraction
	| numerator |
	numerator := self * aFraction numerator.
	^ numerator / aFraction denominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 15:30:24'!
timesInteger: anInteger
	^ Entero with: value * anInteger integerValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 14:46:08'!
fits: aValue
	self subclassResponsibility.! !

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 15:04:24'!
with: aValue 
	| valueClass |
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	valueClass := self subclasses detect: [ :subclass |  subclass fits: aValue].
	
	^ valueClass with: aValue.! !


!classDefinition: #Negativo category: #'Numeros-Parte2-Ejercicio'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 14:29:10'!
fibonacci
	^ self error: Entero negativeFibonacciErrorDescription.
	
	
		! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:24:08'!
negated
	^ Positivo with: (value * -1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: #'Numeros-Parte2-Ejercicio'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'public' stamp: 'MB 4/13/2024 14:46:48'!
fits: aValue
	^ aValue < 0.! !


!Negativo class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 15:06:19'!
with: aValue
	^ self new initializeWith: aValue.! !


!classDefinition: #One category: #'Numeros-Parte2-Ejercicio'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!One methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:45:11'!
fibonacci
	^ self.! !

!One methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:45:04'!
negated
	^ Negativo with: -1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: #'Numeros-Parte2-Ejercicio'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 15:43:57'!
with: aValue
	^ self new initializeWith: aValue.! !


!One class methodsFor: 'public' stamp: 'MB 4/13/2024 15:44:08'!
fits: aValue
	^ aValue = 1.! !


!classDefinition: #Positivo category: #'Numeros-Parte2-Ejercicio'!
Entero subclass: #Positivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Positivo methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:51:46'!
fibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	^ (self - one) fibonacci + (self - two) fibonacci.
	
	
		! !

!Positivo methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:23:55'!
negated
	^ Negativo with: (value * -1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Positivo class' category: #'Numeros-Parte2-Ejercicio'!
Positivo class
	instanceVariableNames: ''!

!Positivo class methodsFor: 'public' stamp: 'MB 4/13/2024 15:44:34'!
fits: aValue
	^ aValue > 1.! !


!Positivo class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 15:05:54'!
with: aValue
	^ self new initializeWith: aValue.! !


!classDefinition: #Zero category: #'Numeros-Parte2-Ejercicio'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Zero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:36:30'!
fibonacci
	^ Entero with: 1.! !

!Zero methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:36:00'!
negated
	^ self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: #'Numeros-Parte2-Ejercicio'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'instance creation' stamp: 'MB 4/13/2024 15:34:56'!
with: aValue
	^ self new initializeWith: aValue.! !


!Zero class methodsFor: 'public' stamp: 'MB 4/13/2024 15:34:41'!
fits: aValue
	^ aValue = 0.! !


!classDefinition: #Fraccion category: #'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 11:12:21'!
* aMultiplier 
	
	^ aMultiplier timesFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fs 4/12/2024 20:56:34'!
+ anAdder 
	
	^anAdder addFraction: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 12:14:08'!
- aSubtrahend 
	^ aSubtrahend subtractsFraction: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 11:59:32'!
/ aDivisor 
	
	^ aDivisor dividesFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MB 4/13/2024 15:23:04'!
negated
	^ self * (Entero with: -1).! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fs 4/12/2024 20:57:48'!
addFraction: aFraction
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:13:38'!
addInteger: anInteger
	| newNumerator |
	newNumerator := anInteger * denominator + numerator.
	^ newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:02:04'!
dividesFraction: aFraction
	^ (aFraction numerator * denominator) / (aFraction denominator * numerator).! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:00:10'!
dividesInteger: anInteger
	^  (anInteger * denominator) / numerator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:43:51'!
overFraction: aFraction
	^ (denominator * aFraction numerator) / (numerator * aFraction denominator).! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:13:34'!
subtractsFraction: aFraction
	| newNumerator newDenominator |
	
	newNumerator := (aFraction numerator * denominator) - (aFraction denominator * numerator).
	newDenominator := aFraction denominator * denominator.
	
	^ newNumerator / newDenominator.
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 12:10:58'!
subtractsInteger: anInteger
	| newNumerator |
	newNumerator := anInteger * denominator - numerator.
	^ newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:12:58'!
timesFraction: aFraction
	| newNumerator newDenominator |
	
	newNumerator := numerator * aFraction numerator.
	newDenominator := denominator * aFraction denominator.
	
	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MB 4/13/2024 11:13:21'!
timesInteger: anInteger
	^ (numerator * anInteger) / denominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
