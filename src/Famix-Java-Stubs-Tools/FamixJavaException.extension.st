Extension { #name : #FamixJavaException }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaException >> findSourceAnchorOfReferencingFile [

	self declaringEntities ifNotEmpty: [
		self declaringEntities
			detect: [ :de | de sourceAnchor isNotNil ]
			ifFound: [ :de | ^ de sourceAnchor ] ].

	1 halt.

	^ nil
]
