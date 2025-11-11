/* Code that gets run every millisecond to check if jackpot needs to have extra skills added to it. */

var act = new motion.actuators.SimpleActuator(null, 0.01, null);
var s = new elements.DiceyScript("
if (self.hp <= 0 || self.graphic == null || target == null || target.graphic == null || target.hp <= 0) 
{
    act._repeat = 0;
} 
if(self.roll_jackpot > 0 && !self.roll_error)
{
    runscript('jackpotofalltrades/addbonusslots');
    act._repeat = 0;
}
");
act.onRepeat(s.execute, [self, target]);
act._repeat = -1;
s.set("act", act);
s.set("self", self);
s.set("target", target);
s.set("runscript", runscript);
act.move();