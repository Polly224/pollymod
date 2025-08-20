var wordcheck = args[0];
var wordreplace = args[1];

for (eq in self.equipment)
{
    var index = eq.fulldescription.indexOf(wordcheck);
    if (index != -1)
    {
        var newdesc = eq.fulldescription.split(wordcheck);
        eq.fulldescription = newdesc[0];
        for (i in 0...(newdesc.length - 1))
        {
            eq.fulldescription += wordreplace + newdesc[i + 1];
        }
        eq.animate("flashandshake");
    }
}