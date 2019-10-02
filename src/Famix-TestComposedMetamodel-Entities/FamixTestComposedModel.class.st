Class {
	#name : #FamixTestComposedModel,
	#superclass : #MooseModel,
	#category : #'Famix-TestComposedMetamodel-Entities'
}

{ #category : #accessing }
FamixTestComposedModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' 'Famix-TestComposedSubmetamodel2-Entities' 'Famix-TestComposedSubmetamodel1-Entities')
]

{ #category : #meta }
FamixTestComposedModel class >> annotation [
	<MSEClass: #FamixTestComposedModel super: #MooseModel>
	<package: #'Famix-TestComposedMetamodel-Entities'>
	<generated>
]