*start
[call storage="whack_a_mole.ks"]
[layopt layer=message0 visible=true]
[nowait]
Press to start.
[waitclick]
;Background
[layopt layer=message0 visible=false]
[layopt layer=0 visible=true]
[eval exp="kag.fore.layers[0].setSize(kag.scWidth,kag.scHeight)"]
[eval exp="kag.fore.layers[0].fillRect(0,0,kag.scWidth,kag.scHeight,0x80008080)"]

;从这里开始
;参数说明如下：
;time：游戏的总时间，单位是毫秒。
;lasttime：每个地鼠的持续时间。
;interval：多长时间产生一个地鼠。
;score：记录成功打击次数的变量，实时赋值。
;baseimage：地洞的图片
;hamsterimage：地鼠的图片，若为png格式，则完全透明的地方将不接受点击事件。（即点了没用）
;se：成功打中后的音效。
;hnum：地洞的行数。
;vnum：地洞的列数。
;如果baseimage为空，则会通过basewidth，baseheight和basecolor（带透明度的，比如0x800000FF）来表示地洞。
;如果hamsterimage为空，则会通过hamsterwidth，hamsterheight和hamstercolor（带透明度的）来表示地鼠。
;（效果很烂，所以尽量不要偷懒，老老实实用地洞和地鼠的图片……）

[hamsterinit score=tf.score baseimage=base.jpg hamsterimage=hamster.jpg se=bt1.mp3 interval=500 lasttime=1000 time=20000 hnum=3 vnum=3]
[hamstershow]
[hamsterstart]

;这里的hamsterwait使得强制等待到游戏结束（即上面的time已过）才继续执行下一句命令。
;可以在前面加上其它的命令比如变量赋值、层的操作等，但是在KAGEX1之前的KAG版本上trans则会导致问题。

[hamsterwait]
[hamsteruninit]
[eval exp="System.inform('Your score is'+tf.score)"]
[jump target=*start]