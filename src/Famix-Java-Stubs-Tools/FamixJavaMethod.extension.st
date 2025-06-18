Extension { #name : #FamixJavaMethod }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaMethod >> findSourceAnchorOfReferencingFile [

	self incomingInvocations ifNotNil: [
		self incomingInvocations
			detect: [ :e | e sourceAnchor isNotNil ]
			ifFound: [ :e | ^ e sourceAnchor ].
		self incomingInvocations
			detect: [ :e | e sender sourceAnchor isNotNil ]
			ifFound: [ :e | ^ e sender sourceAnchor ] ].

	1 halt.

	^ nil
]
