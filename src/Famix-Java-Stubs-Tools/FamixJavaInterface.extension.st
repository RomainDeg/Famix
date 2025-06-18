Extension { #name : #FamixJavaInterface }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaInterface >> findSourceAnchorOfReferencingFile [

	self implementations ifNotEmpty: [
		self implementations
			detect: [ :impl | impl implementingClass sourceAnchor isNotNil ]
			ifFound: [ :impl | ^ impl implementingClass sourceAnchor ] ].

	^ nil
]
