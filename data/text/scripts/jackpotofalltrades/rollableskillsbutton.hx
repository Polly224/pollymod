var hideoffset = 2500;
if(self.getvar("rsbpressed") == true){
    /* Back to normal code */
    self.setvar("rsbpressed", false);
    for(eq in self.equipment){
        if(!eq.hastag("internal")){
            eq.finalpos.y += 2500;
            new motion.actuators.SimpleActuator(eq, 0.7, eq.finalpos).move();
        }
    }
    var rsbequips = self.getvar("spawnedrsbequips");
    for(eq in rsbequips){
        var dest = new openfl.geom.Point(eq.finalpos.x, eq.finalpos.y + hideoffset);
        if(eq.hastag("rsbub")) dest = new openfl.geom.Point(-800, eq.finalpos.y);
        var move = new motion.actuators.SimpleActuator(eq, 0.7, dest);
        var s = new elements.DiceyScript("self.equipment.remove(e);");
        s.set("self", self);
        s.set("e", eq);
        move.onComplete(s.execute, [self, target]);
        move.move();
    }
} else{
    /* Make skill equipment code */
    self.setvar("rsbpressed", true);
    for(eq in self.equipment){
        if(!eq.hastag("internal")){
            eq.finalpos.y -= 2500;
            new motion.actuators.SimpleActuator(eq, 0.7, eq.finalpos).move();
        }
    }
    var spawnedequips = [];
    if(self.getvar("spawnedrsbequips").length == 0){
        /* First, make the Upgrade button. */
        var eqq = new elements.Equipment("RSBUB");
        self.equipment.push(eqq);
        eqq.x = 650;
        eqq.y = -125;
        var yoffset = 350;
        eqq.y += yoffset;
        eqq.skills[0].ypos -= yoffset;
        eqq.finalpos = new openfl.geom.Point(eqq.x, eqq.y);
	    eqq.x -= 400;
        eqq.width = 1;
        eqq.height = 1;
        eqq.equipmentpanel.cardhasimage = false;
        eqq.setvar("upgradetoggle", false);
        spawnedequips.push(eqq);

        /* Then spawn in all the skills. */
        var skilldata = runscript("jackpotofalltrades/getrollableskills");
        trace(skilldata);
        var spawnx = 0;
        var spawny = 400;
        var counter = 0;
        var totalcounter = 0;
        var xamount = 5;
        for(i in 0...skilldata[0].length){
            var tempskill = new elements.Skill(skilldata[0][i]);
            var newequip = new elements.Equipment("RSB Placeholder");
            self.equipment.push(newequip);
            newequip.displayname = skilldata[0][i];
            newequip.fulldescription = tempskill.description;
            newequip.setvar("ogname", skilldata[0][i]);
            newequip.setvar("ogdescription", newequip.fulldescription);
            var tempuskill = new elements.Skill(skilldata[0][i] + "+");
            newequip.setvar("ogdescriptionr", tempuskill.description);
            var colors = ["GRAY", "BLUE", "RED", "GREEN", "YELLOW", "PURPLE", "ORANGE", "BLACK", "PINK"];
            for(c in colors){
                if(getcolumn(loaddata("jackpotofalltrades/skilldata"), c).indexOf(skilldata[0][i]) != -1){
                    newequip.changecolour(c);
                }
            }
            newequip.x = spawnx;
            newequip.y = spawny;
            newequip.finalpos = new openfl.geom.Point(spawnx, spawny);
            newequip.height = 250;
            newequip.width *= 0.97;
            newequip.descriptiontextoffset = 175;
            spawnedequips.push(newequip);
            counter++;
            totalcounter++;
            if(counter == xamount){
                counter = 0;
                spawny += newequip.height;
                spawnx = 0;
            } else{
                spawnx += newequip.width - 5;
            }
            newequip.y += hideoffset;
        }
        self.setvar("spawnedrsbequips", spawnedequips);
    } else{
        for(e in self.getvar("spawnedrsbequips")){
            self.equipment.push(e);
            spawnedequips.push(e);
        }
    }
    for(eq in spawnedequips){
        new motion.actuators.SimpleActuator(eq, 0.7, eq.finalpos).move();
    }
}