/obj/item/weapon/implant/nanoaug
	name = "nanoaug"
	desc = "A nano-robotic biological augmentation implant."
	var/augmentation
	var/augment_text = "You feel strange..."
	var/activation_emote = "fart"
	var/phrasetriggered = 0
	var/cooldown_time = 0
	var/cooldown_timeleft = 0
	var/cooldown_on = 0
	get_data()
		var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Cybersun Industries Nano-Robotic Biological Augmentation Suite<BR>
<b>Life:</b> Infinite. WARNING: Biological chances are irreversable.<BR>
<b>Important Notes:</b> <font color='red'>Illegal</font>. Subjects exposed to nanorobotic agent are considered dangerous.<BR>
<HR>
<b>Implant Details:</b><BR>
<b>Function:</b> Implant contains colony of pre-programmed nanorobots. Subject will experience radical changes in their body, amplifying and improving certain bodily characteristics.<BR>
<b>Special Features:</b> Will grant subject superhuman powers.<BR>
<b>Integrity:</b> Nanoaugmentation is permanent. Once the process is complete, the nanorobots disassemble and are dissolved by the blood stream."}
		return dat


	implanted(mob/M as mob)
		if(!istype(M, /mob/living/carbon/human))	return
		var/mob/living/carbon/human/H = M
		H.augmentations.Add(augmentation) // give them the mutation
		H << "\blue [augment_text]"
		if(phrasetriggered == 1)
			activation_emote = pick("blink", "blink_r", "eyebrow", "chuckle", "twitch_s", "frown", "nod", "blush", "giggle", "grin", "groan", "shrug", "smile", "pale", "sniff", "whimper", "wink")
			H.mind.store_memory("Freedom nanoaugmentation can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate.", 0, 0)
			H << "The nanoaugmentation implant can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate."

		if(istype(src, /obj/item/weapon/implant/nanoaug/radar))
			H << "<font color='#FF0000'>Red</font color> blips on the map are Security."
			H << "White blips are civlians."
			H << "<font color='#3E710B'>Monochrome Green</font color> blips are cyborgs and AIs."
			H << "<font color='#238989'>Light blue</font color> blips are heads of staff."
			H << "<font color='#663366'>Purple</font color> blips are unidentified organisms."
			H << "Dead biologicals will not display on the radar."

			spawn()
				H.start_radar()
		return


/obj/item/weapon/implant/nanoaug/strength
	name = "Superhuman Strength"
	augmentation = SUPRSTR
	augment_text = "You muscle ache, and you feel a rapid surge of energy pulse through your body. You feel strong."

/obj/item/weapon/implant/nanoaug/radar
	name = "Short-range Psionic Radar"
	augmentation = RADAR
	augment_text = "You begin to sense the presence or lack of presence of others around you."

/obj/item/weapon/implant/nanoaug/electrichands
	name = "Electric Hands"
	augmentation = ELECTRICHANDS
	augment_text = "You feel a sudden jolt of electricity pulse through your veins. Arcs of electricity travel through your hands."

/obj/item/weapon/implant/nanoaug/eswordsynth
	name = "Energy Blade Synthesizer"
	augmentation = ESWORDSYNTH
	augment_text = "Your hands throb and pulsate. They feel sharper, and strangely hot."
	phrasetriggered = 1

	trigger(emote, source as mob)
		if(emote == activation_emote)
			src.activate(source)
		return

	activate(var/mob/source)

		var/obj/item/weapon/melee/energy/blade/swordspawn = new /obj/item/weapon/melee/energy/blade
		if(!source.get_active_hand())
			source.put_in_hand(swordspawn)

		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, source.loc)
		spark_system.start()
		playsound(source.loc, "sparks", 50, 1)
		..()

/obj/item/weapon/implant/nanoaug/rebreather
	name = "Bioelectric Rebreather"
	augmentation = REBREATHER
	augment_text = "You begin to lose your breath. Just as you are about to pass out, you suddenly lose the urge to breath. Breathing is no longer a necessity for you."

/obj/item/weapon/implant/nanoaug/dermalarmor
	name = "Skin-intergrated Dermal Armor"
	augmentation = DERMALARMOR
	augment_text = "The skin throughout your body grows tense and tight, and you become slightly stiff. Your bones and skin feel a lot stronger."

/obj/item/weapon/implant/nanoaug/reflexes
	name = "Combat Reflexes"
	augmentation = REFLEXES
	augment_text = "Your mind suddenly is able to identify threats before you are aware of them. You become more aware of your surroundings."

/obj/item/weapon/implant/nanoaug/nanoregen
	name = "Regenerative Nanobots"
	augmentation = NANOREGEN
	augment_text = "You feel a very faint vibration in your body. You instantly feel much younger."

/obj/item/weapon/implant/nanoaug/adhesivefeet
	name = "Adhesive Foot Soles"
	augmentation = NOSLIPFEET
	augment_text = "Your feet feel sticky to the touch."

