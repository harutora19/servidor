function loadQuerys()
	db.executeQuery("CREATE TABLE IF NOT EXISTS `player_balls` (`bim` int(11) NOT NULL,`playername` VARCHAR(255) NOT NULL, `pokename` VARCHAR(255) NOT NULL, `boost` int(11), `heldx` VARCHAR(255), `heldy` VARCHAR(255), `balltype` VARCHAR(255), `lastowner`  VARCHAR(255), `lastupdate` int(25))")
	db.executeQuery("CREATE TABLE IF NOT EXISTS `player_resets` (playerid int(11) NOT NULL, playername VARCHAR(255) NOT NULL, resets INT(11) NOT NULL)")
	db.executeQuery("CREATE TABLE IF NOT EXISTS `donations` (`id` int(11) NOT NULL, `account_name` VARCHAR(255) NOT NULL, `value` int(11) NOT NULL, `bonus` INT(11) NOT NULL, `status` VARCHAR(255) NOT NULL)")
	db.executeQuery("CREATE TABLE IF NOT EXISTS `xpback` (`exp` int(11) NOT NULL,`player_name` varchar(255) NOT NULL)")
end
