/obj/item/weapon/chaosball/ // http://www.youtube.com/watch?v=c4ImhVczZ_g
	name = "basketball"
	desc = "As used by Charles Barkley."
	icon = 'items.dmi'
	icon_state = "basketball"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 15
	w_class = 2.0
	m_amt = 5000
	var/dunking = 0


	verb/chaos_dunk()
		set src in usr
		set name = "CHAAOOOS DUUUUNNNK"
		set desc = "NEGATIVE B BALL PROTONS"
		usr.verbs -= /obj/item/weapon/chaosball/verb/chaos_dunk
		world << sound('chaosdunk.ogg')
		usr.say("You killed my family and my friends. But there is still time for one final chaos dunk...")
		spawn(250)
			usr:invisibility = 105
			usr:canmove = 0
			usr.visible_message("\red [usr] dives up into the air!")
			world << "<B>\red !NEO CASEY STATION 13 CHAOS DUNK ADVISORY WARNING!</B>"
			spawn(50)
				world << "<B>\red A MEASURED 19.7 MEGAJOULE OF NEGATIVE BBALL PROTONS HAVE BEEN DETECTED.</B>"
				spawn(10)
					world << "<font size=6><B> \red A CHAOS DUNK IS IMMINENT. FIND COVER. THIS IS NOT A DRILL.</B></font>"
					spawn(220)
						usr.visible_message("\red [usr] comes crashing down at an amazing speed!")
						usr.invisibility = 0
						explosion(usr.loc, 6, 7, 9, 5)
						usr.canmove = 1 //sanity check just in case the ghost fucks up or something i dunno

						//CASEY: made the explosion slightly smaller so it'll leave some damaged tiles

/obj/item/weapon/chaosball/charged // http://www.youtube.com/watch?v=c4ImhVczZ_g
	name = "negative b-ball proton charged basketball"
	desc = "As used by Charles Barkley."
	icon = 'items.dmi'
	icon_state = "basketball"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 15
	w_class = 2.0
	m_amt = 5000


	verb/chaos_dunk_charged()
		set src in usr
		set name = "ULTRA CHAAOOOS DUUUUNNNK"
		set desc = "NEGATIVE B BALL PROTONS"
		usr.verbs -= /obj/item/weapon/chaosball/charged/verb/chaos_dunk_charged
		world << sound('chaosdunk.ogg')
		usr.say("You killed my family and my friends. But there is still time for one final chaos dunk...")
		spawn(250)
			usr:invisibility = 105
			usr:canmove = 0
			usr.visible_message("\red [usr] dives up into the air!")
			world << "<B>\red !NEO CASEY STATION 13 CHAOS DUNK ADVISORY WARNING!</B>"
			spawn(50)
				world << "<B>\red A MEASURED 19.7 MEGAJOULE OF NEGATIVE BBALL PROTONS HAVE BEEN DETECTED.</B>"
				spawn(10)
					world << "<font size=6><B> \red A CHAOS DUNK IS IMMINENT. FIND COVER. THIS IS NOT A DRILL.</B></font>"
					spawn(220)
						usr.visible_message("\red [usr] comes crashing down at an amazing speed!")
						usr.invisibility = 0
						explosion(usr.loc, 6, 7, 9, 5)
						new /obj/machinery/singularity/chaosdunk(src.loc)
						usr.canmove = 1