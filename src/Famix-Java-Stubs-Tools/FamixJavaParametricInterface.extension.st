Extension { #name : #FamixJavaParametricInterface }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaParametricInterface >> findSourceAnchorOfReferencingFile [

	self implementations ifNotEmpty: [
		self implementations
			detect: [ :impl | impl implementingClass sourceAnchor isNotNil ]
			ifFound: [ :impl | ^ impl implementingClass sourceAnchor ] ].

	^ nil
]

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaParametricInterface >> nameUsedInImportString [

	^ (self name indexOf: $<) = 0
		  ifTrue: [ self name ]
		  ifFalse: [ self name copyFrom: 1 to: (self name indexOf: $<) - 1 ]
]
