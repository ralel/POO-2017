!classDefinition: #TestApiRest category: #Sistema!
TestCase subclass: #TestApiRest
	instanceVariableNames: 'idUser aPass userOne users apiTesting userTwo passOne'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!TestApiRest methodsFor: 'setUp' stamp: 'asdf 6/27/2017 01:38:44'!
setUp

userOne:= 'batman'.
passOne:=1234.
userTwo:='rick'.
users:=Dictionary new.
users at:userOne put:passOne.
apiTesting:= ApiRest initializeAnApiRestWith: users.! !


!TestApiRest methodsFor: 'loginTest' stamp: 'asdf 6/27/2017 01:33:22'!
test01AuthenticationUserFailed
	| apiRest pass user |
	apiRest:= apiTesting .
	user:= userTwo .
	pass:= aPass.
	self 
		should:[ apiRest loginUser: user withPass: pass]
		raise:Error
		withExceptionDo:[:anError |
							self assert: anError messageText equals:'user is not registered'
							]
	! !

!TestApiRest methodsFor: 'loginTest' stamp: 'asdf 6/27/2017 01:37:49'!
test02AuthenticationPassFailed
	| apiRest pass user |
	apiRest:= apiTesting .
	user:= userOne .
	pass:= aPass.
	self 
		should:[ apiRest loginUser: user withPass: pass]
		raise:Error
		withExceptionDo:[:anError |
							self assert: anError messageText equals:'password incorrect'
							]
	! !

!TestApiRest methodsFor: 'loginTest' stamp: 'asdf 6/27/2017 01:59:29'!
test03AuthenticationSuccesfull
	| apiRest pass user |
	apiRest:= ApiRest initializeAnApiRest .
	user:= idUser.
	pass:= aPass.
	self 
		should:[ apiRest loginUser: user withPass: pass]
		raise:Error
		withExceptionDo:[self assert: 1=1]
	"acerta el tiempo del carrito?..."! !


!classDefinition: #TestCart category: #Sistema!
TestCase subclass: #TestCart
	instanceVariableNames: 'bookOne bookeTwo bookThree aCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!TestCart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 18:20:55'!
setUp
"isbn's"
bookOne:= 123.
bookeTwo:= -1234.
bookThree:= 211.

aCatalogue:=Dictionary new.
! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 19:37:46'!
test01IsEmpty

	| nuevoCarrito |
	nuevoCarrito:= Cart initCartWith: aCatalogue .
	self assert: nuevoCarrito isEmpty! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 21:31:46'!
test02AddingAbook

	| nuevoCarrito |
	nuevoCarrito:= Cart initCartWith: aCatalogue .
	
	self should:[nuevoCarrito addBook: bookOne .]
		raise: Error
		withExceptionDo:[ :anError| self assert: anError messageText equals: 'Book is not valid'.
							 self assert: nuevoCarrito isEmpty.
							].
		  ! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asd 6/19/2017 17:30:48'!
test03AddingAbooks

	| miCarrito |
	miCarrito:= Cart initCartWith: aCatalogue.
	miCarrito add: 5 ofBook: bookOne.
	self assert: miCarrito size = 5. 
	"buscar funcion, que retorne la cantidad de elementos diferentes y no el tamanio"
		! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 20:05:08'!
test04QuantityOfBook

	| nuevoCarrito |
	nuevoCarrito:= Cart initCartWith: aCatalogue .
	nuevoCarrito add: 5 ofBook: bookOne .
	self assert: (nuevoCarrito quantityOf: bookOne) = 5.! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 18:20:11'!
test05EqualsCart

	| miCarrito nuevoCarrito |
	aCatalogue at:bookOne put: 10.
	aCatalogue at:bookeTwo put: 8. 
	miCarrito:= Cart initCartWith: aCatalogue.
	miCarrito add: 5 ofBook: bookOne.
	miCarrito addBook: bookeTwo.	
	nuevoCarrito:= Cart initCartWith: aCatalogue.
	nuevoCarrito addBook: bookeTwo.
	nuevoCarrito add: 5 ofBook: bookOne.
	
	self assert: nuevoCarrito = miCarrito 
	
		! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 18:23:13'!
