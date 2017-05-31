!classDefinition: #DistanciaTest category: #Distancia!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'twoMeters oneMeter halfMeter oneHundredCentimeters oneCentimeter oneMilimeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancia'!

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:16:13'!
setUp

twoMeters:=Distance withValue: 2 andMetric: Metric metro.
oneMeter:= Distance withValue: 1 andMetric: Metric metro.
halfMeter:= Distance withValue:0.5 andMetric: Metric metro.
oneHundredCentimeters:= Distance withValue: 100 andMetric: Metric centimetro.
oneCentimeter:= Distance withValue: 1 andMetric: Metric centimetro.
oneMilimeter:=Distance withValue: 1 andMetric: Metric milimetro.! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:25:46'!
test01EqualDistanceWithEqualUnit

	|unMetro unCentimetro |
	unMetro := Distance withValue: 1 andMetric:Metric metro.
	unCentimetro:= Distance withValue:1 andMetric: Metric centimetro.
	self assert: unMetro = oneMeter. 
	self assert: unCentimetro = oneCentimeter 
	
	"unMetro := Distance value: 1 withUnit: metro
	= aDistance 
		"! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:20:59'!
test02AddSameDistanceUnit

	|unMetro|
	unMetro := Distance withValue: 1 andMetric: Metric metro.
	self assert: (unMetro + oneMeter) =  twoMeters ! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:23:26'!
test03EqualDistanceWithDifferentsUnits

	|unMetro|
	unMetro := Distance withValue:1 andMetric: Metric metro.
	self assert: unMetro = oneHundredCentimeters .! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:34:07'!
test04AddingDistanceWithDifferentUnit

	| cienCentimetros dosmilMilimetros|
	dosmilMilimetros := Distance withValue:2000 andMetric: Metric milimetro.
	cienCentimetros := Distance withValue:100 andMetric: Metric centimetro.
	self assert: (oneMeter + cienCentimetros ) =  twoMeters.
	self assert: dosmilMilimetros = (cienCentimetros + oneMeter )! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:36:34'!
test05SubtractingDistance

	| cienCentimetros milMilimetros|
	milMilimetros := Distance withValue:1000 andMetric: Metric milimetro.

 	cienCentimetros := Distance withValue:100 andMetric: Metric centimetro.
	self assert: (twoMeters - cienCentimetros ) =  milMilimetros .
! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:42:48'!
test06MultiplyScalar

	| dosMetros|
	dosMetros:=Distance withValue:2 andMetric: Metric metro.

	self assert: ( oneMeter*2 ) =  dosMetros.! !

!DistanciaTest methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:44:23'!
test07ScalarMultiplication

	
	self assert: ( 2 * oneMeter) =  twoMeters .! !


!classDefinition: #Distance category: #Distancia!
Object subclass: #Distance
	instanceVariableNames: 'value metric'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancia'!

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:43:15'!
* aScalar

	^Distance withValue: self distanceValue*aScalar andMetric: self distanceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:37:27'!
+ anotherDistance

	| nuevaDistancia valorSuma |
		
	nuevaDistancia:= self convertTo: anotherDistance distanceUnit.
	valorSuma:= nuevaDistancia distanceValue + anotherDistance distanceValue.
	^Distance withValue: valorSuma andMetric:(anotherDistance distanceUnit)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:34:49'!
- anotherDistance

	| nuevaDistancia valorResta |
		
	nuevaDistancia:= self convertTo: anotherDistance distanceUnit. 
	nuevaDistancia distanceValue < nuevaDistancia distanceValue 
		ifTrue:[ ^self error: self "distanceErrorLargeSubtracting"].
	valorResta:= nuevaDistancia distanceValue - anotherDistance distanceValue.
	^Distance withValue: valorResta andMetric:(anotherDistance distanceUnit)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:52:17'!
/ aScalar

	aScalar > 0 ifFalse: [^self error: 'No se puede dividit por un numero menor a 1'].
	^Distance withValue: self distanceValue/aScalar andMetric: self distanceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:53:26'!
< aDistance


	| nuevaDistancia |
	nuevaDistancia:= self convertTo: aDistance distanceUnit.
	^ nuevaDistancia distanceValue < aDistance  distanceValue.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'asd 5/30/2017 13:31:03'!
= aDistance


	| nuevaDistancia |
	nuevaDistancia:= self convertTo: aDistance distanceUnit.
	^ nuevaDistancia distanceValue = aDistance  distanceValue.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:53:06'!
> aDistance


	| nuevaDistancia |
	nuevaDistancia:= self convertTo: aDistance distanceUnit.
	^ nuevaDistancia distanceValue > aDistance  distanceValue.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:46:19'!
adaptToInteger: rcvr andSend: selector
	
	^Distance withValue: (rcvr * value) andMetric: self distanceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:23:03'!
convertTo: aDistanceUnit

	| valorConNuevaUnidad valorMilimetrico |
	valorMilimetrico:= self distanceValue / self distanceUnit conversionFactor.
	valorConNuevaUnidad:= valorMilimetrico * aDistanceUnit conversionFactor.
	
	^Distance withValue: valorConNuevaUnidad andMetric: aDistanceUnit. ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:06:02'!
distanceUnit
	^metric! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/23/2017 19:31:59'!
distanceValue

	^value! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:40:39'!
initializeWithValue: aValue andMetric: aMetric

	aValue >0 ifFalse:[^self error: 'Valor invalido' ].
	value := aValue .
	metric := aMetric.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:55:48'!
to: aDistance by: aSteps

| interval nuevaDistancia nuevoValor |
interval:= Collection new.
nuevaDistancia:= self convertTo: aSteps distanceUnit .
nuevoValor:= nuevaDistancia distanceValue + aSteps distanceValue .
self distanceValue > aDistance distanceValue ifTrue:[^self error: 'No podes'].
self distanceValue > aDistance distanceValue 
	whileTrue:[
		interval add: (Distance withValue: nuevoValor andMetric: aSteps distanceUnit).
		nuevoValor:= nuevoValor + aSteps distanceValue.
	].
^interval.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #Distancia!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:03:44'!
withValue: aValue andMetric: aMetric

	^self new initializeWithValue: aValue andMetric: aMetric ! !


!classDefinition: #Metric category: #Distancia!
Object subclass: #Metric
	instanceVariableNames: 'changeFactor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancia'!

!Metric methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:23:17'!
conversionFactor

	^changeFactor ! !

!Metric methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:25:27'!
initializeWith: aFactor

	changeFactor := aFactor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metric class' category: #Distancia!
Metric class
	instanceVariableNames: ''!

!Metric class methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:07:46'!
centimetro

^Metric with:0.1! !

!Metric class methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:07:18'!
metro 

^ Metric with: 0.001! !

!Metric class methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 18:09:48'!
milimetro

	^Metric with:1.! !

!Metric class methodsFor: 'as yet unclassified' stamp: 'adfas 5/30/2017 17:24:48'!
with: aFactor

	^self new initializeWith: aFactor! !
