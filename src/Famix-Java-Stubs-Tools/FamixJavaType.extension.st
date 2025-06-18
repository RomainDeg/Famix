Extension { #name : #FamixJavaType }

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaType >> findSourceAnchorOfReferencingFile [

	"only case for now is static method from Class"
	^ nil
]

{ #category : #'*Famix-Java-Stubs-Tools' }
FamixJavaType >> nameUsedInImportString [

	^ self name
]
