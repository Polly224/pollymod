var s = new elements.Skill("Against All Odds_old");
var act = new motion.actuators.SimpleActuator(null, 0.001, null);
self.setvar("bsodcheckact", act);
act._repeat = -1;
act.onRepeat(s.execute, [self, target]);
act.move();

s.script = "
if (self.hp <= 0 || self.graphic == null || target == null || target.graphic == null || target.hp <= 0)
{
    self.getvar(\"bsodcheckact\").stop();    
    self.resetvar(\"bsodcheckact\"); 

}
if (self.roll_realtotal > self.roll_target && !self.hasstatus(\"bsodtriggered\"))
{
    self.roll_range += self.roll_target;
    adjustrobotcounter(0);
    inflictself(\"bsodtriggered\");
    var s = new elements.Skill(\"Against All Odds_old\");
    var act = new motion.actuators.SimpleActuator(null, 0.7, null);
    act.onComplete(s.execute, [self, target]);
    s.script = \"
    var eq = self.getskillcard();
    eq.skills = [eq.skills[0]];
    eq.skillsavailable = [eq.skillsavailable[0]];
    eq.height = 510;
    eq.finalpos.y = eq.finalpos.y + 510; 
    \"
    ;
    act.move();
    
}
"
;