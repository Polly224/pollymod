var self = args[0];
var eqlist = [];
if(self.getstatus("weaken@p") != null){
    for(eq in self.equipment){
        if(!eq.hastag("weakenavoid") && eq != self.getskillcard()){
            eqlist.push(eq);
        }
    }
    shuffle(eqlist);
    var checkamt = (self.getstatus("weaken@p").value) < eqlist.length ? (self.getstatus("weaken@p").value) : eqlist.length;
    if(checkamt > 0) sfx("_weaken");
    for(i in 0...checkamt){
	var pickedeq = eqlist.pop();
	var tempgamevar = pickedeq.gamevar;
	pickedeq.downgrade();
	pickedeq.animate("flash");
	pickedeq.animation[pickedeq.animation.length - 1].addcommand("textparticle", "[weaken]Weaken!", 0xDD8E41);
	pickedeq.gamevar = tempgamevar;
	var delayedcheck = new motion.actuators.SimpleActuator(null, 0.2, null);
	var s = new elements.DiceyScript("pickedeq.gamevar = tempgamevar;");
	delayedcheck.onComplete(s.execute, [self, target]);
	s.set("pickedeq", pickedeq);
	s.set("tempgamevar", tempgamevar);
	delayedcheck.move();
}
}
