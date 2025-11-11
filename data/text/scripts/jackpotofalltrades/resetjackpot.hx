runscript("jackpotofalltrades/rerolljackpot", args);
resetjackpot(self);
var act = new motion.actuators.SimpleActuator(null, 0.6, null);
var s = new elements.DiceyScript("
if (self.roll_jackpot > 0 && self.getskillcard().skills.length >= 3)
{
    if (self.hasstatus('extrajackpotskill') && self.getskillcard().skills.length < (3 + self.getvar('bonusjackpotskills').length) && !self.hasstatus('bsodtriggered'))
    {
        for (i in 0...self.getvar('bonusjackpotskills').length)
        {
            self.getskillcard().skills.push(new elements.Skill(self.getvar('bonusjackpotskills')[i]));
            self.getskillcard().skillsavailable.push(true);
            if(self.getskillcard().height < (1080 + (285 * self.getvar('bonusjackpotskills').length)))
            self.getskillcard().height += 285;
        }
    }
}");
act.onComplete(s.execute, [self, target]);
s.set("act", act);
s.set("self", self);
s.set("target", target);
s.set("sfx", sfx);
s.set("inflictself", inflictself);
act.move();