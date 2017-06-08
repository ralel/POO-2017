!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'oneCelsius oneMeter oneCentimeter oneKelvin twoKelvin twoCelsius thirtyTwoFahrenheits oneDecameter zeroCelsius oneHundredCentimeter zeroMeters zeroSeconds zeroMinutes zeroMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'Temperature Measures' stamp: 'asd 6/8/2017 02:17:24'!
oneCelsius
	^Temperature withTemperatureValue: 1  andTemperatureUnit: Unit Celsius ! !

!MeasureTest methodsFor: 'Temperature Measures' stamp: 'asd 6/5/2017 21:46:25'!
thirtyTwoFahrenheits
	^Temperature withTemperatureValue: 32  andTemperatureUnit: Unit fahrenheit. ! !

!MeasureTest methodsFor: 'Temperature Measures' stamp: 'asd 6/8/2017 02:17:55'!
twoCelsius
	^Temperature withTemperatureValue: 2  andTemperatureUnit: Unit Celsius . ! !

!MeasureTest methodsFor: 'Temperature Measures' stamp: 'asd 6/8/2017 02:18:02'!
zeroCelsius
	^Temperature withTemperatureValue: 0  andTemperatureUnit: Unit Celsius . ! !

!MeasureTest methodsFor: 'Temperature Measures' stamp: 'asd 6/5/2017 21:48:02'!
zeroKelvin
	^Temperature withTemperatureValue: 0  andTemperatureUnit: Unit kelvin . ! !


!MeasureTest methodsFor: 'testAddMeasure' stamp: 'asd 6/8/2017 02:17:48'!
test01Addingcelsius
	| unCelsius otroCelsius |
	unCelsius:= oneCelsius. 
	otroCelsius := Measure initializeWithValue: 1 andUnit: Unit Celsius . 
	self assert: (otroCelsius + unCelsius ) =  twoCelsius ! !

!MeasureTest methodsFor: 'testAddMeasure' stamp: 'asd 6/8/2017 02:06:15'!
test02AddingDifferentsUnitsTemperature
	| unCelsius result sixtyFourFahrenheit |
	unCelsius:= self zeroCelsius. 
	sixtyFourFahrenheit := Measure initializeWithValue:  64 andUnit: Unit fahrenheit . 
	 result := ( unCelsius + self thirtyTwoFahrenheits) .
	self assert: result  = sixtyFourFahrenheit ! !

!MeasureTest methodsFor: 'testAddMeasure' stamp: 'asd 6/7/2017 19:19:43'!
test03AddingDistanceWithTemperature

	| boolean |
	
	self assert: (oneCentimeter + oneKelvin )  = (oneKelvin + oneCentimeter)! !

!MeasureTest methodsFor: 'testAddMeasure' stamp: 'asd 6/8/2017 17:49:34'!
test04AddingDistanceWithTwoTemperature

	| anExpression otherExpression|
	anExpression:=oneCentimeter + oneKelvin + oneKelvin.
	otherExpression:=twoKelvin + oneCentimeter.
	self assert: (oneCentimeter + oneKelvin + oneKelvin )  = (twoKelvin + oneCentimeter)! !


!MeasureTest methodsFor: 'setUp' stamp: 'asd 6/8/2017 13:31:32'!
setUp

"temperatures"
zeroCelsius:= Measure initializeWithValue: 0 andUnit:Unit Celsius .
oneCelsius:= Measure initializeWithValue: 1 andUnit:Unit Celsius .
twoCelsius:= Measure initializeWithValue: 2 andUnit:Unit Celsius .
thirtyTwoFahrenheits:= Measure initializeWithValue: 32 andUnit: Unit fahrenheit. 
oneKelvin:= Measure initializeWithValue: 1 andUnit: Unit kelvin.
twoKelvin:= Measure initializeWithValue: 2 andUnit: Unit kelvin.
"distances"
zeroMeter:= Measure initializeWithValue: 0 andUnit:Unit meter.
oneMeter:= Measure initializeWithValue: 1 andUnit:Unit meter.
oneCentimeter:= Measure initializeWithValue: 1 andUnit: Unit centimeter .
oneHundredCentimeter:= Measure initializeWithValue: 100 andUnit: Unit centimeter . 
oneDecameter:= Measure initializeWithValue: 1 andUnit: Unit decameter . 
"times"
zeroSeconds:= Measure initializeWithValue: 0 andUnit:Unit seconds .
zeroMinutes:=Measure initializeWithValue: 0 andUnit:Unit minute .! !


