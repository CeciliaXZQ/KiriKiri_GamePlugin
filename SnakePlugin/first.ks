*start
[call storage="Snake.ks"]
;snake_init������
;score���洢�����ı���������
;hnum����ͼ��������Ĭ��15
;vnum����ͼ��������Ĭ��20
;gridwidth��ÿ��С���ӵĿ�ȣ�Ĭ��30
;gridheight��ÿ��С���ӵĸ߶ȣ�Ĭ��30
;interval���Զ�ǰ����ʱ������ԽС�ٶ�Խ�죬Ĭ��800����
;map��ÿ����ͼ���ӵ�ͼƬ����д����0xC0C0C0����ɫ����
;snake�������ͼƬ����д������ɫ����
;snakehead����ͷ��ͼƬ����д���ú�ɫ����
;item��ʳ���ͼƬ����д������ɫ����
[snake_init score=tf.score]
;snake_start��ʼ��Ϸ
[snake_start]
;snake_wait�ȴ���Ϸ����
[snake_wait]
[eval exp="System.inform('��ĵ÷�Ϊ'+tf.score)"]
;snake_uninitж��
[snake_uninit]

;���⻹��snake_pause��ͣ��Ϸ��snake_resume�ָ���Ϸ