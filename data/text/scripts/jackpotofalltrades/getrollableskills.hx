var returnAllSkills = false;
var doFilter = true;
var JackpotOptions = [];
var RareJackpotOptions = [];
var level = self.level;

if (args.length > 0) returnAllSkills = args[0];
if (args.length > 1) doFilter = args[1];
if (args.length > 2) level = args[2];

if (returnAllSkills)
{
    for(i in 1...7)
    {
        var skillList = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"), "n" + i);
        for(s in skillList)
        {
            if (JackpotOptions.indexOf(s) == -1) JackpotOptions.push(s);
        }
        var rareSkillList = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"), "r" + i);
        for (s in rareSkillList)
        {
            if (RareJackpotOptions.indexOf(s) == -1) RareJackpotOptions.push(s);
        }
    }
}
else
{
    JackpotOptions = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"), "n" + level);
    RareJackpotOptions = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"), "r" + level);
}
if (doFilter)
{
    var ctdownchck = false;
    for (eq in self.equipment)
    {
        if (eq.slots.indexOf("COUNTDOWN") != -1)
        {
            ctdownchck = true;
            break;
        }
    }
    if (!ctdownchck) JackpotOptions.remove("Final Countdown");
    if (target.innate.length == 0) JackpotOptions.remove("Uninnate");
    if (turn == 1 || self.getvar("previousroundplayerhp") < self.hp) RareJackpotOptions.remove("Stars And Time");
    if (self.hp > self.maxhp / 2) RareJackpotOptions.remove("Dead Ringer");
}

return [JackpotOptions, RareJackpotOptions, JackpotOptions.concat(RareJackpotOptions)];