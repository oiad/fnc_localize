# [EPOCH 1.0.6.1] fnc_localize
modular localization script by salival (https://github.com/oiad)

* Discussion URL: 

* Tested as working on a blank Epoch 1.0.6.1 server.
* Modular so mod makers can use it without supplying a stringTable.xml and confusing the hell out of everyone.

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

# Install:

* This install basically assumes you have NO custom compiles.sqf, I would recommend diffmerging where possible.

**[>> Download <<](https://github.com/oiad/fnc_localize/archive/master.zip)**

# Mission folder install:

1. In mission\init.sqf find: <code>call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";</code> and add directly below:

	```sqf
	call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf";
	```

2. copy scripts\fnc_localize.sqf from the downloaded repo files to your mission\scripts folder.

#. Examples of use for mod makers:

	To return a localized string from the modular stringTable array.

	Sample stringTable array based from the "str_wf2_gl_locations" localization:	

```sqf
	if !(__FILE__ in stringTableIndex) then {
		stringTable = stringTable + [
			["en_locations","locations"], //English
			["ge_locations","Stellen"], // German
			["it_locations","Località"], // Italian
			["sp_locations","Ubicaciones"], // Spanish
			["fr_locations","Endroits"], // French
			["cz_locations","Místa"], // Czech
			["ru_locations","Локации"], // Russian
			["pl_locations","Lokacje"], // Polish
			["hu_locations","Helyek"] // Hungarian
		];

		stringTableIndex set [count stringTableIndex,__FILE__];
};
```

	stringTable with variable types in it:

```sqf
	if !(__FILE__ in stringTableIndex) then {
		stringTable = stringTable + [
			["en_test","Your player name is: %1"], // You can pass arguments from the original fnc_localize call.
			["en_drop",format ["STR_ACTIONS_DROP localization: %1",localize "STR_ACTIONS_DROP"]] // You can use format or most other calls here as well.
		];

		stringTableIndex set [count stringTableIndex,__FILE__];
	};
```

	Example script usage:

```sqf
	systemChat ("drop" call fnc_localize);
	systemChat (format [("test" call fnc_localize),dayz_playerName]);

	("test" call fnc_localize) call dayz_rollingMessages;
	systemChat ("test" call fnc_localize);
	hint ("locations" call fnc_localize);
```