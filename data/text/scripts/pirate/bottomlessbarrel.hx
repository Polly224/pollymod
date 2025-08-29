/*botbarrelinjected*/
var has1 = false;
for (dice in actualdice)
{
    if (dice.basevalue == 1)
    {
        has1 = true;
    }
}
if (e.slots == [\'COUNTDOWN\'
    ]
)
{
    if (dicehistory[dicehistory.length - 1].basevalue == 1)
    {
        has1 = true;
    }
}
if (!has1)
{
    for (eq in self.equipment)
    {
        if (eq.name == \'Bottomless Barrel\'
                    )
                    {
        eq.doequipmentaction(self, target, 1, [], 0, false, false, false);
    }
}
            }