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
	var/max_occupants
	movesound = null
	turnsound = null

	move_inside()
		set category = "Object"
		set name = "Enter Exosuit"
		set src in oview(1)
		if(usr.stat != 0 || ( !istajaran(usr) && !ishuman(usr) ))
			return
		src.log_message("[usr] tries to move in.")
		if (src.occupant)
			usr << "You climb into the passenger seat."
			src.contents.Add(usr)
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
				V.show_message("\blue [usr] starts to climb into [src.name]", 1)

		if(enter_after(40,usr))
			if(!src.occupant)
				moved_inside(usr)
			else if(src.occupant!=usr)
				usr << "[src.occupant] was faster. Try better next time, loser."
		else
			usr << "You stop entering the exosuit."
		return