Extension { #name : #FamixJavaAnnotationType }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaAnnotationType >> findSourceAnchorOfReferencingFile [

	self instances ifNotEmpty: [
		self instances
			detect: [ :i | i annotatedEntity sourceAnchor isNotNil ]
			ifFound: [ :i | ^ i annotatedEntity sourceAnchor ] ].

	^ nil
]

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaAnnotationType >> nameUsedInImportString [

	^ (self name indexOf: $@ = 0)
		  ifTrue: [ self name allButFirst ]
		  ifFalse: [ self name ]
]
