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

;�����￪ʼ
;����˵�����£�
;time����Ϸ����ʱ�䣬��λ�Ǻ��롣
;lasttime��ÿ������ĳ���ʱ�䡣
;interval���೤ʱ�����һ������
;score����¼�ɹ���������ı�����ʵʱ��ֵ��
;baseimage���ض���ͼƬ
;hamsterimage�������ͼƬ����Ϊpng��ʽ������ȫ͸���ĵط��������ܵ���¼�����������û�ã�
;se���ɹ����к����Ч��
;hnum���ض���������
;vnum���ض���������
;���baseimageΪ�գ����ͨ��basewidth��baseheight��basecolor����͸���ȵģ�����0x800000FF������ʾ�ض���
;���hamsterimageΪ�գ����ͨ��hamsterwidth��hamsterheight��hamstercolor����͸���ȵģ�����ʾ����
;��Ч�����ã����Ծ�����Ҫ͵��������ʵʵ�õض��͵����ͼƬ������

[hamsterinit score=tf.score baseimage=base.jpg hamsterimage=hamster.jpg se=bt1.mp3 interval=500 lasttime=1000 time=20000 hnum=3 vnum=3]
[hamstershow]
[hamsterstart]

;�����hamsterwaitʹ��ǿ�Ƶȴ�����Ϸ�������������time�ѹ����ż���ִ����һ�����
;������ǰ�����������������������ֵ����Ĳ����ȣ�������KAGEX1֮ǰ��KAG�汾��trans��ᵼ�����⡣

[hamsterwait]
[hamsteruninit]
[eval exp="System.inform('Your score is'+tf.score)"]
[jump target=*start]