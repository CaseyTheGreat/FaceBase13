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
	for(var/mob/living/carbon/human/H in viewers(usr))
		H << "<b>[usr] sticks the [O] to their throat.</b>"
		if(do_after(usr, 50))
			H << "<b>[usr] slices their throat with the [O]! [pick("What a rotten way to die.", "What a shame.", "It's for the best.")]"
			usr:bruteloss = 150
			usr:weakened = 5

/obj/item/weapon/proc/bluntsuicide(O as obj)
	for(var/mob/living/carbon/human/H in viewers(usr))
		H << "<b>[usr] prepares to beat themselves with the [O]!"
		if(do_after(usr, 50))
			H << "<b>[usr] beats their cranium to a pulp with the [O]! [pick("What a rotten way to die.", "What a shame.", "It's for the best.")]"
			usr:bruteloss = 150
			usr:weakened = 5