!MeasureTest methodsFor: 'testEqualMeasure' stamp: 'asd 6/8/2017 02:26:31'!
test01EqualUnits
	| otroCelsius |
	otroCelsius:= Measure initializeWithValue: 1 andUnit: Unit Celsius .
	self assert: oneCelsius = otroCelsius.! !

!MeasureTest methodsFor: 'testEqualMeasure' stamp: 'asd 6/8/2017 13:27:32'!
test02DifferentUnitsButEqualMagnitude
	
	self assert: zeroCelsius = thirtyTwoFahrenheits .
	self assert: oneMeter = oneHundredCentimeter.! !

!MeasureTest methodsFor: 'testEqualMeasure' stamp: 'asd 6/8/2017 13:28:03'!
test03DifferentMeasures
	
	self assert: zeroCelsius = zeroMeter .
	self assert: zeroSeconds = zeroCelsius .
	self assert: zeroSeconds = zeroMinutes.! !


!MeasureTest methodsFor: 'as yet unclassified' stamp: 'adfas 6/6/2017 20:36:20'!
test01
	| unCelsius |
	unCelsius:= self oneCelsius. 
	self assert: unCelsius equals: self oneCelsius ! !


!classDefinition: #Expression category: #'Measure-Solution'!
Object subclass: #Expression
	instanceVariableNames: 'termino'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Expression methodsFor: 'accesing' stamp: 'asd 6/7/2017 20:26:29'!
addMeasure: aMeasure
	termino at: aMeasure unit put:aMeasure.

	! !

!Expression methodsFor: 'accesing' stamp: 'asd 6/7/2017 18:40:02'!
initExpression

termino:= Dictionary new.! !

!Expression methodsFor: 'accesing' stamp: 'asd 6/7/2017 18:44:59'!
term
	^termino.
	! !


!Expression methodsFor: 'operations' stamp: 'asd 6/8/2017 01:50:05'!
+ aMeasure
	
	(self term includesKey: aMeasure unit) 
	ifTrue: [ | measureSave |	measureSave:= self term at: aMeasure unit.
				measureSave:= measureSave + aMeasure .
				self term at:aMeasure unit put:measureSave ]
	ifFalse:[	self addMeasure: aMeasure ]		! !

!Expression methodsFor: 'operations' stamp: 'asd 6/7/2017 19:04:49'!
= Expression
.
	^self term = Expression term.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Expression class' category: #'Measure-Solution'!
Expression class
	instanceVariableNames: ''!

!Expression class methodsFor: 'as yet unclassified' stamp: 'asd 6/7/2017 13:59:20'!
initializeExpression
^Expression new initExpression.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'measureValue unitMeasure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'operations' stamp: 'asd 6/5/2017 19:27:35'!
* aMeasure

 self subclassResponsibility.! !

!Measure methodsFor: 'operations' stamp: 'asd 6/8/2017 01:44:46'!
+ aMeasure

     ( (self unit unitBase = aMeasure unit unitBase)  )
		ifTrue:[|newAmount selfMeasureBase measureBase|
				selfMeasureBase:= self convertToBase.
				measureBase:= aMeasure convertToBase.
				newAmount:= selfMeasureBase amount+ measureBase amount.
				^Measure initializeWithValue: newAmount andUnit: self unit unitBase.
				 ]
		ifFalse:[ | aNewExpression aBaseMeasure aBaseSelf |
				aNewExpression := Expression initializeExpression.
				aBaseMeasure:= aMeasure convertToBase.
				aBaseSelf:= self convertToBase .
				aNewExpression addMeasure: aMeasure.
				aNewExpression addMeasure: self.
				^ aNewExpression ].! !

