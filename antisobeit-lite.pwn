#include <a_samp>

/*

@ Titel: Antisobeit Lite
@ Author: JustMe.77
@ Version: 1.0.0
@ Download: https://github.com/JustMe77/Anti-Sobeit-Lite

*/

static sVehicle[MAX_PLAYERS],
sTimer[MAX_PLAYERS],
bool:sCheckMade[MAX_PLAYERS];

#define Version "1.0.0"

// Custom Callbacks

forward OnPlayerSobeitDetect(playerid);
public OnPlayerSobeitDetect(playerid)
{
	new str[144];
	format(str, sizeof(str), "{FF0000}Report: {%06x}%s {FFFFFF}wird verdächtigt {FF0000}Sobeit{FFFFFF} zu verwenden.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}

forward WeaponCheck(playerid);
public WeaponCheck(playerid)
{
	new weaponid, ammo;
	GetPlayerWeaponData(playerid, 1, weaponid, ammo);
	if(weaponid == WEAPON_GOLFCLUB)
	{
		RemovePlayerWeapon(playerid, 2);
	    CallLocalFunction("OnPlayerSobeitDetect", "i", playerid);
	}
	KillTimer(sTimer[playerid]);
}

forward SobeitCheck(playerid);
public SobeitCheck(playerid)
{
	//Remove Golf Weapon
	RemovePlayerWeapon(playerid, 2);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	sVehicle[playerid] = CreateVehicle(457, x, y, z, 0, -1, -1, -1, 0);
	PutPlayerInVehicle(playerid, sVehicle[playerid], 0);
	sTimer[playerid] = SetTimerEx("WeaponCheck", 1000, false, "i", playerid);
	DestroyVehicle(sVehicle[playerid]);
	sCheckMade[playerid] = true;
}

// Default Callbacks

public OnFilterScriptInit()
{
	print(" ");
    print(" ===============================");
    print(" ");
    print("      AntiSobeit Lite loaded.");
    print(" ");
    printf("      Version:  %s", Version);
    print(" ");
    print("      (c) 2017 JustMe.77");
    print(" ");
    print(" ===============================");
	return 1;
}

public OnFilterScriptExit()
{
	print(" ");
    print(" ===============================");
    print(" ");
    print("   AntiSobeit Lite unloaded.");
    print(" ");
    print(" ===============================");
    print(" ");
	return 1;
}

public OnPlayerConnect(playerid)
{
	sCheckMade[playerid] = false;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//Safe is safe..
	KillTimer(sTimer[playerid]);
	DestroyVehicle(sVehicle[playerid]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(sCheckMade[playerid] == false)
	{
		SetTimerEx("SobeitCheck", 1000, false, "i", playerid);
	}
	return 1;
}


// Useful Functions w/ Stock keyword

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    return name;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);
		
		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}
	
	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}
