!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'adfas 5/5/2017 21:35:40'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty.! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lonj Top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:18:12'!
initialize

	lonj :=0.
	Top := StackBase new! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:18:06'!
isEmpty
	
	^Top Empty! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 11:17:16'!
new

	^ self initialize ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:39:00'!
pop

	|poppedObj|
	poppedObj := Top Content.
	Top := Top Previous.
	lonj := lonj - 1.
	^poppedObj! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:20:07'!
push: anObjet

	|obj|
	
	obj := PushedObj new.
	obj initializeWith: anObjet atTop: Top.
	Top := obj.
	lonj := lonj+1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:43:15'!
size

	^lonj! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:17:54'!
top

	^Top Content
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackedObj category: #'Stack-Exercise'!
Object subclass: #StackedObj
	instanceVariableNames: 'Content Previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 10:23:40'!
Content
	
	^self subclassResponsibility 
! !

!StackedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 11:01:07'!
Empty

	^self subclassResponsibility ! !

!StackedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 10:24:39'!
Previous
	
	^self subclassResponsibility ! !


!classDefinition: #PushedObj category: #'Stack-Exercise'!
StackedObj subclass: #PushedObj
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PushedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 10:39:36'!
Content
	
	^Content! !

!PushedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 10:59:13'!
Empty

	^false! !

!PushedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 10:40:07'!
Previous

	^Previous! !

!PushedObj methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:04:29'!
initializeWith: anObjet atTop: top 

	Content := anObjet.
	Previous := top! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
StackedObj subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:57:15'!
Content

	self error: self stackEmptyErrorDescription   "???"! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 11:00:17'!
Empty

	^true! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 21:57:24'!
Previous

	self error: self stackEmptyErrorDescription   "???"! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'adfas 5/5/2017 22:05:40'!
stackEmptyErrorDescription

	^'Stack is empty'! !