!Measure methodsFor: 'operations' stamp: 'asd 6/8/2017 18:00:46'!
- aMeasure


     ( (self unit unitBase = aMeasure unit unitBase)  )
		ifTrue:[|newAmount selfMeasureBase measureBase|
				selfMeasureBase:= self convertToBase.
				measureBase:= aMeasure convertToBase.
				newAmount:= selfMeasureBase amount- measureBase amount.
				^Measure initializeWithValue: newAmount andUnit: self unit unitBase.
				 ]
		ifFalse:[ | aNewExpression aBaseMeasure aBaseSelf |
				aNewExpression := Expression initializeExpression.
				aBaseMeasure:= aMeasure convertToBase.
				aBaseSelf:= self convertToBase .
				aNewExpression addMeasure: aMeasure.
				aNewExpression addMeasure: self.
				^ aNewExpression ].! !

!Measure methodsFor: 'operations' stamp: 'asd 6/5/2017 19:30:19'!
/ aMeasure

 self subclassResponsibility.! !

!Measure methodsFor: 'operations' stamp: 'asd 6/5/2017 19:29:59'!
< aMeasure

 self subclassResponsibility.! !

!Measure methodsFor: 'operations' stamp: 'asd 6/8/2017 13:34:09'!
= aMeasure

	(self unit magnitude = aMeasure unit magnitude ) ifFalse:[^self amount = aMeasure amount and: self amount = 0 ]
	ifTrue:[^ self hash = aMeasure hash].! !

!Measure methodsFor: 'operations' stamp: 'asd 6/7/2017 21:36:23'!
hash
	| aMeasureUnitBase |
	aMeasureUnitBase:= self convertToBase.
	^ aMeasureUnitBase amount hash! !


!Measure methodsFor: 'accesing' stamp: 'asd 6/7/2017 18:54:24'!
amount
	^ measureValue ! !

!Measure methodsFor: 'accesing' stamp: 'asd 6/7/2017 18:53:47'!
unit
	^ unitMeasure ! !

!Measure methodsFor: 'accesing' stamp: 'asd 6/7/2017 17:07:07'!
withValue: aValue andUnit: aUnit

measureValue:= aValue.
unitMeasure:=aUnit.! !


!Measure methodsFor: 'as yet unclassified' stamp: 'asd 6/8/2017 02:40:00'!
convertToBase
	(self unit isProporcional) ifTrue:[ | aUnitBaseAmount | aUnitBaseAmount:= self amount / self unit conversionFactor.
										^Measure initializeWithValue: aUnitBaseAmount andUnit: self unit unitBase]
								ifFalse:[
										| valorReturn |
										(self unit myUnit = 'celsius') ifTrue:[^self].
										valorReturn := self amount - 273.15.
										(self unit myUnit = 'fahrenheit') ifTrue:[valorReturn := (self amount - 32)/ 1.8].
										^Measure initializeWithValue: valorReturn andUnit: self unit unitBase 										
										]	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'asd 6/7/2017 21:18:25'!
initializeWithValue: aValue andUnit: aUnit

^Measure new withValue: aValue andUnit:aUnit.! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'Temperature measures' stamp: 'asd 6/8/2017 18:27:40'!
oneCelsius
^Measure initializeWithValue: 1 andUnit: Unit Celsius. ! !

!MeasureFactory methodsFor: 'Temperature measures' stamp: 'asd 6/8/2017 18:28:25'!
thirtyTwoFahrenheits
^Measure initializeWithValue: 32 andUnit: Unit fahrenheit ! !

!MeasureFactory methodsFor: 'Temperature measures' stamp: 'asd 6/8/2017 18:28:45'!
twoCelsius
^Measure initializeWithValue: 2 andUnit: Unit Celsius ! !