test06NotAddNegativeAmount
	| miCarrito |
	aCatalogue at:bookOne put:9.
	miCarrito:= Cart initCartWith: aCatalogue.

self 	should: [ miCarrito add: -5 ofBook: bookOne.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'no podes agregar cantidades negatives'.
			self assert: miCarrito size = 0.
			 ]	
	
		! !


!classDefinition: #TestCashier category: #Sistema!
TestCase subclass: #TestCashier
	instanceVariableNames: 'catalogue salesBook aCart aCashier aDate anEmptyCart currentDate aMerchant'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!TestCashier methodsFor: 'setUp' stamp: 'asdf 6/26/2017 16:36:03'!
setUp

	catalogue:= Dictionary new.
	catalogue at: 1234 put: 5.
	catalogue at: 123456 put:9. 
	salesBook:= Dictionary  new.
	anEmptyCart:= Cart initCartWith: catalogue . 
	aCart:=Cart initCartWith: catalogue .
	aCart addBook:1234.
	aCart add: 3 ofBook: 123456.
	aMerchant:=  MpSimulator new.
	aCashier:= Cashier initCashierWith: salesBook and: aMerchant.
	currentDate:= GregorianMonth current ofYear: GregorianYear current.
	aDate:= GregorianMonth december ofYear: GregorianYear current previous.
	
	! !


!TestCashier methodsFor: 'cashierTest' stamp: 'asdf 6/26/2017 00:08:51'!
test01CheckOutAnEmptyCartIsError

	| aCreditCard |
	
	aCreditCard:= CreditCard numberCard: 1231241 expiration:currentDate  andOwner: 'juan'. 
	self 
		should: [ aCashier checkOut: anEmptyCart payWith: aCreditCard]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: 'cart is empty'].! !

!TestCashier methodsFor: 'cashierTest' stamp: 'asdf 6/26/2017 00:09:29'!
test02CheckOutAcartWithExpireCard

	| aCreditCard |

	aCreditCard:= CreditCard numberCard: 1231241 expiration:aDate andOwner: 'juan'. 
	self should: [ aCashier checkOut: aCart payWith: aCreditCard.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'expired card']! !

!TestCashier methodsFor: 'cashierTest' stamp: 'asdf 6/26/2017 16:55:48'!
test03CheckOutAcartWithInsufficientCredit

	| aCreditCard |
	
	aMerchant answerExpected:[:amount :creditCard | self error:'insufficient credit'].
	aCreditCard:= CreditCard numberCard: 1231241 expiration:currentDate andOwner: 'juan'. 
	self should: [ aCashier checkOut: aCart payWith: aCreditCard.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'insufficient credit'.
										self assert: aCashier salesCashier size = 0.
							]! !

!TestCashier methodsFor: 'cashierTest' stamp: 'asdf 6/26/2017 16:56:22'!
test04CheckOutAcartWithStolenCard

	| aCreditCard |
	
	aMerchant answerExpected:[:amount :creditCard | self error:'stolen card'].
	aCreditCard:= CreditCard numberCard: 1231241 expiration:currentDate andOwner: 'juan'. 
	self should: [ aCashier checkOut: aCart payWith: aCreditCard.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'stolen card'.
										self assert: aCashier salesCashier size = 0
							]! !

!TestCashier methodsFor: 'cashierTest' stamp: 'asdf 6/26/2017 17:19:50'!
test05CheckOutAcartWithSuccesfulTransaction

	| aCreditCard number |

	number:= Random new	.
	aMerchant answerExpected:[:amount :creditCard | number].
	aCreditCard:= CreditCard numberCard: 1231241 expiration:currentDate andOwner: 'juan'. 
	aCashier checkOut: aCart payWith: aCreditCard.
	self should: [ aCashier checkOut: aCart payWith: aCreditCard.]
		raise: Error
		withExceptionDo: [:anError | self assert: (aCashier salesCashier includes:number).]! !


