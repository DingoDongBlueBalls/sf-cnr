/*
 * Irresistible Gaming (c) 2018
 * Developed by Lorenc
 * Module: server.pwn
 * Purpose: server related definitions
 */

/* ** Includes ** */
#include 							< YSI\y_hooks >

/* ** Definitions ** */
#define FILE_BUILD					"v11.45.130"

#define SERVER_NAME					"San Fierro Cops And Robbers (0.3.7)"
#define SERVER_MODE_TEXT 			"Cops And Robbers / DM / Gangs"
#define SERVER_MAP 					"San Fierro"
#define SERVER_LANGUAGE				"English"
#define SERVER_WEBSITE				"www.sfcnr.com"
#define SERVER_IP					"54.36.127.43:7777"
#define SERVER_TWITTER 				"IrresistibleDev"

/* ** Comment line to disable feature ** */
#define SERVER_RULES_URL            "files.sfcnr.com/en_rules.txt"							// used for /rules (cnr\features\server_rules.pwn)
#define SERVER_TWITTER_FEED_URL 	"files.sfcnr.com/cnr_twitter.php"						// used for /twitter (cnr\commands\cmd_twitter.pwn)
#define SERVER_HELP_API_URL			"sfcnr.com/api/player/help"								// used for /help (cnr\commands\cmd_help.pwn)
#define SERVER_CHANGES_FILE 		"updates.txt"											// used for /changes (cnr\commands\cmd_changes.pwn)
#define SERVER_PLS_DONATE_MP3		"http://files.sfcnr.com/game_sounds/pls_donate.mp3"		// used for advertising vip (cnr\features\vip\coin_market.pwn)
#define SERVER_MIGRATIONS_FOLDER  	"./gamemodes/irresistible/config/migrations/cnr/"		// used for migrations checking (config\migrations\_migrations.pwn)

/* ** Hooks ** */
hook OnScriptInit( )
{
	// set server query information
	SetGameModeText( SERVER_MODE_TEXT );
	SetServerRule( "hostname", SERVER_NAME );
	SetServerRule( "language", SERVER_LANGUAGE );
	SetServerRule( "mapname", SERVER_MAP );

	// simple gameplay rules
	UsePlayerPedAnims( );
	AllowInteriorWeapons( 0 );
	EnableStuntBonusForAll( 0 );
	DisableInteriorEnterExits( );

	// enable mysql debugging on debug mode
	#if defined DEBUG_MODE
	mysql_log( LOG_ERROR | LOG_WARNING );
	#endif

	// start map andreas (if enabled)
	#if defined MAP_ANDREAS_MODE_MINIMAL
	MapAndreas_Init( MAP_ANDREAS_MODE_MINIMAL );
	#endif
	return 1;
}

/* ** Functions ** */
stock IsPlayerLeadMaintainer( playerid )
{
	return GetPlayerAccountID( playerid ) == 1; // limits money, coin, xp spawning to this user
}

stock IsPlayerServerMaintainer( playerid )
{
	new
		account_id = GetPlayerAccountID( playerid );

	return IsPlayerLeadMaintainer( playerid ) || account_id == 277833 || account_id == 758617; // same as lead maintainer, just cant spawn money/xp/coins
}

stock IsPlayerUnderCover( playerid ) // StefiTV852, Shepard23, JamesComey
{
	new
		account_id = GetPlayerAccountID( playerid );

	return ( account_id == 917827 || account_id == 917829 || account_id == 921105 || account_id == 721420 ) && IsPlayerLoggedIn( playerid );
}
