var skipsetup = false;
if((self.getvar("illegalactuator") + 1 == "SimpleActuator1") || (target.getvar("illegalactuator") + 1 == "SimpleActuator1")) skipsetup = true;
if(skipsetup) trace("skipping setup");
	else {
	trace("starting description actuator");
	var tw = new motion.actuators.SimpleActuator(null,1/15,null);
	tw._repeat = -1;
	var s = new elements.Skill("Against all odds_old");

	s.script = "if(self.hp <= 0 || self.graphic == null || target == null || target.graphic == null || target.hp <= 0) {
		self.getvar(\"illegalactuator\").stop();    
		self.resetvar(\"illegalactuator\"); 
	}
	if (self.dicepool.length > 0) {
		for (mydice in self.dicepool) {
			if (mydice.available() && !mydice.blind) {
				if ((mydice.basevalue >= 7 || mydice.basevalue <= 0)) {
					var sprite = 0;
					if((mydice.basevalue < 1 && mydice.basevalue > -7) || (mydice.basevalue < 17 && mydice.basevalue > 6))
					{
						sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice\" + mydice.basevalue,0,0);
                    }
					if(mydice.basevalue > 16)
					{
                    sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dicehigh\",0,0);
					}
					/*if (mydice.basevalue == 0) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice0\",0,0);
					if (mydice.basevalue == 7) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice7\",0,0);
                    if (mydice.basevalue == 8) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice8\",0,0);
                    if (mydice.basevalue == 9) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice9\",0,0);
					if (mydice.basevalue == 10) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice10\",0,0);
                    if (mydice.basevalue == -1) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-1\",0,0);
                    if (mydice.basevalue == -2) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-2\",0,0);
                    if (mydice.basevalue == -3) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-3\",0,0);
                    if (mydice.basevalue == -4) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-4\",0,0);
                    if (mydice.basevalue == -5) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-5\",0,0);
                    if (mydice.basevalue == -6) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice-6\",0,0);
					if (mydice.basevalue == 11) sprite = new displayobjects.HaxegonSprite(0,0,\"dicesprites/dice11\",0,0);*/

						mydice.showoverlayimage = true; 
						mydice.overlayimage_xoff = 0; 
						mydice.overlayimage_yoff = 0; 
						mydice.overlayimage_animate = 1; 
						mydice.overlayimage_repeat = 1; 
						mydice.graphic.overlayimage = sprite; 
					
				}
			}
		}
	}
	if (target.dicepool.length > 0) {
		for (mydice in target.dicepool) {
			if ((mydice.basevalue >= 7 || mydice.basevalue <= 0)) {
				var sprite = 0;
					if (mydice.basevalue == 0) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice0\",0,0);

                    if (mydice.basevalue == 7) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice7\",0,0);
                    if (mydice.basevalue == 8) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice8\",0,0);
                    if (mydice.basevalue == 9) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice9\",0,0);

                    if (mydice.basevalue == 10) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice10\",0,0);
                    if (mydice.basevalue == -1) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-1\",0,0);
                    if (mydice.basevalue == -2) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-2\",0,0);
                    if (mydice.basevalue == -3) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-3\",0,0);
                    if (mydice.basevalue == -4) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-4\",0,0);
                    if (mydice.basevalue == -5) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-5\",0,0);
                    if (mydice.basevalue == -6) sprite = new displayobjects.HaxegonSprite(0, 0,\"dicesprites/dice-6\",0,0);

                if (sprite + 1 == \"HaxegonSprite1\") { 
					mydice.showoverlayimage = true; 
					mydice.overlayimage_xoff = 0; 
					mydice.overlayimage_yoff = 0; 
					mydice.overlayimage_animate = 1; 
					mydice.overlayimage_repeat = 1; 
					mydice.graphic.overlayimage = sprite; 
				}
			}
		}
	}";
	
	if(self.isplayer) s.execute(self,target);
	else s.execute(target,self);
	if(self.isplayer) tw.onRepeat(s.execute,[self,target]);
	else tw.onRepeat(s.execute,[target,self]);
	if(self.isplayer) self.setvar("illegalactuator",tw);
	else target.setvar("illegalactuator",tw);
	tw.move();
}