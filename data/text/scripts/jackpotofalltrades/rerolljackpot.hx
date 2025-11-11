var JackpotOptions = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"), "n" + self.level);
var RareJackpotOptions = getcolumn(loaddata("jackpotofalltrades/leveljackpotskills"),"r" + self.level);
var UpgradeAll = false;
var IsReroll = false;
var SkillsCount = 3;

if (self.hasstatus("extrajackpotskill"))
{
	SkillsCount += self.getstatus("extrajackpotskill").value;
}

if(args.length > 0)
{
	UpgradeAll = args[0];
}

if(args.length == 2)
{
	IsReroll = args[1];
}



var ChosenJackpotSkills = [];

for(i in 0...SkillsCount)
{
	if(rand([1,2,3,4,5,6]) == 1 && RareJackpotOptions.length > 0)
	{
		var s = rand(RareJackpotOptions);
        ChosenJackpotSkills.push(s);
		for(j in 0...RareJackpotOptions.length)
		{
			if (RareJackpotOptions[j] == s)
			{
                RareJackpotOptions.remove(s);
            }
		}
	}
	else
	{
        var t = rand(JackpotOptions);
        ChosenJackpotSkills.push(t);
		for (j in 0...JackpotOptions.length)
		{
			if (JackpotOptions[j] == t)
			{
				JackpotOptions.remove(t);
			}
		}
	}
}

for(i in 0...SkillsCount)
{
	if (UpgradeAll)
	{
		ChosenJackpotSkills[i] += "+";
	} 
	else
	{
		if (self.getvar("skillscanbeupgraded"))
		{
			var r = rand([1, 2, 3]);
			if (r == 1)
			{
				ChosenJackpotSkills[i] += "+";
			}
		}
	}
}

/*DEBUG STUFF, COMMENT OUT WHEN PLAYTESTING.*/

/*ChosenJackpotSkills[2] = "Uninnate";
ChosenJackpotSkills[1] = "Uninnate+";
ChosenJackpotSkills[0] = "The Blue Devil";*/

for (i in 0...SkillsCount)
{
	if (ChosenJackpotSkills[i] == "The 50/50+")
	{
		ChosenJackpotSkills[i] = "The 75/25";
	}
}



/*--- EQUIPMENT/SKILL SPECIFIC FIXES ---*/

/*Ensures that Split Path will only ever show up in the 2nd jackpot slot.*/
if (ChosenJackpotSkills.indexOf("Split Path") != -1 || ChosenJackpotSkills.indexOf("Split Path+") != -1)
{
	var otherAbility = ChosenJackpotSkills[1];
	var splitSlot = 0;
	var skillSet = "";

    for (i in 0...ChosenJackpotSkills.length)
	{
		if (ChosenJackpotSkills[i] == "Split Path" || ChosenJackpotSkills[i] == "Split Path+")
		{
			splitSlot = i;
			skillSet = ChosenJackpotSkills[i];
		}
	}
	
	ChosenJackpotSkills[splitSlot] = otherAbility;
	ChosenJackpotSkills[1] = skillSet;
}

/*Ensures that Jamie gets credited if the skill is rolled*/
if ((ChosenJackpotSkills.indexOf('The Blue Devil') != -1 || ChosenJackpotSkills.indexOf('The Blue Devil+') != -1) && !self.hasstatus("bluedevilcredits") && IsReroll)
{
    inflictself("bluedevilcredits");
}

if (self.hasstatus("bsodtriggered"))
{
	ChosenJackpotSkills = [ChosenJackpotSkills[0], ChosenJackpotSkills[1], ChosenJackpotSkills[2]];
}







/*After all the setup, this stores the chosen jackpot skills in a variable.*/
var FirstThreeSkills = [];
var BonusSkills = [];

for(i in 0...SkillsCount)
{
	if(i < 3)
	{
		FirstThreeSkills.push(ChosenJackpotSkills[i]);
	}
	else
	{
		BonusSkills.push(ChosenJackpotSkills[i]);
	}
}


Rules.jackpotskills = FirstThreeSkills;

self.setvar("currentjackpotskills", ChosenJackpotSkills);
self.setvar("bonusjackpotskills",  BonusSkills);