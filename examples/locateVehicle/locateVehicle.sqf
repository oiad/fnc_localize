/*
	locateVehicle by salival (https://github.com/oiad)
	
	* Supports multiple vehicles per key.
	* Used with clickActions to locate vehicles.
*/

if !(__FILE__ in stringTableIndex) then {
	stringTable = stringTable + [
		["en_no_veh_found","No vehicles found for %1."],
		["en_no_keys_found","No keys were found in your toolbelt or backpack."],
		["en_belongs_to","%1 belongs to %2%3."],
		["en_found_match","Found %1 matching vehicles, check your map for marked locations."],

		["ge_no_veh_found","Es wurden keine Fahrzeuge für %1 gefunden."],
		["ge_no_keys_found","Es würden keine Schlüssel am Gürtel oder im Rucksack gefunden."],
		["ge_belongs_to","%1 gehört zu %2%3."],
		["ge_found_match","Es wurde %1 passendes Fahrzeug gefunden! Überprüfe deine Karte für die markierte Position."]
	];

	stringTableIndex set [count stringTableIndex,__FILE__];
};

private ["_characterID","_found","_i","_keyID","_keyIDS","_keyList","_keyName","_keyNames","_marker","_name","_position","_vehicle"];

_keyList = call epoch_tempKeys;
_keyIDS = _keyList select 0;
_keyNames = _keyList select 1;

_i = 0;
for "_i" from 0 to 60 do {deleteMarkerLocal ("vehicleMarker"+ (str _i));};

if (count _keyIDS < 1) exitWith {systemChat ("no_keys_found" call fnc_localize)};

_i = 0;
{
	_keyID = parseNumber (_keyIDS select _forEachIndex);
	_keyName = _keyNames select _forEachIndex;
	_found = 0;
	{
		_vehicle = typeOf _x;
		_characterID = parseNumber (_x getVariable ["CharacterID","0"]);
		if ((_characterID == _keyID) && {_vehicle isKindOf "Air" || _vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Ship"}) then {
			_found = _found +1;
			_i = _i +1;
			_position = getPos _x;
			_name = getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName");
			_marker = createMarkerLocal ["vehicleMarker" + (str _i),[_position select 0,_position select 1]];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "DOT";
			_marker setMarkerColorLocal "ColorOrange";
			_marker setMarkerSizeLocal [1.0, 1.0];
			_marker setMarkerTextLocal format ["%1",_name];
			systemChat format [("belongs_to" call fnc_localize),_keyName,_name,if (!alive _x) then {format [" (%1)",toLower (localize "str_artdlg_destroyed")]} else {""}];
		};
	} forEach vehicles;
	if (_found == 0) then {systemChat format [("no_veh_found" call fnc_localize),_keyName]};
} forEach _keyIDS;

if (_i > 0) then {
	systemChat format [("found_match" call fnc_localize),_i];
};
