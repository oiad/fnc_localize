if (isServer) then {
	diag_log "Loading custom server compiles";
};

if (!isDedicated) then {
	diag_log "Loading custom client compiles";

	call compile preprocessFileLineNumbers "scripts\fnc_localize.sqf";
};
