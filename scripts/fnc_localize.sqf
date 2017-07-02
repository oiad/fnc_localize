/*
	fnc_localize by salival (https://github.com/oiad)

	To return a localized string from the modular stringTable array.

	Sample stringTable array based from the "str_wf2_gl_locations" localization:	

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

	stringTable with variable types in it:

	if !(__FILE__ in stringTableIndex) then {
		stringTable = stringTable + [
			["en_test","Your player name is: %1"], // You can pass arguments from the original fnc_localize call.
			["en_drop",format ["STR_ACTIONS_DROP localization: %1",localize "STR_ACTIONS_DROP"]] // You can use format or most other calls here as well.
		];

		stringTableIndex set [count stringTableIndex,__FILE__];
	};

	Example script usage:

	systemChat ("drop" call fnc_localize);
	systemChat (format [("test" call fnc_localize),dayz_playerName]);

	("test" call fnc_localize) call dayz_rollingMessages;
	systemChat ("test" call fnc_localize);
	hint ("locations" call fnc_localize);
*/

if (isNil "stringTable") then {stringTable = [];stringTableIndex = [];};

fnc_localize = {
	private ["_foundString","_langString","_locale","_localization"];

	_localization = localize "str_wf2_gl_locations";

	_locale = switch (_localization) do {
		case "Stellen": {"ge"}; // German
		case "Locations": {"en"}; // English
		case "Località": {"it"}; // Italian
		case "Ubicaciones": {"sp"}; // Spanish
		case "Endroits": {"fr"}; // French
		case "Místa": {"cz"}; // Czech
		case "Локации": {"ru"}; // Russian
		case "Lokacje": {"pl"}; // Polish
		case "Helyek": {"hu"}; // Hungarian
		default {"en"};
	};

	if (isNil "stringTable") exitWith {diag_log "fnc_localize: stringTable array was not found."};
	if (isNil "_this") exitWith {diag_log "fnc_localize: function was called with no arguments.";};

	_langString = format ["%1_%2",_locale,_this];
	_foundString = false;

	{
		if (_x select 0 == _langString) exitWith {
			_foundString = true;
			_localization = _x select 1;
		};
	} count stringTable;

	if (!_foundString) exitWith {diag_log format ["fnc_localize: Error, localization ""%1"" not found.",_langString];};

	_localization
};