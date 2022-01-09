VWatch is a FFXI Windower Addon created by Garyfromwork to help automate the tedious task of trading Phase Displacers and Cells.
You will not be able to use this addon to "beat" others to claim a VNM due to the various delays I've put in place to handle window timers in game.
You "could" try modifying the timers to suit your taste but what is in place works for me so I've kept them that way.

REQUIREMENTS:
	This addon needs Enternity and SetTarget addons to be installed.
	When VWatch is loaded it will automatically attempt to load the required addons, but you do need to have them in your Addons folder in Windower to work.

COMMANDS:
	//watch target
	-- This is used to get your current VNM's ID, if you're not fighting Uptala then you'll need to pop the VNM regulary and then target the VNM and use the above command.
	-- This will set the VNMs ID to a local variable and won't be needed again unless reloading the addon or fighting a different VNM.

	//watch setrift
	-- This is used to get the ID of the Planar Rift for the VNM you're targetting. Simply target the planar rift and run the command above. This will set the ID to a local variable and
	-- Won't be needed again unless reloading the addon or changing VNMs.

	//watch rift
	-- This is used to kickoff the addon. This will attempt to automatically target the Planar Rift based on the ID from the SETRIFT command mentioned above.
	-- After acquiring the Planar Rift it will then automatically trade up to 5 Phase Displacers and 1 Red Cell and Blue Cell (I forget the names).
	-- Then the addon will navigate the various menus to pop the VNM and utilize the void clusters created by the Phase Displacers.
	-- The VNM will then spawn and the addon will automatically target and follow the VNM based on the TARGET command mentioned earlier.
	-- Once the fight ends, you'll need to manually open and loot the chest and rerun the //watch rift command once the Planar Rift is up again.

CAUTION: 
	The program utilizers a timer that works for my character in game. This may not work correctly for you and would need to have the values adjusted to better fit your character.

QUESTIONS / ISSUES / SUGGESTIONS:
	You can contact me at ordientertainment@gmail.com
	I'm interested in any addon ideas the FFXI players may have. However, I cannot make every idea into an addon.