!MeasureFactory methodsFor: 'Temperature measures' stamp: 'asd 6/8/2017 18:29:13'!
zeroCelsius
^Measure initializeWithValue: 0 andUnit: Unit Celsius ! !

!MeasureFactory methodsFor: 'Temperature measures' stamp: 'asd 6/8/2017 18:29:31'!
zeroKelvin
^Measure initializeWithValue: 0 andUnit: Unit kelvin ! !


!MeasureFactory methodsFor: 'Temperature units' stamp: 'asd 6/8/2017 18:23:58'!
celsius
^Unit Celsius ! !

!MeasureFactory methodsFor: 'Temperature units' stamp: 'asd 6/8/2017 18:24:19'!
fahrenheit
^Unit fahrenheit ! !

!MeasureFactory methodsFor: 'Temperature units' stamp: 'asd 6/8/2017 18:24:27'!
kelvin
^Unit kelvin
! !


!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:20:43'!
minusOneMeter
^Measure initializeWithValue: -1 andUnit: Unit meter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:21:18'!
oneCentimeter
^Measure initializeWithValue: 1 andUnit: Unit centimeter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:21:41'!
oneHundredCentimeter
^Measure initializeWithValue: 100 andUnit: Unit centimeter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:22:06'!
oneMeter
^Measure initializeWithValue: 1 andUnit: Unit meter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:22:31'!
twoHundredCentimeters
^Measure initializeWithValue: 200 andUnit: Unit centimeter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:22:49'!
twoMeters
^Measure initializeWithValue: 2 andUnit: Unit meter ! !

!MeasureFactory methodsFor: 'Distance Measure' stamp: 'asd 6/8/2017 18:23:05'!
zeroMeter
^Measure initializeWithValue: 0 andUnit: Unit meter ! !


!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:09:08'!
centimeter

^ Unit centimeter.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:10:15'!
decameter
^Unit decameter.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:10:26'!
decimeter
^Unit decimeter.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:10:38'!
hectometer
^Unit hectometer.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:19:40'!
kilometer
^Unit kilometer.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:11:11'!
meter
^Unit meter.! !

!MeasureFactory methodsFor: 'Distance Unit' stamp: 'asd 6/8/2017 18:19:31'!
milimeter
^Unit Milimeter.! !


!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:34:36'!
oneDay
^Unit day ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:34:54'!
oneHour
^Unit hour ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:39:36'!
oneMinute
^Measure initializeWithValue: 1 andUnit: Unit minute! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:40:05'!
oneSecond
^Measure initializeWithValue: 1 andUnit: Unit seconds ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:40:36'!
sixtyMinutes
^Measure initializeWithValue: 60 andUnit: Unit minute ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:41:33'!
sixtyOneSeconds
^Measure initializeWithValue: 61 andUnit: Unit seconds ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:42:05'!
sixtySeconds
^Measure initializeWithValue: 60 andUnit: Unit seconds ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:42:29'!
twentyFourHours
^Measure initializeWithValue: 24 andUnit: Unit hour ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:42:47'!
twoSeconds
^Measure initializeWithValue: 2 andUnit: Unit seconds ! !

!MeasureFactory methodsFor: 'Time measures' stamp: 'asd 6/8/2017 18:43:03'!
zeroSeconds
^Measure initializeWithValue: 0 andUnit: Unit seconds ! !


!MeasureFactory methodsFor: 'Time units' stamp: 'asd 6/8/2017 18:35:51'!
day
^Unit day ! !

!MeasureFactory methodsFor: 'Time units' stamp: 'asd 6/8/2017 18:35:38'!
hour
^Unit hour ! !

!MeasureFactory methodsFor: 'Time units' stamp: 'asd 6/8/2017 18:36:05'!
minute
^Unit minute ! !

!MeasureFactory methodsFor: 'Time units' stamp: 'asd 6/8/2017 18:36:18'!
second
^Unit seconds ! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'factor unit magnitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'unitAccesing' stamp: 'asd 6/5/2017 19:34:37'!
conversionFactor

