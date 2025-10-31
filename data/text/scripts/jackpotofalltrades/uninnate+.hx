var status = args[0];
var target = args[1];

var sD = switch target.innate[0]{
	case "weakfire": "You take double damage from [fire] fire damage and [fire] Burn.";
	case "weakice": "You take double damage from [ice] ice damage.";
	case "weakshock": "You take double damage from [shock] shock damage and [shock] Shocked?.";
	case "strongfire": "You take half damage from [fire] fire damage and [fire] Burn.";
	case "strongpoison": "You take half damage from [poison] poison.";
	case "immunestatus": "You can't be inflicted with [lock] locked and [ice] freeze.";
	case "goesfirst": "You go first during the start of this battle. So, really, nothing changes.";
	case "gaindice": "You gain an extra dice at the start of each turn.";
	case "vampire": "You can't be defeated without a Wooden Stake.";
	default: "You gain the effects of your enemy's stolen innate.";
}

var sN = switch target.innate[0]{
	case "weakfire": "Fire_Weakness";
	case "weakice": "Ice_Weakness";
	case "weakshock": "Shock_Weakness";
	case "strongfire": "Fire_Resistance";
	case "strongpoison": "Poison_Resistance";
	case "immunestatus": "Lock/Freeze_Immunity";
	case "goesfirst": "Go First";
	case "gaindice": "Dice Gain";
	case "vampire": "Vampire";
	default: "Stolen_Innate";
}
var isjulti = false;
if(target.innate[0].indexOf("ups [fire] cost") != -1){
	sD = "You increase the cost of burned dice by [fire]1 per turn. (Currently [fire]" + Rules.burningdicecost + "[].)";
	sN = "Devil's_Fire";
	isjulti = true;
} if(target.innate[0].indexOf("loses [gold]1 gold") != -1){
	sD = "You lose [gold]1 gold at the start of your turn.";
	sN = "Pocket_Hole";
}
status.template.displayname = sN;
status.name = sN;
status.template.description = sD;

var statuses = ["fire", "ice", "shock", "poison", "lock", "dice", "gold"];
for(i in 0...statuses.length){
	if(sD.indexOf(statuses[i]) != -1){
		status.symbol = statuses[i];
	}
} if(target.innate[0] == "goesfirst") status.symbol = "dodge";
if(isjulti) status.symbol = "devilfire";