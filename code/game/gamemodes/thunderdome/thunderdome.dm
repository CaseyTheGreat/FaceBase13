/*
/datum/game_mode/thunderdome
	name = "thunderdome"
	config_tag = "thunderdome"
	votable = 0
	uplink_welcome = "Syndicate Uplink Console:"
	uplink_uses = 10
	var/redteam
	var/greenteam
	var/teamcap

/datum/game_mode/thunderdome/announce()
	world << "<B>The current game mode is - \red THUNDERDOME!</B>"
	world << "<B>\red NO CAPTAINS, NO CLOWNS. ONLY MEN.</B>"

/datum/game_mode/thunderdome/pre_setup()
	for(var/mob/M in world)
		//find out how many people are going to be on each team
		if(M.client)
			teamcap++

	return 1

/datum/game_mode/thunderdome/post_setup()
	for(var/mob/M in world)
		if(M.client)
			if(redteam<=(teamcap/2))
				M.loc = null
				M.equip_if_possible(new /obj/item/clothing/suit/armor/tdome/red(M), M.slot_w_uniform)
				M.equip_if_possible(new /obj/item/clothing/head/helmet/thunderdome(M), M.slot_head)
				redteam++
			else
				M.loc = null
				M.equip_if_possible(new /obj/item/clothing/suit/armor/tdome/green(M), M.slot_w_uniform)
				M.equip_if_possible(new /obj/item/clothing/head/helmet/thunderdome(M), M.slot_head)
				greenteam++
	return 1

/datum/game_mode/thunderdome/check_finished()
	return 0
*/