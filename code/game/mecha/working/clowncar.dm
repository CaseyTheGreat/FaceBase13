/obj/mecha/working/clowncar
	desc = "The fastest and funniest form of transportation for the modern day clown (and friends)"
	name = "Clown Car"
	icon_state = "clowncar"
	step_in = 1
	max_temperature = 1000
	health = 200
	wreckage = /obj/effect/decal/mecha_wreckage/clowncar
	var/list/cargo = new
	var/cargo_capacity = 15
	var/max_occupants = 10
	var/locked = 0
	movesound = null
	turnsound = null

	move_inside()
		set category = "Object"
		set name = "Enter Vehicle"
		set src in oview(1)
		if(usr.stat != 0 || ( !istajaran(usr) && !ishuman(usr) ))
			return
		src.log_message("[usr] tries to move in.")
		if (src.occupant)
			if(!(src.locked))
				if(usr.client)
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.eye = src
					usr << "You climb into the passenger seat."
					usr.loc = src
			else
				src << "The doors are locked!"
				return

	/*
		if (usr.abiotic())
			usr << "\blue <B>Subject cannot have abiotic items on.</B>"
			return
	*/
		var/passed
		if(src.dna)
			if(usr.dna.unique_enzymes==src.dna)
				passed = 1
		else if(src.operation_allowed(usr))
			passed = 1
		if(!passed)
			usr << "\red Access denied"
			src.log_append_to_last("Permission denied.")
			return
		for(var/mob/living/carbon/metroid/M in range(1,usr))
			if(M.Victim == usr)
				usr << "You're too busy getting your life sucked out of you."
				return
	//	usr << "You start climbing into [src.name]"

		for (var/mob/V in viewers(src))
			if(V.client && !(V.blinded))
				if(src.locked)
					usr << "The doors are locked!"
					return
				else
					V.show_message("\blue [usr] starts to climb into [src.name]", 1)
		if(enter_after(40,usr))
			if(!src.occupant)
				moved_inside(usr)
			else if(src.occupant!=usr)
				if(!(src.locked))
					if(usr.client)
						usr.client.perspective = EYE_PERSPECTIVE
						usr.client.eye = src
						usr.loc = src.loc
						usr << "You climb into the passenger seat."
						usr << "[src.occupant] was faster. Try better next time, loser. You can still ride along."
				else
					usr << "The doors are locked!"
					return
		else
			usr << "You stop entering [src.name]."
		return


/obj/mecha/working/clowncar/moved_inside(var/mob/living/carbon/human/H as mob)
	if(H && H.client && H in range(1))
		H.reset_view(src)
		/*
		H.client.perspective = EYE_PERSPECTIVE
		H.client.eye = src
		*/
		H.pulling = null
		H.forceMove(src)
		src.occupant = H
		src.add_fingerprint(H)
		src.forceMove(src.loc)
		src.log_append_to_last("[H] moved in as driver.")
		src.icon_state = initial(icon_state)
		dir = dir_in
		playsound(src, 'fart.ogg', 50, 1)
		if(!hasInternalDamage())
			src.occupant << sound('bikehorn.ogg',volume=50)
		return 1
	else
		return 0


/obj/mecha/working/clowncar/relaymove(var/mob/user as mob, direction)
	if(!(user == src.occupant))
		if (src.locked)
			user << "The doors are locked!"
			return
		user.client.perspective = MOB_PERSPECTIVE
		user.client.eye = user.client.mob
	..()

/obj/mecha/working/clowncar/Bump(var/atom/obs)
	var/mob/M = obs
	if(ismob(M))
		if(istype(M,/mob/living/silicon/robot))
			src.visible_message("\red [src] bumps into [M]!")
		else
			src.visible_message("\red [src] knocks over [M]!")
			playsound(src, 'splat.ogg', 50, 1)
			M.pulling = null
			M.Stun(8)
			M.Weaken(5)
			M.lying = 1
	..()

/obj/mecha/working/clowncar/verb/togglelock()
	set category = "Vehicle Interface"
	set name = "Toggle door locks"
	set src = usr.loc
	if(!src.occupant) return
	if(usr!=src.occupant)
		return
	if (src.locked == 0)
		src.locked = 1
		for(var/mob/M in src.contents)
			M << "The doors are now locked"
		usr << "The doors are now locked"
	else if (src.locked == 1)
		src.locked = 0
		for(var/mob/M in src.contents)
			M << "The doors are now unlocked"
		usr << "The doors are now unlocked"

/obj/mecha/working/clowncar/verb/honk()
	set category = "Vehicle Interface"
	set name = "Honk horn"
	set src = usr.loc
	if(!src.occupant) return
	if(usr!=src.occupant)
		return
	playsound(src, 'bikehorn.ogg', 100, 1)


/obj/item/weapon/clownkeys
	name = "Clown Car keys"
	desc = "The coveted keys to the Clown Car. Keep out of hands of captain."
	icon = 'items.dmi'
	icon_state = "clownkeys"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT

