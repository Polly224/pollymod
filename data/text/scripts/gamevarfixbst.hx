/*Run in the fighter's Before Start Turn script, before setting any gamevars on equipment.*/

/*Checks for gamevars after a tiny delay so the equipment can still run their Before Start Turn script to set any possible values.*/

var self = args[0];
var storebool = true;
if(args.length > 1) storebool = args[1];
var unweakenstorage = self.getvar("unweakenvars");
if(unweakenstorage.length > 0){
	for(i in unweakenstorage){
		trace(i[1]);
		i[0].gamevar = i[1];
	}
}
if(storebool){
    var storedelay = new motion.actuators.SimpleActuator(self, 0.05, null);
    var s = new elements.Skill("Against all odds_old");
    s.script = "var storage = []; for(eq in self.equipment){ storage.push([eq, eq.gamevar]); } self.setvar('eqvarstorage', storage); storage = [];";
    storedelay.onComplete(function() s.execute(self), []);
    storedelay.move();
}