/obj/item/weapon/implant/nanoaug/typhoon
	name = "Typhoon Module"
	augmentation = TYPHOON
	augment_text = "Strange growths appear in the flesh of your torso. You feel dangerous."
	phrasetriggered = 1

	trigger(emote, source as mob)
		if(emote == activation_emote)
			src.activate(source)
		return

	activate(var/mob/source)

		for(var/turf/simulated/T in view(source, 1))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, source.loc)
			spark_system.start()
			playsound(source.loc, "sparks", 50, 1)

		for(var/mob/living/carbon/M in view(source, 1))
			if (M != source)
				M.Stun(6)
				M.Weaken(6)
				M.take_organ_damage(10)
				M.pulling = null
			..()

/obj/item/weapon/implant/nanoaug/admin/megatyphoon
	name = "Admin Typhoon Module"
	augmentation = TYPHOON
	augment_text = "Strange growths appear in the flesh of your torso. You feel dangerous."
	phrasetriggered = 1

	trigger(emote, source as mob)
		if(emote == activation_emote)
			src.activate(source)
		return

	activate(var/mob/source)

		for(var/turf/simulated/T in view(source, 1))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, source.loc)
			spark_system.start()
			playsound(source.loc, "sparks", 50, 1)
				if(prob(50))
				explosion(T.loc, 0,0,1,1)

		for(var/mob/living/carbon/M in view(source, 1))
			if (M != source)
				M.gib()
			..()


/obj/item/weapon/implanter/nanoaug
	name = "Nanoaugmentation Implanter (Empty)"
	icon_state = "nanoimplant"

/obj/item/weapon/implanter/nanoaug/update()
	if (src.imp)
		src.icon_state = "nanoimplant"
	else
		src.icon_state = "nanoimplant0"
	return


/obj/item/weapon/implanter/nanoaug/strength
	name = "Nanoaugmentation Implanter (Superhuman Strength)"

/obj/item/weapon/implanter/nanoaug/strength/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/strength( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/radar
	name = "Nanoaugmentation Implanter (Short-range Psionic Radar)"

/obj/item/weapon/implanter/nanoaug/radar/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/radar( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/electrichands
	name = "Nanoaugmentation Implanter (Electric Hands)"

/obj/item/weapon/implanter/nanoaug/electrichands/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/electrichands( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/eswordsynth
	name = "Nanoaugmentation Implanter (Energy Blade Synthesizer)"

/obj/item/weapon/implanter/nanoaug/eswordsynth/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/eswordsynth( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/rebreather
	name = "Nanoaugmentation Implanter (Bioelectric Rebreather)"

/obj/item/weapon/implanter/nanoaug/rebreather/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/rebreather( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/dermalarmor
	name = "Nanoaugmentation Implanter (Skin-intergrated Dermal Armor)"

/obj/item/weapon/implanter/nanoaug/dermalarmor/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/dermalarmor( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/reflexes
	name = "Nanoaugmentation Implanter (Combat Reflexes)"

/obj/item/weapon/implanter/nanoaug/reflexes/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/reflexes( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/nanoregen
	name = "Nanoaugmentation Implanter (Regenerative Nanobots)"

/obj/item/weapon/implanter/nanoaug/nanoregen/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/nanoregen( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/adhesivefeet
	name = "Nanoaugmentation Implanter (Adhesive Foot Soles)"

/obj/item/weapon/implanter/nanoaug/adhesivefeet/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/adhesivefeet( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/typhoon
	name = "Nanoaugmentation Implanter (Typhoon Module)"

/obj/item/weapon/implanter/nanoaug/typhoon/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/typhoon( src )
	..()
	update()

/obj/item/weapon/implanter/nanoaug/admin/megatyphoon
	name = "Nanoaugmentation Implanter (Admin Typhoon Module)"

/obj/item/weapon/implanter/nanoaug/admin/megatyphoon/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/admin/megatyphoon( src )
	..()
	update()

///CLOWNING MODULES

/obj/item/weapon/implant/nanoaug/clowning/bananasynth
	name = "Banana Synthesizer"
	augmentation = BANANASYNTH
	augment_text = "Your hands throb and pulsate. They feel plump and yellow."
	phrasetriggered = 1

	trigger(emote, source as mob)
		if(emote == activation_emote)
			src.activate(source)
		return

	activate(var/mob/source)

		var/obj/item/weapon/bananapeel/bananaspawn = new /obj/item/weapon/bananapeel
		if(!source.get_active_hand())
			source.put_in_hand(bananaspawn)

		playsound(source.loc, "honk", 50, 1)
		..()

/obj/item/weapon/implanter/nanoaug/clowning/bananasynth
	name = "Clowning Nanoaugmentation Implanter (Banana Synthesizer)"

/obj/item/weapon/implanter/nanoaug/clowning/bananasynth/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/clowning/bananasynth( src )
	..()
	update()



/obj/item/weapon/implant/nanoaug/clowning/clownwalk
	name = "Clownwalk Module"
	augmentation = CLOWNWALK
	augment_text = "Your feet feel slippery and bulbous. They seem to be oozing a clear substance."

/obj/item/weapon/implanter/nanoaug/clowning/clownwalk
	name = "Clowning Nanoaugmentation Implanter (Clownwalk Module)"

/obj/item/weapon/implanter/nanoaug/clowning/clownwalk/New()
	src.imp = new /obj/item/weapon/implant/nanoaug/clowning/clownwalk( src )
	..()
	update()