!TestCashier methodsFor: 'creditCardTest' stamp: 'asdf 6/25/2017 23:35:21'!
test01createAcardWithInvalidNumberCard

	| aDate |
	aDate:= GregorianMonth current previous ofYear: GregorianYear current.

	self should: [CreditCard numberCard: 'jose' expiration:aDate andOwner: 23123.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'invalid number card'].! !

!TestCashier methodsFor: 'creditCardTest' stamp: 'asdf 6/26/2017 00:09:55'!
test02createAcardWithInvalidOwnerCard

	self should: [ CreditCard numberCard: 1231241 expiration:aDate andOwner: 23123.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'invalid owner'].! !

!TestCashier methodsFor: 'creditCardTest' stamp: 'asdf 6/26/2017 00:10:00'!
test03createAcardWithInvalidDateCard

	self should: [CreditCard numberCard: 23454653919 expiration: Month current andOwner: 23123.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals:'invalid expiration card'].! !


!classDefinition: #ApiRest category: #Sistema!
Object subclass: #ApiRest
	instanceVariableNames: 'usersId catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!ApiRest methodsFor: 'initialize' stamp: 'asdf 6/27/2017 00:03:34'!
initilizeAnApiRest
	usersId:= Dictionary new
	! !

!ApiRest methodsFor: 'initialize' stamp: 'asdf 6/27/2017 02:24:37'!
initilizeAnApiRestWith: users
	usersId:= users.
	catalogue := Dictionary new
	
	! !

!ApiRest methodsFor: 'initialize' stamp: 'asdf 6/27/2017 02:23:48'!
initilizeAnApiRestWith: users catalogue: aCatalogue
	usersId:= users.
	catalogue:= aCatalogue
	! !


!ApiRest methodsFor: 'loginOperation' stamp: 'asdf 6/27/2017 13:31:27'!
loginUser: aUser withPass: aPass
	
	| newCartId aCart idCart |
	(usersId includesKey: aUser) ifFalse:[self error:'user is not registered'].
	((usersId at:aUser) at:1 = aPass) ifFalse:[self error:'password incorrect'].
	idCart:=(usersId at: aUser) at: 2.
	aCart:= Cart initCartWith: catalogue.
	" el id es fijo y solo cambio el carrito o creo un nuevo id con el mismo duenio?"
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRest class' category: #Sistema!
ApiRest class
	instanceVariableNames: ''!

!ApiRest class methodsFor: 'as yet unclassified' stamp: 'asdf 6/27/2017 00:14:30'!
initializeAnApiRest

	^ApiRest new initilizeAnApiRest ! !

!ApiRest class methodsFor: 'as yet unclassified' stamp: 'asdf 6/27/2017 00:18:09'!
initializeAnApiRestWith: users

	^ApiRest new initilizeAnApiRestWith: users. ! !

!ApiRest class methodsFor: 'as yet unclassified' stamp: 'asdf 6/27/2017 02:22:30'!
initializeAnApiRestWith: users catalogue: aCatalogue 

	^ApiRest new initilizeAnApiRestWith: users catalogue: aCatalogue . ! !


!classDefinition: #Cart category: #Sistema!
Object subclass: #Cart
	instanceVariableNames: 'products catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 20:06:41'!
= aCart

	^catalogue = aCart myCatalogue and:
	products = aCart myProducts.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 18:06:04'!
add: aNumber ofBook: aBook
	
	(aNumber < 0) ifTrue:[^ self error:'amount cant be negative'.].
	products add: aBook  withOccurrences: aNumber.					! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 18:22:05'!
addBook: aBook

	(catalogue includesKey: aBook) ifTrue:[self add:1 ofBook: aBook]
	ifFalse:[self error: 'Book is not valid'.].
	
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 19:46:17'!
initializeCartWith: aCatalogue

products := Bag new.
catalogue:= aCatalogue .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 19:20:07'!
isEmpty

	^products size = 0! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 20:02:57'!
myCatalogue

	^catalogue ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 20:02:44'!
myProducts

	^products ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 19:50:44'!
quantityOf: aBook.

	( products includes: aBook) ifTrue:[^ products occurrencesOf: aBook]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 20:00:14'!
size
	^products size.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 17:59:47'!
