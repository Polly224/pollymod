var rollableSkills = runscript("jackpotofalltrades/getrollableskills", []);
var jackpotOptions = rollableSkills[0];
jackpotOptions.push("Reshuffle");
var rareJackpotOptions = rollableSkills[1];
var upgradeAll = false;
var SkillsCount = 3;

if (self.hasstatus("extrajackpotskill") && !self.hasstatus("bsodtriggered"))
{
	SkillsCount += self.getstatus("extrajackpotskill").value;
}

if(args.length > 0) upgradeAll = args[0];

var pickedSkills = [];

for(i in 0...SkillsCount)
{
	if(rand([1,2,3,4,5,6]) == 1 && rareJackpotOptions.length > 0)
	{
		var s = rand(rareJackpotOptions);
        pickedSkills.push(s);
		for(j in 0...rareJackpotOptions.copy().length)
		{
			if (rareJackpotOptions.copy()[j] == s)
			{
                rareJackpotOptions.remove(s);
            }
		}
	}
	else
	{
        var t = rand(jackpotOptions);
        pickedSkills.push(t);
		for (j in 0...jackpotOptions.copy().length)
		{
			if (jackpotOptions.copy()[j] == t)
			{
				jackpotOptions.remove(t);
			}
		}
	}
}

for(i in 0...SkillsCount)
{
	if (upgradeAll)
	{
		pickedSkills[i] += "+";
	} 
	else
	{
		if (self.getvar("skillscanbeupgraded"))
		{
			var r = rand([1, 2, 3]);
			if (r == 1)
			{
				pickedSkills[i] += "+";
			}
		}
	}
}

/*DEBUG STUFF, COMMENT OUT WHEN PLAYTESTING.*/

/*pickedSkills[2] = "Stars And Time";
pickedSkills[1] = "Stars And Time+";
pickedSkills[0] = "The Blue Devil";*/



/*--- EQUIPMENT/SKILL SPECIFIC FIXES ---*/

/*Ensures that Split Path will only ever show up in the 2nd jackpot slot.*/
if (pickedSkills.indexOf("Split Path") != -1 || pickedSkills.indexOf("Split Path+") != -1)
{
	var otherAbility = pickedSkills[1];
	var splitSlot = 0;
	var skillSet = "";

    for (i in 0...pickedSkills.length)
	{
		if (pickedSkills[i] == "Split Path" || pickedSkills[i] == "Split Path+")
		{
			splitSlot = i;
			skillSet = pickedSkills[i];
		}
	}
	
	pickedSkills[splitSlot] = otherAbility;
	pickedSkills[1] = skillSet;
}







/*After all the setup, this stores the chosen jackpot skills in a variable.*/
var FirstThreeSkills = [];
var BonusSkills = [];

for(i in 0...SkillsCount)
{
	if(i < 3)
	{
		FirstThreeSkills.push(pickedSkills[i]);
	}
	else
	{
		BonusSkills.push(pickedSkills[i]);
	}
}


Rules.jackpotskills = FirstThreeSkills;

self.setvar("currentjackpotskills", pickedSkills);
self.setvar("bonusjackpotskills",  BonusSkills);