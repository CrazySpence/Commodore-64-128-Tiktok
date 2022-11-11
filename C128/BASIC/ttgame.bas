5 rem init vars
10 scnclr
20 ct = 0
40 color 0,1
50 color 1,1
60 color 4,3
70 color 5,6
80 sp=7
90 xs=+sp
100 ys=-sp
110 gm=0
115 lv=0
118 char 1,15,11,"loading... "
119 rem load sprites
120 bload "ttspr",b0
125 rem load border speed hack
130 bload "borderfast",b0
140 sys 5888
190 rem init level
200 sprite 1,1,11,1,0,0,0
210 movspr1,150,150
290 gosub 1000
300 do
305 :  if gm = 1 then gosub 4000
310 :  movspr1,+xs,+ys
315 :  rem check bounce
320 :  gosub 2000
325 :  rem speed variance
330 :  jt=int(rnd(1)*3-1)
335 :  rem check input
340 :  cj = joy(2)
350 :  gosub 3000
360 :  if ct > 0 then ct = ct-1:else collision 1,5000
370 :  lv = int((ps/50))
410 loop until 1=0
1000 rem draw level
1005 scnclr
1010 char 1,5,2,"VVVVVVVVVVVVVVVVVVVVVVVVVVVVVV"
1015 print
1020 for i= 1 to 17
1030 print"     V                            V"
1040 next i
1060 char1,15,11,"press fire!"
1070 sprite 2,1,2,1,0,0,0
1080 movspr 2,150,200
1090 do
1100 :   cj=joy(2)
1110 loop until cj > 127
1120 char1,15,11,"           "
1130 char1,5,1,"score: "
1140 return
2000 rem check spr location
2010 tx=rsppos(1,0)
2020 ty=rsppos(1,1)
2030 if tx<=69 then xs=sp+jt+lv
2040 if tx>=275 then xs=-sp+jt-lv
2050 if ty<=70 then ys=sp+jt+lv
2060 if ty>=190 then gm=1
2070 return
3000 rem joystick sub
3010 pj = cj
3020 cj = 0
3030 if pj = 7 then begin
3040 :  if rsppos(2,0) > 69 then movspr2,270 #2:else movspr 2,0#0
3050 bend
3060 if pj = 3 then begin
3070 :  if rsppos(2,0) <275 then movspr2,90 #2:else movspr 2,0#0
3080 bend
3090 if pj = 0 then movspr2,0#0
3100 return
4000 rem game over
4010 collision 1
4020 char 1,15,11,"game over!"
4030 cj=0
4040 jt=0
4050 xs=+sp
4060 ys=-sp
4070 ct=0
4080 sp=7
4085 movspr 2,0#0
4090 do
4100 :   cj=joy(2)
4110 loop until cj > 127
4120 movspr1,150,150
4130 char 1,15,11,"          "
4140 gm=0
4150 ps=0
4160 return
5000 rem tiktok to player collision
5010 collision 1,7000
5020 ct=10
5030 ys=-sp+jt
5040 ps=ps+10
5050 char 1,11,1,"":print ps
5060 movspr1,+0,-10
5070 return
6000 movspr1,0#0:movspr2, 0#0
6010 sprite 1,0
6020 sprite 2,0
7000 return
