(
~jengglong3 = Buffer.readChannel(s,"/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/SuperCollider 2/Jengglong3.wav",channels:1);
~saron6 = Buffer.readChannel(s,"/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/SuperCollider 2/Saron6.wav",channels:1);
~bonang1 = Buffer.readChannel(s,"/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/SuperCollider 2/Bonang1.wav",channels:1);
~goong2 = Buffer.readChannel(s,"/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/SuperCollider 2/Goong2.wav",channels:1);
)
(
(
SynthDef(\campanas,{|xpos=0,ypos=0,f1=220,env1=0,env2=1.9,pan=7,n=13,amp=1.5,t=1|
var uno, env;

	uno=Mix.fill(13, {BPF.ar(BrownNoise.ar,f1,5/f1,amp/10)});
	env = EnvGen.kr(Env.perc(env1,env2*t),1,doneAction:2);
Out.ar(0,Pan4.ar(uno,xpos,ypos)*env);
}).send(s)
);
(
SynthDef(\saron6, {|ra=(-4),amprr=1,amp=5,xpos=0,ypos=0,env1=0,env2=1.9,freq=40,rel=12,at=3,lv=1,n=1,a=20,b=1500.0,gate=1,dur=5.5,t=1,fr=0|
                 var sig, env,trate, trigger,bu;//,dur;
	bu=~saron6;
                 trigger = 30;
	  //           trate = MouseY.kr(8,1000,1);
	//dur = MouseX.kr(6,50)/trate;

	trate=2;
	//dur=5.5;

	//trate=LFNoise0.kr(0.1)*2;
	//dur=2/trate;


	sig=FreeVerb.ar( TGrains.ar(1, TDuty.ar(20, inf),bu.bufnum
		,ra, 0, BufDur.kr(bu), LFNoise0.kr(10), 0.3),Line.kr(0.5,0,8),7);
      env = EnvGen.kr(Env.perc(env1,t*BufDur.kr(bu)/abs(ra)),1,doneAction:2);
         //env=EnvGen.kr(Env.asr(0.3,5,10),gate,0.5,doneAction:2);
         Out.ar(0,Pan4.ar(sig,xpos,ypos)*env*amp);
                 }).send(s);
);
(
SynthDef(\goong2, {|ra=(-4),amprr=1,amp=5,xpos=0,ypos=0,env1=0,env2=1.9,freq=40,rel=12,at=3,lv=1,n=1,a=20,b=1500.0,gate=1,dur=5.5,t=1,fr=0|
                 var sig, env,trate, trigger,bu;//,dur;
	bu=~goong2;
                 trigger = 30;
	  //           trate = MouseY.kr(8,1000,1);
	//dur = MouseX.kr(6,50)/trate;

	trate=2;
	//dur=5.5;

	//trate=LFNoise0.kr(0.1)*2;
	//dur=2/trate;


	sig=FreeVerb.ar( TGrains.ar(1, TDuty.ar(20, 2),bu.bufnum
		,ra, 0, BufDur.kr(bu), LFNoise0.kr(10), 0.3),Line.kr(0.5,0,8),7);
	env = EnvGen.kr(Env.perc(env1,t*BufDur.kr(bu)/abs(ra)),1,doneAction:2);
         //env=EnvGen.kr(Env.asr(0.3,5,10),gate,0.5,doneAction:2);
         Out.ar(0,Pan4.ar(sig,xpos,ypos)*env*amp);
                 }).send(s);
);
(
SynthDef(\bonang1, {|ra=(10),amprr=1,amp=5,xpos=0,ypos=0,env1=0,env2=1.9,freq=40,rel=12,at=3,lv=1,n=1,a=20,b=1500.0,gate=1,dur=5.5,t=1,fr=0|
                 var sig, env,trate, trigger,bu;//,dur;
	bu=~bonang1;
                 trigger = 30;
	  //           trate = MouseY.kr(8,1000,1);
	//dur = MouseX.kr(6,50)/trate;

	trate=2;
	//dur=5.5;

	//trate=LFNoise0.kr(0.1)*2;
	//dur=2/trate;


	sig=FreeVerb.ar( TGrains.ar(1, TDuty.ar(20, 2),bu.bufnum
		,ra, 0, BufDur.kr(bu), LFNoise0.kr(10), 0.3),Line.kr(0.5,0,8),7);
	env = EnvGen.kr(Env.perc(env1,t*BufDur.kr(bu)/abs(ra)),1,doneAction:2);
         //env=EnvGen.kr(Env.asr(0.3,5,10),gate,0.5,doneAction:2);
         Out.ar(0,Pan4.ar(sig,xpos,ypos)*env*amp);
                 }).send(s);
);
(
SynthDef(\poscsin,{|gate=1,xpos=0,ypos=0, f1=120, f2=140, mpi=3,lpi=0, p=0,fsin=0.2, t=3, fpan=0, lpan=1, amp=0.2,a=3,d=2,s=0.2,r=7,lv=0.5|
	var sig,env,sin,env2,aenv1,atenv1,aenv2,atenv2;
	sin=FSinOsc.kr(MouseX.kr(0.5,5),0,mpi);
	sig=PMOsc.ar(f1,f2,d,0);
	sig=Pan4.ar(sig,xpos,ypos);
	env=EnvGen.kr(Env.adsr(a,d,s,r,lv),gate,doneAction:2);
	Out.ar(0,FreeVerb.ar(sig)*env*amp);
}).send(s)
);
(
SynthDef(\4,{|xpos=0,ypos=0,freq=8000,env1=0.01,env2=4,pan=0,amp=0.1,amp1=0.2,amp2=0.01, amp3=0.003|
var uno, dos, tres, cuatro, env;

	uno = SinOsc.ar(freq*(0.5),0,amp);
dos = SinOsc.ar(freq*2,0,amp1);
tres = SinOsc.ar(freq*3,0,amp2);
cuatro = SinOsc.ar(freq*4.5,0,amp3);

env = EnvGen.kr(Env.perc(env1,env2),0.2,doneAction:2);
Out.ar(0,Pan4.ar(uno+dos+tres+cuatro,xpos,ypos)*env*0.2);
}).send(s)
);
(
SynthDef(\jengglong3b, {|xpos=0,ypos=0,freq=40,rel=12,at=3,lv=1,n=1,a=20,b=1500.0,t=9,gate=1,dur=5.5,fr=0|
                 var sig, env,trate, trigger,bu;//,dur;
	bu=~jengglong3;
                 trigger = 30;
	  //           trate = MouseY.kr(8,1000,1);
	//dur = MouseX.kr(6,50)/trate;

	trate=2;
	//dur=5.5;

	//trate=LFNoise0.kr(0.1)*2;
	//dur=2/trate;


	sig=FreeVerb.ar( TGrains.ar(1,SinOsc.kr(trate+fr*LFNoise0.kr(3)),bu.bufnum , LFNoise0.kr(0.02).range(-0.1,-0.8), BufDur.kr(bu)/2+BufDur.kr(bu)*LFNoise0.kr(15)/2, dur, LFNoise0.kr(10), 0.3),0.55,7);

         env=EnvGen.kr(Env.asr(0.3,5,10),gate,0.5,doneAction:2);
	Out.ar(0,Pan4.ar(sig,xpos,ypos)*env*1);
                 }).send(s);
);
)

