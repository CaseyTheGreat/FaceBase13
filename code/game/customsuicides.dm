/*
HEY YOU FUCKERS (casey, doop, whoever else might be viewing this)
ADD THESE PROCS TO SHIT YOU FEEL CAN BE USED FOR SUICIDE
SHARP FOR SHARP SHIT
BLUNT FOR BLUNT SHIT
NO YOU CAN NOT CUT YOUR THROAT WITH POOP
STICK IT IN A VERB OR SOMETHING I DUNNO
--DEADSNIPE
*/



/obj/item/weapon/proc/sharpsuicide(O as obj)
	if(usr:stat)
		return

	for(var/mob/living/carbon/human/H in viewers(usr))
		H << "<b>[usr] sticks the [O] to their throat.</b>"
		if(do_after(usr, 50))
			H << "<b>[usr]</b> slices their throat with the [O]! [pick("What a rotten way to die.", "What a shame.", "It's for the best.", "What an attention whore.", "You wish your lawn was like that.")]"
			usr:take_overall_damage(150, 0)
			usr:weakened = 5
			var/turf/T = src.loc
			for(var/i=0, i<3, i++)
				T = get_step(T, src.dir)
				new /obj/effect/decal/cleanable/blood(T)
		else
			H << "<b>[usr]</b> wimps out."








/obj/item/weapon/proc/bluntsuicide(O as obj)
	if(usr:stat)
		return

	for(var/mob/living/carbon/human/H in viewers(usr))
		H << "<b>[usr] prepares to beat themselves with the [O]!"
		if(do_after(usr, 50))
			H << "<b>[usr]</b> beats their cranium to a pulp with the [O]! [pick("What a rotten way to die.", "What a shame.", "It's for the best.")]"
			usr:take_overall_damage(150, 0)
			usr:weakened = 5
			new /obj/effect/decal/cleanable/blood(usr)
		else
			H << "<b>[usr]</b> wimps out."
