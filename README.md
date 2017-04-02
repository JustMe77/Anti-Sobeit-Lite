# Anti-Sobeit-Lite


Simple Filterscript to detect players connecting with Sobeit to your server!


It's very accurate but not 100% bulletproof, so you should rather report a player to the admin team instead to ban him automaticly!


**New Callback:**

```
public OnPlayerSobeitDetect(playerid)
{
	new str[144];
	format(str, sizeof(str), "{FF0000}Report: {%06x}%s {FFFFFF}is possibly using {FF0000}Sobeit", GetPlayerColor(playerid) >>> 8, GetName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}

```


**Media:**

[Watch Video](https://www.youtube.com/watch?v=0y24tHtHpUE&t=1s)
