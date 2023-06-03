stone management
destroyStoneStructureFor: stoneName
	| stoneSpec status |
	stoneSpec := self stoneNamed: stoneName.
	(stoneSpec waitStone: 1) = 0
		ifTrue: [ 
			| count |
			"if running, stop the stone"
			stoneSpec stopStone.
			count := 0.
			[ (status := stoneSpec waitStone: 1) ~= 3 ]
				whileTrue: [ 
					"ensure the stone has shut down, before destroying directory structure"
					count := count + 1.
					count > 2
						ifTrue: [ self error: 'Cannot stop stone' ].
					Delay waitForSeconds: 1 ] ].
	stoneSpec destroyStoneStructure.
	self stones removeKey: stoneName.
	self export