totalValue

	| total |
	total:=0.
	 products do:
		[:each |total:= total + self myCatalogue at: each. 
			Transcript show: (self myCatalogue  at: each).
		].
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #Sistema!
Cart class
	instanceVariableNames: 'elements'!

!Cart class methodsFor: 'as yet unclassified' stamp: 'asd 6/15/2017 19:23:29'!
initCartWith: aCatalogue

^Cart new initializeCartWith:aCatalogue.! !


!classDefinition: #Cashier category: #Sistema!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!Cashier methodsFor: 'operation' stamp: 'asdf 6/25/2017 20:50:51'!
calculateFinalPriceCart: aCart
	(aCart isEmpty) ifTrue:[self error:'cart is empty'].
	^aCart totalValue.! !

!Cashier methodsFor: 'operation' stamp: 'asdf 6/26/2017 17:13:36'!
checkOut: aCart payWith: aCreditCard
	| totalPrice paymentId infoSale |
	( aCreditCard expirationCard < (GregorianMonthOfYear current)) ifTrue:[self error:'expired card'].
	totalPrice:=self calculateFinalPriceCart: aCart.	
	paymentId:= merchantProcessor debit: totalPrice from: aCreditCard.
	infoSale:= #( aCart totalPrice).
"	infoSale add: aCart.
	infoSale add: totalPrice."
	salesBook at: paymentId put: infoSale.
	^paymentId.
	! !


!Cashier methodsFor: 'accessing' stamp: 'asdf 6/26/2017 15:01:59'!
initializeCashier: saleBook with: aMerchantProc
	
	salesBook:= saleBook.
	merchantProcessor := aMerchantProc 
	
	
! !

!Cashier methodsFor: 'accessing' stamp: 'asdf 6/26/2017 16:55:29'!
salesCashier

	^salesBook ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #Sistema!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'asdf 6/26/2017 15:03:50'!
initCashierWith: salesBook and: aMerchant

	^Cashier new initializeCashier: salesBook with: aMerchant .! !


!classDefinition: #CreditCard category: #Sistema!
Object subclass: #CreditCard
	instanceVariableNames: 'numberCard owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!CreditCard methodsFor: 'accessing' stamp: 'asdf 6/25/2017 21:41:27'!
expirationCard

^expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'asdf 6/25/2017 17:13:32'!
numberCard

^numberCard .! !

!CreditCard methodsFor: 'accessing' stamp: 'asdf 6/25/2017 17:12:59'!
ownerOfCard

^owner .! !


!CreditCard methodsFor: 'creation' stamp: 'asdf 6/25/2017 23:40:18'!
createWithNumber: aNumber anExpirationDate:aDate andOwner: anOwner
	"chequear los parametros?"
	(aNumber isKindOf: Integer) ifFalse:[self error:'invalid number card'].
	(aDate isKindOf: GregorianMonthOfYear) ifFalse:[self error:'invalid expiration card'].
	(anOwner isKindOf: String) ifFalse:[self error:'invalid owner'].
	numberCard := aNumber.	
	expirationDate:=aDate.
	owner:=anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #Sistema!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'asdf 6/25/2017 17:11:46'!
numberCard: aNumber expiration: aDate andOwner: aOwner

	^CreditCard new createWithNumber: aNumber anExpirationDate: aDate  andOwner: aOwner.! !


!classDefinition: #MerchantProcessor category: #Sistema!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'asdf 6/26/2017 15:03:08'!
debit: anAmount from: aCreditCard

	^self subclassResponsibility.! !


!classDefinition: #MpSimulator category: #Sistema!
MerchantProcessor subclass: #MpSimulator
	instanceVariableNames: 'blockValueExpected'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!MpSimulator methodsFor: 'as yet unclassified' stamp: 'asdf 6/26/2017 15:24:11'!
answerExpected: aBlock

	blockValueExpected:= aBlock.! !

!MpSimulator methodsFor: 'as yet unclassified' stamp: 'asdf 6/26/2017 15:19:29'!
debit: anAmount from: aCreditCard

	^blockValueExpected value: anAmount value:aCreditCard ! !
