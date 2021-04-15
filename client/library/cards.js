class ArgsType {
}
ArgsType.NOTHING = 0;
ArgsType.DRAW_OTHER = 1;
ArgsType.MOVE_OTHER = 2;
ArgsType.DISCARD_ME = 3;
ArgsType.BARKS = 4;
ArgsType.DISCARD_OTHER = 5;

class Nothing {
	constructor(){
		this.type = ArgsType.NOTHING;
	}
}
const NOTHING = new Nothing();

class DrawOther {
	constructor(strength){
		this.type = ArgsType.DRAW_OTHER;
		this.strength = strength;
	}
}

class MoveOther {
	constructor(strengths){
		this.type = ArgsType.MOVE_OTHER;
		this.strengths = strengths;
	}
}

class DiscardMe {
	constructor(strength){
		this.type = ArgsType.DISCARD_ME;
		this.strength = strength;
	}
}

class Barks {
	constructor(){
		this.type = ArgsType.BARKS;
	}
}
const BARKS = new Barks();

class DiscardOther {
	constructor(strength){
		this.type = ArgsType.DISCARD_OTHER;
		this.strength = strength;
	}
}

const CARDS = [];

// Cartes Action des Aventuriers
CARDS["aventurier1"] = [
	[NOTHING, NOTHING, NOTHING],
	[NOTHING, BARKS, NOTHING]
];
CARDS["aventurier2"] = [
	[NOTHING, NOTHING],
	[NOTHING, NOTHING, new DrawOther(2)]
];
CARDS["aventurier3"] = [
	[NOTHING, NOTHING],
	[NOTHING, new MoveOther([3, 1])]
];
CARDS["aventurier4"] = [
	[NOTHING, NOTHING, new MoveOther([1])],
	[new DiscardMe(1), new MoveOther([2]), NOTHING]
];

// Cartes Action des Cerbères
CARDS["cerbere1"] = [
	[NOTHING, NOTHING],
	[new MoveOther([2]), NOTHING, NOTHING]
];
CARDS["cerbere2"] = [
	[NOTHING, NOTHING],
	[NOTHING, NOTHING]
];
CARDS["cerbere3"] = [
	[NOTHING, NOTHING],
	[NOTHING, NOTHING, new DrawOther(1)]
];
CARDS["cerbere4"] = [
	[new MoveOther([1, -1, -1, -1])],
	[NOTHING, NOTHING]
];

// Cartes Survie
CARDS["Couar"] = [
	[NOTHING, BARKS],
	[new DiscardMe(1), NOTHING]
];
CARDS["Oppo"] = [
	[NOTHING, NOTHING, new MoveOther([-1])],
	[new DiscardMe(1), new MoveOther([-2]), NOTHING],
	[new DiscardMe(1), new MoveOther([2]), NOTHING]
];
CARDS["Arro"] = [
	[NOTHING, new MoveOther([1, 1])],
	[new DiscardMe(1), new MoveOther([3]), NOTHING]
];
CARDS["Fav"] = [
	[NOTHING, NOTHING, new MoveOther([1])],
	[new DiscardMe(3), NOTHING, new MoveOther([2, 1])]
];
CARDS["Sac"] = [
	[NOTHING, NOTHING, new MoveOther([-1])],
	[new DiscardMe(1), NOTHING, new MoveOther([-2])]
];
CARDS["Ego"] = [
	[NOTHING, NOTHING],
	[new DiscardMe(1), NOTHING]
];
CARDS["Fata"] = [
	[NOTHING, NOTHING],
	[NOTHING, new MoveOther([3])]
];

// Cartes Trahison
CARDS["Ranc"] = [
	[NOTHING, new MoveOther([-2])],
	[new DiscardMe(2), NOTHING]
];
CARDS["Vio"] = [
	[NOTHING, NOTHING],
	[new DiscardMe(2), NOTHING]
];
CARDS["Sabo"] = [
	[NOTHING, new DiscardOther(2)],
	[new DiscardMe(1), NOTHING]
];
CARDS["Perf"] = [
	[NOTHING, NOTHING],
	[new DiscardMe(1), NOTHING]
];
CARDS["Four"] = [
	[NOTHING, BARKS],
	[new MoveOther([1, -3])]
];
CARDS["Embu"] = [
	[NOTHING, NOTHING],
	[new DiscardMe(1), NOTHING]
];
