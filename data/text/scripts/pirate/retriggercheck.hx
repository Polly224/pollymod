/* Code that gets run every millisecond to check if jackpot needs to have extra skills added to it. */

var act = new motion.actuators.SimpleActuator(null, 0.001, null);
var s = new elements.DiceyScript("
if(getactivefighter() != self){
    act._repeat = 0;
    return;
}
for(eq in self.equipment)
{ 
    if(eq.sourceequipment != null && eq.sourceequipment != eq && !eq.getvar(\"retriggered\")){
        eq.setvar(\"retriggered\", true);
        runscript(\"retrigger\", [eq]);
    }
}
"
);
act.onRepeat(s.execute, [self, target]);
act._repeat = -1;
s.set("act", act);
s.set("self", self);
s.set("target", target);
s.set("sfx", sfx);
s.set("s", s);
act.move();