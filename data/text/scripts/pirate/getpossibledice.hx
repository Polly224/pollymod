var slot = args[0];
var finalpool = [];
var s = slot;
if (s == "REQUIRE1" || s == "MAX1")
{
    finalpool.push(1);
}
else if (s == "REQUIRE2")
{
    finalpool.push(2);
}
else if (s == "REQUIRE3")
{
    finalpool.push(3);
}
else if (s == "REQUIRE4")
{
    finalpool.push(4);
}
else if (s == "REQUIRE5")
{
    finalpool.push(5);
}
else if (s == "REQUIRE6")
{
    finalpool.push(6);
}
else if (s == "MAX2")
{
    finalpool.push(2);
    finalpool.push(1);
}
else if (s == "MAX3")
{
    finalpool.push(3);
    finalpool.push(2);
    finalpool.push(1);
}
else if (s == "MAX4")
{
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
    finalpool.push(1);
}
else if (s == "MAX5")
{
    finalpool.push(5); 
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
    finalpool.push(1);
}
else if (s == "MIN2")
{
    finalpool.push(6);
    finalpool.push(5);
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
}
else if (s == "MIN3")
{
    finalpool.push(6);
    finalpool.push(5);
    finalpool.push(4);
    finalpool.push(3);
}
else if (s == "MIN4")
{
    finalpool.push(6);
    finalpool.push(5);
    finalpool.push(4);
}
else if (s == "MIN5")
{
    finalpool.push(6);
    finalpool.push(5);
}
else if (s == "RANGE25")
{
    finalpool.push(5);
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
}
else if (s == "RANGE35")
{
    finalpool.push(5);
    finalpool.push(4);
    finalpool.push(3);
}
else if (s == "RANGE45")
{
    finalpool.push(5);
    finalpool.push(4);
}
else if (s == "RANGE24")
{
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
}
else if (s == "RANGE23")
{
    finalpool.push(3);
    finalpool.push(2);
}
else if (s == "RANGE34")
{
    finalpool.push(4);
    finalpool.push(3);
}
else if (s == "ODD")
{
    finalpool.push(5);
    finalpool.push(3);
    finalpool.push(1);
}
else if (s == "EVEN")
{
    finalpool.push(6);
    finalpool.push(4);
    finalpool.push(2);
}
else if (s == "NORMAL")
{
    finalpool.push(6);
    finalpool.push(5);
    finalpool.push(4);
    finalpool.push(3);
    finalpool.push(2);
    finalpool.push(1);
}
if(finalpool.length == 0)
{
    finalpool = [1, 2, 3, 4, 5, 6];
}

return rand(finalpool);

/*please don't use this code if you respect yourself unlike me*/