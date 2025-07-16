var JackpotOptions = ["Duplicate", "Midnight Snake", "Sandvich", "Suit Up", "Slingshot", "Syringe", "Lucky Roll", "Prickly Pear", "Sniper Shot", "Melting Ice", "Firey Roll", "Faulty Wiring", "Icy Roll", "Reshuffle", "Whoopie Cushion", "Reshuffle"];
var RareJackpotOptions = ["Stored Prize", "Split Path"];
var UpgradeAll = false;
var CreditJamie = false;
var SkillsCount = 3;

if (self.hasstatus("extrajackpotskill"))
{
	SkillsCount += self.getstatus("extrajackpotskill").value;
}

if(args.length == 1)
{
	UpgradeAll = args[0];
}

if(args.length == 2)
{
	CreditJamie = args[1];
}

var ctdowncheck = false;
for(eq in self.equipment)
{
	if(eq.slots.indexOf("COUNTDOWN") != -1)
	{
		ctdowncheck = true;
	}
}
if (ctdowncheck)
{
    JackpotOptions.push("Final Countdown");
	JackpotOptions.push("Final Countdown");
}

if(self.level > 1) 
{
	JackpotOptions = JackpotOptions.concat(["Debatable Damage","Flamethrower","Stress","Salvaging","Slippery Shoes","Borrow","Mechanical Toxin","Curseathon", "Used Syringe", "The 50/50", "Guarded Fling"]);
	RareJackpotOptions = RareJackpotOptions.concat(["Fifths Roll", "Containment Wave"]);
	var diceamount = 0;
}    

if(self.level > 2) 
{
	JackpotOptions = JackpotOptions.concat(["Leech", "Last Resort","Timebomb","Ctrl + C","Nanomachines", "Ice Age", "PC Fans"]);
	RareJackpotOptions = RareJackpotOptions.concat(["Limit Break","Lifeblood"]);
	
	if(self.limitbreak.name.indexOf("Autoroll") < 0)
	{
		JackpotOptions.push("Manual Roll");
	}
	var RemoveOptions2 = ["Final Countdown", "Duplicate", "Stress", "Icy Roll", "Syringe", "Prickly Pear", "Slingshot", "Suit Up", "Sandvich", "Melting Ice", "Faulty Wiring"];
	for(i in RemoveOptions2)
	{
		JackpotOptions.remove(i);
	}
}

if(self.level > 3) 
{
	JackpotOptions = JackpotOptions.concat(["Headshot","Lock Advocate","Dragon's Roll","Tri Attack","Basil's Protection","Blood Arrow","Persona"]);
	
	if(target.innate.length > 0)
	{
		RareJackpotOptions.push("Uninnate");
	}
	JackpotOptions.remove("Lucky Roll");
	JackpotOptions.remove("Used Syringe");
    JackpotOptions.remove("Sniper Shot");
    JackpotOptions.remove("Flamethrower");
    JackpotOptions.remove("The 50/50");
    JackpotOptions.remove("Firey Roll");
    JackpotOptions.remove("Guarded Fling");
    JackpotOptions.remove("Manual Roll");
    JackpotOptions.remove("Mechanical Toxin");
    RareJackpotOptions.remove("Fifths Roll");
    RareJackpotOptions = RareJackpotOptions.concat(["Feed", "Cthulhu's Shield", "Perfect Spanner", "Ka... Ching!"]);

	if (self.getvar("firstturnpassed") && (self.getvar("currentroundplayerhp") - self.hp) > (self.getvar("currentroundenemyhp") - target.hp)) 
	{
		RareJackpotOptions.push("Stars And Time");
	}
}

if(self.level > 4) 
{
	JackpotOptions.remove("Borrow");
    JackpotOptions.remove("Midnight Snake");
    JackpotOptions = JackpotOptions.concat(["Mad Dog's Howl","Prince's Steal", "Jimbo's Trick", "Double Roll"]);
	if(self.hp < self.maxhp / 2)
	{
		RareJackpotOptions.push("Dead Ringer");
	}
	RareJackpotOptions.push("The Blue Devil");
}    

if(self.level == 6) 
{
	RareJackpotOptions = RareJackpotOptions.concat(["Botulinum Dose", "Run It Back"]);
}
var ChosenJackpotSkills = [];

for(i in 0...SkillsCount)
{
	if(rand([1,2,3,4]) == 1 && RareJackpotOptions.length > 0)
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

/*ChosenJackpotSkills[2] = "Stars And Time+";
ChosenJackpotSkills[1] = "The Blue Devil";
ChosenJackpotSkills[0] = "The Blue Devil+";*/

for (i in 0...SkillsCount)
{
	if (ChosenJackpotSkills[i] == "The 50/50+")
	{
		ChosenJackpotSkills[i] = "The 75/25";
	}
}



/*--- EQUIPMENT/SKILL SPECIFIC FIXES ---*/

/*Ensures that Split Path will only ever show up in the 2nd jackpot slot.*/
if (ChosenJackpotSkills.indexOf("Split Path") != -1 && ChosenJackpotSkills.indexOf("Split Path") != 1)
{
	var otherAbility = ChosenJackpotSkills[1];
	var splitSlot = ChosenJackpotSkills.indexOf("Split Path");
	ChosenJackpotSkills[splitSlot] = otherAbility;
	ChosenJackpotSkills[1] = "Split Path";
}

/*Ensures that Jamie gets credited if the skill is rolled*/
if ((ChosenJackpotSkills.indexOf('The Blue Devil') != -1 || ChosenJackpotSkills.indexOf('The Blue Devil+') != -1) && !self.hasstatus("bluedevilcredits") && CreditJamie)
{
    inflictself("bluedevilcredits");
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