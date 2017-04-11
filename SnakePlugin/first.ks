*start
[call storage="Snake.ks"]
;snake_init参数有
;score：存储分数的变量，必需
;hnum：地图的行数，默认15
;vnum：地图的列数，默认20
;gridwidth：每个小格子的宽度，默认30
;gridheight：每个小格子的高度，默认30
;interval：自动前进的时间间隔，越小速度越快，默认800毫秒
;map：每个地图格子的图片，不写则用0xC0C0C0的颜色代替
;snake：蛇身的图片，不写则用蓝色代替
;snakehead：蛇头的图片，不写则用红色代替
;item：食物的图片，不写则用绿色代替
[snake_init score=tf.score]
;snake_start开始游戏
[snake_start]
;snake_wait等待游戏结束
[snake_wait]
[eval exp="System.inform('你的得分为'+tf.score)"]
;snake_uninit卸载
[snake_uninit]

;另外还有snake_pause暂停游戏和snake_resume恢复游戏