(
~xposb=0;
~yposb=0;
x=Synth(\poscsin,[\f2,100,\t,3,\amp,0.1]);
y=Synth(\jengglong3b);
OSCdef(\ecucha3,{
	arg msg;
	msg.postln;
	msg[1]=msg[1]+1;
	if(msg[2]<0.1 ){
		msg[2]=msg[2]+0.06;
		msg[2].postln};

	if(msg[1]>101 ) {

		Synth(\campanas,[\f1,500+msg[2]*800*(msg[1]),\amp,msg[2],\xpos,msg[3],\ypos,msg[4],\t,msg[4]+2.5])};
	if(msg[1]>51 ) {
		if(msg[1]<100) {

			Synth(\4,[\freq,500+msg[2]*800*(msg[1]),\amp,msg[2],\xpos,msg[3],\ypos,msg[4],\env1,abs(msg[4]-3.5),\env2,abs(msg[4]+3.5)])}};
	if(msg[1] < 150) {
		if(75<msg[1]) {

		//Synth(\saron6,[\amp,msg[2]*2,\ra,msg[2]+(msg[4]+2)*2.5+0.1,\xpos,msg[3],\ypos,msg[4],\t,msg[5]])

			Synth(\saron6,[\amp,msg[2]*5,\ra,msg[2]*(-5)*(msg[1])/10+msg[4]+2.5,\xpos,msg[3],\ypos,msg[4],\t,msg[4]+3.5])

	}};

	if(msg[1] < 75) {
		if(15<msg[1] ) {

		//Synth(\saron6,[\amp,msg[2]*2,\ra,msg[2]+(msg[4]+2)*2.5+0.1,\xpos,msg[3],\ypos,msg[4],\t,msg[5]])

			Synth(\bonang1,[\amp,msg[2]*5,\ra,msg[2]*(-5)*(msg[1])/10+msg[4]+2.5,\xpos,msg[3],\ypos,msg[4],\t,msg[4]+3.5])

	}};
	if(msg[1]<15  ) {Synth(\goong2,[\amp,msg[2],\ra,1])

	};
	~xposb=msg[3];
	~yposb=msg[4];
	if(~xposb<0){
		~xposb=~xposb+0.1;

	};
	if(0<~xposb){
		~xposb=~xposb-0.1;

	};
if(~yposb<0){
		~xposb=~xposb+0.1;

	};
	if(0<~yposb){
		~xposb=~xposb-0.1;

	};
	x.set(\xpos,~xposb,\ypos,~yposb);
	y.set(\xpos,~xposb,\ypos,~yposb);
	//x.set(\f2,100+msg[2]*100/msg[1],\amp,msg[2]/2);
	x.set(\f2,100+msg[2]*100/msg[1],\amp,msg[2]/2,\d,msg[2]*5);




}


,"/starhit");

)
x.set(\gate,0)
y.set(\gate,0)