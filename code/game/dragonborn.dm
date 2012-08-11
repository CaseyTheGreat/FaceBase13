/client/proc/unrelentingforce()
	set category = "Shouts"
	set name = "Unrelenting Force"
	set desc = "FUS RO DA etc etc"
	var/turf/T = src.loc

	if(usr.stat)
		src << "Not when you are incapacitated."
		return

	usr.verbs -= /client/proc/unrelentingforce
	spawn(300)
		usr.verbs += /client/proc/unrelentingforce


	usr.say("FUS RO DA")
	for(var/i=0, i<5, i++)
		T = get_step(T, src.dir)
		for(var/mob/living/carbon/human/H in T)
			step_away(H, usr)
			H.weakened = 5
			H << "\red You're going to feel that one in the morning!"
			if(prob(50))
				take_overall_damage(10,0)
		for(var/obj/item/I in T)
			step_away(I, usr) // even the item gets in trouble

/client/proc/aurawhisper
	set category = "Shouts"
	set name = "Aura Whisper"
	set desc = "Thermals in shout form."

	if(usr.stat)
		src << "Not when you are incapacitated."
		return

	usr.verbs -= /client/proc/aurawhisper
	spawn(600)
		usr.verbs += /client/proc/aurawhisper

	usr.whisper("LAAS YAH NIR")
/*	usr.sight |= SEE_MOBS
	usr.sight |= SEE_OBJS
	spawn(300)
		usr.sight &= ~SEE_TURFS
		usr.sight &= ~SEE_OBJS
		usr.sight &= ~SEE_MOBS
		*/

/client/proc/shoutdisarm
	set category = "Shouts"
	set name = "Disarm"
	set desc = "Shout the weapons of your enemies away."

	if(usr.stat)
		src << "Not when you are incapacitated."
		return

	usr.say ("ZUN HAAL VIIK")
	usr.verbs -= /client/proc/shoutdisarm
	spawn(150)
		usr.verbs += /client/proc/shoutdisarm


		for(var/mob/living/carbon/H in hearers(usr))
			H.stunned = 1 // what it gets the job done
		for(var/obj/item/weapon/G in viewers(usr))
			for(var/dongs=0, dongs<3, dongs++)
				step_away(G, usr)