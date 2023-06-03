runtime
startNetldi: superDoitScriptOrNil withSuperDoitOptions: superDoitOptionsBoolean
	"if superDoitOptionsBoolean is true, then superDoitScriptOrNil is expected to respond to the following messages:
		debugLogging
		restart"

	| scriptPath stdout exitStatus commandLine output debugLogging restart |
	scriptPath := ''.
	restart := debugLogging := false.
	stdout := superDoitScriptOrNil
		ifNotNil: [ 
			scriptPath := superDoitScriptOrNil scriptPath.
			superDoitOptionsBoolean
				ifTrue: [ 
					debugLogging := superDoitScriptOrNil debugLogging.
					restart := superDoitScriptOrNil restart ].
			superDoitScriptOrNil stdout ]
		ifNil: [ GsFile stdout ].
	stdout
		lf;
		nextPutAll: '======  starting netldi at ' , DateAndTime now printString;
		lf.
	exitStatus := 0.
	self defineCustomEnvVars.
	commandLine := '$GEMSTONE/bin/startnetldi' asFileReference pathString.
	commandLine
		add: ' -g';
		add: ' -a ' , (System gemEnvironmentVariable: 'USER');
		add: ' -P ' , self stoneDirectorySpec netldiPort asString;
		add: ' -l ' , (self logsDir / 'netldi.log') pathString;
		yourself.
	debugLogging
		ifTrue: [ commandLine add: ' -d' ].
	restart
		ifTrue: [ commandLine add: ' -r' ].
	commandLine
		add: ' ' , self stoneName , '_ldi';
		yourself.
	GDKGsDevKit_stonesBase verbose
		ifTrue: [ 
			stdout
				lf;
				nextPutAll: commandLine;
				yourself ].
	[ output := GsHostProcess execute: commandLine ]
		on: ChildError
		do: [ :ex | 
			"exit status:
				0 on successful start
				1 if the specified netldi is already running
				2 if already running but the executable have been deleted
				3 or above, an error occurred and the specified netldi was not started"
			exitStatus := ex status ].
	exitStatus = 0
		ifTrue: [ stdout nextPutAll: output	"stdout" ]
		ifFalse: [ 
			(exitStatus = 1 or: [ exitStatus = 2 ])
				ifTrue: [ stdout nextPutAll: 'netldi is already running (' , exitStatus printString , ')' ]
				ifFalse: [ 
					exitStatus >= 3
						ifTrue: [ stdout nextPutAll: 'netldi failed to start (' , exitStatus printString , ')' ] ] ].
	stdout
		lf;
		nextPutAll: '****************************************';
		lf