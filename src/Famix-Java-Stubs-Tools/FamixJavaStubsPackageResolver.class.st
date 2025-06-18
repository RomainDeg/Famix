Class {
	#name : #FamixJavaStubsPackageResolver,
	#superclass : #Object,
	#instVars : [
		'model',
		'stubs',
		'unresolvedStubs'
	],
	#category : #'Famix-Java-Stubs-Tools'
}

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> createPackageNameListFrom: aString [
"returns a list of package names, from the deepest to the shallowest, representing the actual packages of a stub"
	| packageNameList |
	packageNameList := aString splitOn: '.'.
	packageNameList removeLast. "removing the class name"
	packageNameList
		at: 1
		put: (packageNameList first splitOn: ' ') second trim. "removing 'import '"
	^ packageNameList
]

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> createStubPackagesFromImport: aString andAssignClass: aFamixJavaClass [ 

	| package |
	package := self findOrCreatePackagesFromString: aString.
	aFamixJavaClass typeContainer: package.
	
]

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> detectImportForType: aFamixJavaType [
"tries to find the import string of a stub within a source file referencing it"
	| sourceAnchor importStrings className |
	sourceAnchor := aFamixJavaType findSourceAnchorOfReferencingFile.
	
	sourceAnchor ifNil: [ ^ nil ]. "no source anchor, unresolvable stub"
	
	importStrings := self parseToFetchImportStrings: sourceAnchor completeText.
	className := aFamixJavaType nameUsedInImportString.
	importStrings := self findImportStringForClassNamed: className among: importStrings.
	
	1haltIf: [ importStrings size > 1 ].
	importStrings ifEmpty: [ 1halt. ^ nil ]. "no import string matching the class, unresolvable stub"
	
	self createStubPackagesFromImport: importStrings first andAssignClass: aFamixJavaType 
]

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> fetchAllStubs [

	stubs := model select: [ :e |
		         ((FamixJavaType withAllSubclasses reject: [ :f |
			           f = FamixJavaPrimitiveType ]) includes: e class)
			         and: [ e isStub ] ]
]

{ #category : #parsing }
FamixJavaStubsPackageResolver >> findImportStringForClassNamed: aString among: importStrings [

	^ importStrings select: [ :s |
		  s includesSubstring: (String streamContents: [ :str |
				   str
					   nextPut: $.;
					   nextPutAll: aString;
					   nextPut: $; ]) ]
]

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> findOrCreatePackagesFromString: aString [
"returns the shallowest package of an import string (with parent packages also from this import string) representing a stub import"
	| packageNameList currentPackage |
	packageNameList := self createPackageNameListFrom: aString.
	
	currentPackage := self lookForRootPackageNamed: packageNameList first.
	currentPackage ifNil: [
		currentPackage := model newPackageNamed: packageNameList first.
		currentPackage isStub: true ].
	
	packageNameList removeFirst.
	packageNameList do: [ :name |
		currentPackage childEntities
			detect: [ :p | p name = name ]
			ifFound: [ :p | currentPackage := p ]
			ifNone: [
				| newPackage |
				newPackage := model newPackageNamed: name.
				newPackage
					parentPackage: currentPackage;
					isStub: true.
				currentPackage := newPackage ] ].
	^ currentPackage
]

{ #category : #initialization }
FamixJavaStubsPackageResolver >> initialize [ 

	unresolvedStubs := OrderedCollection new
]

{ #category : #'as yet unclassified' }
FamixJavaStubsPackageResolver >> lookForRootPackageNamed: packageName [

	^ model rootEntities
		  detect: [ :e |
		  e class = FamixJavaPackage and: [ e name = packageName ] ]
		  ifFound: [ :e | e ]
		  ifNone: [ nil ]
]

{ #category : #accessing }
FamixJavaStubsPackageResolver >> model [

	^ model
]

{ #category : #accessing }
FamixJavaStubsPackageResolver >> model: anObject [

	model := anObject
]

{ #category : #parsing }
FamixJavaStubsPackageResolver >> parseToFetchImportStrings: aString [

	^ aString lines select: [ :line | line trimLeft beginsWith: 'import' ]
]

{ #category : #navigating }
FamixJavaStubsPackageResolver >> resolve [

	self fetchAllStubs.
	self resolveAllStubs.
]

{ #category : #navigating }
FamixJavaStubsPackageResolver >> resolveAllStubs [

	stubs do: [ :stub |
		(stub typeContainer isNotNil and: [ stub typeContainer isStub ])
			ifFalse: [ "if my package is a stub, nothing to do"
				(self detectImportForType: stub) ifNil: [
					unresolvedStubs add: stub ] ] ]
]

{ #category : #accessing }
FamixJavaStubsPackageResolver >> resolvedStubs [

	^ stubs reject: [ :s | unresolvedStubs includes: s ]
]

{ #category : #accessing }
FamixJavaStubsPackageResolver >> unresolvedStubs [

	^ unresolvedStubs
]
