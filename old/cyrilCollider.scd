a = 1;

a.postln;

b = a + 1;

b.postln;

a = a + 5;

c = "un bout de text";

c.postln;

d = "un autre bout de text";

d.postln;//mon comentaire

e = c+d;

e.postln;

s.boot;
s.quit;

(
~maVariable = { Out.ar(0,
	SinOsc.ar(SinOsc.kr(5, add:400, mul:100),
	mul:0.5)!2;
	);
}.play;
)

~maVariable.free;

(
SynthDef('monsynthe', {
	arg freq = 5, add = 400, gain = 0.5;
	var sig;
	sig = SinOsc.ar(SinOsc.kr(freq, add:add, mul:100), mul:gain);
	sig = Out.ar(0, sig);
}).add;
)

a = Synth('monsynthe');
a.set(\freq, 7);
a.set(\add, 600);
a.free;











	