^factor.! !

!Unit methodsFor: 'unitAccesing' stamp: 'asd 6/5/2017 19:37:08'!
initializeWith: aUnit converterFactor: aFactor

unit:= aUnit.
factor:= aFactor.! !

!Unit methodsFor: 'unitAccesing' stamp: 'asd 6/7/2017 21:22:46'!
initializeWith: aUnit converterFactor: aFactor andType: aType

unit:= aUnit.
factor:= aFactor.
magnitude:= aType.! !

!Unit methodsFor: 'unitAccesing' stamp: 'asd 6/7/2017 21:23:07'!
magnitude

^magnitude! !

!Unit methodsFor: 'unitAccesing' stamp: 'adfas 6/6/2017 20:32:04'!
myUnit

	^unit! !


!Unit methodsFor: 'operations' stamp: 'asd 6/8/2017 01:39:12'!
= anotherUnit
	^self myUnit = anotherUnit myUnit and: self magnitude = anotherUnit magnitude and: self conversionFactor = anotherUnit conversionFactor.! !

!Unit methodsFor: 'operations' stamp: 'asd 6/8/2017 02:33:42'!
isProporcional
	^(self magnitude = 'temperature')not! !

!Unit methodsFor: 'operations' stamp: 'asd 6/8/2017 02:18:43'!
unitBase
	(self magnitude = 'temperature') ifTrue:[^Unit Celsius].
	(self magnitude = 'distance') ifTrue: [^Unit Milimeter].
	(self magnitude = 'time') ifTrue: [^Unit seconds]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'time unit' stamp: 'asd 6/7/2017 21:14:35'!
day
^Unit new initializeWith: 'day' converterFactor: 0.0006944 andType: 'time'.! !

!Unit class methodsFor: 'time unit' stamp: 'asd 6/8/2017 13:15:50'!
minute
^Unit new initializeWith:'minute'  converterFactor:0.0166667  andType: 'time'! !

!Unit class methodsFor: 'time unit' stamp: 'asd 6/7/2017 21:12:59'!
seconds
^Unit new initializeWith:'seconds' converterFactor:1 andType: 'time'! !


!Unit class methodsFor: 'temperature unit' stamp: 'asd 6/8/2017 02:17:05'!
Celsius

^Unit new initializeWith: 'celsius' converterFactor: 1 andType: 'temperature'.! !

!Unit class methodsFor: 'temperature unit' stamp: 'asd 6/7/2017 21:19:49'!
fahrenheit

^Unit new initializeWith: 'fahrenheit' converterFactor: 33.8 andType: 'temperature'! !

!Unit class methodsFor: 'temperature unit' stamp: 'asd 6/8/2017 02:18:56'!
kelvin
^Unit new initializeWith: 'kelvin' converterFactor: 274.14 andType:'temperature'! !


!Unit class methodsFor: 'distance unit' stamp: 'asd 6/7/2017 21:53:20'!
Milimeter

^Unit new initializeWith:'milimeter'  converterFactor:1  andType:'distance' ! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/8/2017 02:03:10'!
centimeter

^Unit new initializeWith:'centimeter'  converterFactor:0.1  andType:'distance' ! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/7/2017 21:12:14'!
decameter
^Unit new initializeWith:'decameter' converterFactor:0.0001 andType: 'distance'! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/8/2017 18:14:18'!
decimeter
^Unit new initializeWith:'decimeter' converterFactor:0.01 andType: 'distance'! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/8/2017 18:17:14'!
hectometer
^Unit new initializeWith:'hectometer' converterFactor:0.00001 andType: 'distance'! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/8/2017 18:17:20'!
kilometer
^Unit new initializeWith:'kilometer' converterFactor:0.00001 andType: 'distance'! !

!Unit class methodsFor: 'distance unit' stamp: 'asd 6/8/2017 02:02:21'!
meter

^Unit new initializeWith:'meter'  converterFactor:0.001  andType:'distance' ! !
