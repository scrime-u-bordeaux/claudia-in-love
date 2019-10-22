// eval = ctrl + ENTER ; recompil = ctrl + shift + l
(
~sc_device = OSSIA_Device('SC');
~sc_device.exposeOSCQueryServer();
o = Server.local.options;
o.numInputBusChannels = 0;
o.numOutputBusChannels = 19;
o.numWireBufs = 512;
o.hardwareBufferSize = 512;
o.blockSize = 512;
o.sampleRate = 48000;
o.memSize = 2.pow(21);
s.boot;
s.waitForBoot(s.plotTree);
)

(
Pipe("for i in `seq 1 19`; do jack_disconnect \"SuperCollider:out_$i\""+
	"\"system:playback_$i\"; jack_connect \"SuperCollider:out_$i\""+
	"\"system:playback_$((i + 4))\";done;
jack_connect \"SuperCollider:out_19\""+"\"system:playback_24\";done;", "w");

ScrimeSpat.multi(s, ~sc_device, "/home/scrime/Documents/proj/Cyril/SonMono",
	"/home/scrime/Documents/proj/Cyril/SonStereo",
	speaker_array:[[-45, 50], [-135, 50], [135, 50], [45, 50], [-30, 20], [-90, 20], [-150, 20],
		[150, 20], [90, 20], [30, 20], [-22.5, -3], [-67.5, -3], [-112.5, -3], [-157.5, -3],
		[157.5, -3], [112.5, -3], [67.5, -3], [22.5, -3]],
	ambisonic_order:3, decoder:FaustDome3h3v,
	radiuses:[1.565, 1.565, 1.565, 1.565, 2.062, 2.062, 2.062, 2.062, 2.062,
		2.062, 2.829, 2.829, 2.829, 2.829, 2.829, 2.829, 2.829, 2.829]);
)

(
Pipe("for i in `seq 1 19`; do jack_disconnect \"SuperCollider:out_$i\""+
	"\"system:playback_$i\"; jack_disconnect \"SuperCollider:out_$i\""+
	"\"system:playback_$((i + 4))\";
jack_disconnect \"SuperCollider:out_19\""+"\"system:playback_24\";done;
for i in `seq 1 2`; do jack_connect \"SuperCollider:out_$i\""+
	"\"system:playback_$i\";done;", "w");

ScrimeSpat.binaural(s, ~sc_device, "/home/scrime/Documents/proj/demo_dome/selec_demo",
	"/home/scrime/Documents/proj/perf_partage/fonds", ambisonic_order:3,
	hrir_path:"/home/scrime/Documents/repos/ambitools/FIR/hrir/hrir_ku100_lebedev50");
)