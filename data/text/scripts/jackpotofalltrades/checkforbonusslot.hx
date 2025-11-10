/* Code that gets run every millisecond to check if jackpot needs to have extra skills added to it. */

var act = new motion.actuators.SimpleActuator(null, 0.001, null);
var s = new elements.DiceyScript("
if (self.roll_jackpot > 0 && self.getskillcard().skills.length >= 3)
{
    if (self.hasstatus('extrajackpotskill') && self.getskillcard().skills.length < (3 + self.getvar('bonusjackpotskills').length) && self.getskillcard().y == self.getskillcard().finalpos.y && !self.hasstatus('bsodtriggered'))
    {
        for (i in 0...self.getvar('bonusjackpotskills').length)
        {
            self.getskillcard().skills.push(new elements.Skill(self.getvar('bonusjackpotskills')[i]));
            self.getskillcard().skillsavailable.push(true);
            self.getskillcard().height += 285;
            self.getskillcard().y -= 142.5;
            self.getskillcard().finalpos.y -= 142.5;
        }
        self.getskillcard().animate('flashandshake');
        sfx('_thinghappens');
    }
    if(self.varexists('currentjackpotskills') && self.getvar('currentjackpotskills').length > 0){
        if((self.getvar('currentjackpotskills').indexOf('The Blue Devil') != -1 || self.getvar('currentjackpotskills').indexOf('The Blue Devil+') != -1) && !self.hasstatus('bluedevilcredits'))
        {
            inflictself('bluedevilcredits');
        }
    }
}
if (self.hp <= 0 || self.graphic == null || target == null || target.graphic == null || target.hp <= 0) 
{
    trace('stopping actuator for bonus slot');
    act._repeat = 0;
} ");
act.onRepeat(s.execute, [self, target]);
act._repeat = -1;
s.set("act", act);
s.set("self", self);
s.set("target", target);
s.set("sfx", sfx);
s.set("inflictself", inflictself);
s.set("s", s);
act.move();