/datum/game_mode/thunderdome
	name = "thunderdome"
	config_tag = "thunderdome"
	votable = 1
	uplink_welcome = "Syndicate Uplink Console:"
	uplink_uses = 10
	var/fightsize = 5
	var/redteam
	var/greenteam
	var/teamcap

/datum/game_mode/thunderdome/announce()
	world << "<font size = 3><B>The current game mode is - \red THUNDERDOME!</B></font>"
	world << "<font size = 3><B>\red NO CAPTAINS, NO CLOWNS. ONLY MEN.</B></font>"

/datum/game_mode/thunderdome/pre_setup()
	for(var/mob/M in world)
		//find out how many people are going to be on each team excluding admins
		if(M.client)
			if(!(M.client.holder))
				teamcap++

	return 1

//if you're an admin, you go to the admin box. the teams are then filled based on how many people are in the game
//up to the maximum fight size, and the runoff is sent to the observation room.s
/datum/game_mode/thunderdome/post_setup()
	for(var/mob/M in world)
		if(M.client)
			if(M.client.holder)
				M.loc = pick(tdomeadmin)
			if(redteam<=(teamcap/2))
				if(redteam<=fightsize)
					M.loc = pick(tdome1)
					strip_mob(M)
					redteam++
				else
					M.loc = pick(tdomeobserve)
			else
				if(greenteam<=fightsize)
					M.loc = pick(tdome2)
					strip_mob(M)
					greenteam++
				else
					M.loc = pick(tdomeobserve)
	return 1

/datum/game_mode/thunderdome/check_finished()
	return 0

/////////////////////////////////////////////
// THUNDERDOME HELPER PROCS
/////////////////////////////////////////////


/datum/game_mode/thunderdome/proc/strip_mob(var/mob/M as mob)
	for(var/obj/item/W in M)
		if(istype(W, /datum/organ/external))
			continue
		M.u_equip(W)
		if (M.client)
			M.client.screen -= W
		if (W)
			W.loc = M.loc
			W.dropped(M)
			W.layer = initial(W.layer)
			del(W)