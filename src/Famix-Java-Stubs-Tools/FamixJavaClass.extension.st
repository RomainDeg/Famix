Extension { #name : #FamixJavaClass }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaClass >> findSourceAnchorOfReferencingFile [

	self typedEntities ifNotEmpty: [
		self typedEntities
			detect: [ :e | e sourceAnchor isNotNil ]
			ifFound: [ :e | ^ e sourceAnchor ].
		self typedEntities
			detect: [ :e | e class = FamixJavaParametricMethod ]
			ifFound: [ :e | ^ e findSourceAnchorOfReferencingFile ] ].

	self incomingReferences ifNotEmpty: [
		self incomingReferences
			detect: [ :e | e referencer sourceAnchor isNotNil ]
			ifFound: [ :e | ^ e referencer sourceAnchor ] ].

	self methods ifNotEmpty: [
		self methods
			detect: [ :e | e findSourceAnchorOfReferencingFile isNotNil ]
			ifFound: [ :e | ^ e findSourceAnchorOfReferencingFile ] ].

	self subInheritances ifNotEmpty: [
		self subInheritances
			detect: [ :e | e subclass sourceAnchor isNotNil ]
			ifFound: [ :e | ^ e subclass sourceAnchor ] ].

	^ nil
]

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaClass >> resolveStubPackagesUsingTool: aResolverTool [

	self typeContainer isStub ifTrue: [ ^ self ]. "if my package is a stub, all clear" 
	
	^ aResolverTool detectImportForType: self.
]
