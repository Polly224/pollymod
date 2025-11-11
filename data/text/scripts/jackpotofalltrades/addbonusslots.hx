var act = new motion.actuators.SimpleActuator(null, 0.8, null);
var s = new elements.DiceyScript("
    if (self.varexists('bonusjackpotskills'))
    {
        for (i in 0...self.getvar('bonusjackpotskills').length)
        {
            self.getskillcard().skills.push(new elements.Skill(self.getvar('bonusjackpotskills')[i]));
            self.getskillcard().skillsavailable.push(true);
            self.getskillcard().height += 285;
            self.getskillcard().y -= 142.5;
            self.getskillcard().finalpos.y -= 142.5;
        }
        new motion.actuators.SimpleActuator(self.getskillcard(), 0.7, self.getskillcard().finalpos).move();
    }
");
act.onComplete(s.execute, [self, target]);
s.set("self", self);
act.move();