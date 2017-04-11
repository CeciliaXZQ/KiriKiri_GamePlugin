[if exp="typeof(global.snake_object)=='undefined'"]
[iscript]
function snake_keydown(key,shift)
{
  return global.snake_object.onKeyDown(key,shift);
}

class SnakePlugin extends KAGPlugin
{
  var snakelayer;
  var maplayer;
  var snakehead;
  var item;
  var forelayer;
  var backlayer;
  var gridwidth=30;
  var gridheight=30;
  var hnum=15;
  var vnum=20;
  var itemx;
  var itemy;
  var i;
  var j;
  var lastKey;
  var t;
  var score;
  var scorename;
  var snake=[];
  var headx;
  var heady;
  var tailx;
  var taily;

  function SnakePlugin()
  {
    super.KAGPlugin();
  }

  function finalize()
  {
    uninit();
    super.finalize();
  }

  function init(elm)
  {
    gridwidth=+elm.gridwidth if elm.gridwidth!==void;
    gridheight=+elm.gridheight if elm.gridheight!==void;
    hnum=+elm.hnum if elm.hnum!==void;
    vnum=+elm.vnum if elm.vnum!==void;
    forelayer=new Layer(kag,kag.fore.base);
    backlayer=new Layer(kag,kag.back.base);
    forelayer.setSize(kag.scWidth,kag.scHeight);
    backlayer.setSize(kag.scWidth,kag.scHeight);
    forelayer.fillRect(0,0,kag.scWidth,kag.scHeight,0);
    backlayer.fillRect(0,0,kag.scWidth,kag.scHeight,0);
    forelayer.visible=false;
    backlayer.visible=false;
    t=new Timer(AutoKey,"");
    t.capacity=1;
    t.enabled=false;
    t.interval=800;
    t.interval=+elm.interval if elm.interval!==void;
    scorename=elm.score;
    maplayer=new Layer(kag,forelayer);
    maplayer.setSize(gridwidth,gridheight);
    maplayer.fillRect(0,0,gridwidth,gridheight,0xFFC0C0C0);
    snakelayer=new Layer(kag,forelayer);
    snakelayer.setSize(gridwidth,gridheight);
    snakelayer.copyRect(0,0,maplayer,0,0,gridwidth,gridheight);
    snakelayer.fillRect(1,1,gridwidth-1,gridheight-1,0xFF0000FF);
    snakehead=new Layer(kag,forelayer);
    snakehead.setSize(gridwidth,gridheight);
    snakehead.copyRect(0,0,maplayer,0,0,gridwidth,gridheight);
    snakehead.fillRect(1,1,gridwidth-1,gridheight-1,0xFFFF0000);
    item=new Layer(kag,forelayer);
    item.setSize(gridwidth,gridheight);
    item.fillRect(0,0,gridwidth,gridheight,0xFF00FF00);
    if(elm.map!==void)
    {
      maplayer.loadImages(elm.map,clNone);
      maplayer.setSize(gridwidth,gridheight);
    }
    if(elm.snake!==void)
    {
      snakelayer.loadImages(elm.map,clNone);
      snakelayer.setSize(gridwidth,gridheight);
    }
    if(elm.snakehead!==void)
    {
      snakehead.loadImages(elm.map,clNone);
      snakehead.setSize(gridwidth,gridheight);
    }
    if(elm.item!==void)
    {
      item.loadImages(elm.map,clNone);
      item.setSize(gridwidth,gridheight);
    }
  }

  function start()
  {
    initmap();
    initsnake();
    CreateItem();
    score=0;
    Scripts.eval(scorename+"=0");
    forelayer.visible=true;
    backlayer.visible=true;
    t.enabled=true;
    kag.keyDownHook.add(snake_keydown);
  }

  function initmap()
  {
    for(i=0;i<hnum;i++)
    for(j=0;j<vnum;j++)
      forelayer.copyRect(j*gridwidth,i*gridheight,maplayer,0,0,gridwidth,gridheight);
  }

  function initsnake()
  {
    i=intrandom(0,3);
    if(i<=1)
    {
      //verctival
      j=intrandom(0,vnum-1);
      if(i==0)
      {
        //from top to bottom
        snake[0]=j;snake[1]=vnum+j;snake[2]=2*vnum+j;snake[3]=3*vnum+j;lastKey=VK_DOWN;
      }else{
        //from bottom to top
        snake[0]=(hnum-1)*vnum+j;snake[1]=(hnum-2)*vnum+j;snake[2]=(hnum-3)*vnum+j;snake[3]=(hnum-4)*vnum+j;lastKey=VK_UP;
      }
    }else{
      //horizontal
      j=intrandom(0,hnum-1);
      if(i==2)
      {
        //from left to right
        snake[0]=j*vnum;snake[1]=j*vnum+1;snake[2]=j*vnum+2;snake[3]=j*vnum+3;lastKey=VK_RIGHT;
      }else{
        //from right to left
        snake[0]=j*vnum+vnum-1;snake[1]=j*vnum+vnum-2;snake[2]=j*vnum+vnum-3;snake[3]=j*vnum+vnum-4;lastKey=VK_LEFT;
      }
    }
    for(i=0;i<3;i++)
    {
      headx=snake[i]\vnum;
      heady=snake[i]%vnum;
      forelayer.copyRect(heady*gridwidth,headx*gridheight,snakelayer,0,0,gridwidth,gridheight);
    }
    headx=snake[3]\vnum;
    heady=snake[3]%vnum;
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakehead,0,0,gridwidth,gridheight);
  }

  function CreateItem()
  {
    itemx=intrandom(0,hnum-1);
    itemy=intrandom(0,vnum-1);
    while(snake.find(itemx*vnum+itemy)>-1)
    {
      itemx=intrandom(0,hnum-1);
      itemy=intrandom(0,vnum-1);
    }
    forelayer.copyRect(itemy*gridwidth,itemx*gridheight,item,0,0,gridwidth,gridheight);
  }

  function AutoKey()
  {
    KeyDown(lastKey);
  }

  function onKeyDown(key,shift)
  {
    if(key==VK_A||key==VK_S||key==VK_D||key==VK_W||key==VK_UP||key==VK_DOWN||key==VK_LEFT||key==VK_RIGHT)
    {
      KeyDown(key);
      return true;
    }
    return false;
  }

  function KeyDown(key)
  {
    switch(key)
    {
      case VK_DOWN:
      case VK_S:
        if(lastKey==VK_UP||lastKey==VK_W)return;
        MoveDown();
        break;
      case VK_UP:
      case VK_W:
        if(lastKey==VK_DOWN||lastKey==VK_S)return;
        MoveUp();
        break;
      case VK_LEFT:
      case VK_A:
        if(lastKey==VK_RIGHT||lastKey==VK_D)return;
        MoveLeft();
        break;
      case VK_RIGHT:
      case VK_D:
        if(lastKey==VK_LEFT||lastKey==VK_A)return;
        MoveRight();
        break;
    }
    lastKey=key;
    onCopyLayer();
  }

  function MoveDown()
  {
    headx=snake[snake.count-1]\vnum;
    heady=snake[snake.count-1]%vnum;
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakelayer,0,0,gridwidth,gridheight);
    headx++;
    if(headx>=hnum){GameOver();return;}
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakehead,0,0,gridwidth,gridheight);
    if(snake.find(headx*vnum+heady)>-1){GameOver();return;};
    if(!(itemx==headx&&itemy==heady))
    {
      tailx=snake[0]\vnum;
      taily=snake[0]%vnum;
      forelayer.copyRect(taily*gridwidth,tailx*gridheight,maplayer,0,0,gridwidth,gridheight);
      for(i=0;i<snake.count-1;i++)
      {
        snake[i]=snake[i+1];
      }
      snake[snake.count-1]=headx*vnum+heady;
    }else{
      snake[snake.count]=headx*vnum+heady;
      addScore();
      CreateItem();
    }
  }

  function MoveUp()
  {
    headx=snake[snake.count-1]\vnum;
    heady=snake[snake.count-1]%vnum;
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakelayer,0,0,gridwidth,gridheight);
    headx--;
    if(headx<0){GameOver();return;};
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakehead,0,0,gridwidth,gridheight);
    if(snake.find(headx*vnum+heady)>-1){GameOver();return;};
    if(!(itemx==headx&&itemy==heady))
    {
      tailx=snake[0]\vnum;
      taily=snake[0]%vnum;
      forelayer.copyRect(taily*gridwidth,tailx*gridheight,maplayer,0,0,gridwidth,gridheight);
      for(i=0;i<snake.count-1;i++)
      {
        snake[i]=snake[i+1];
      }
      snake[snake.count-1]=headx*vnum+heady;
    }else{
      snake[snake.count]=headx*vnum+heady;
      addScore();
      CreateItem();
    }
  }

  function MoveLeft()
  {
    headx=snake[snake.count-1]\vnum;
    heady=snake[snake.count-1]%vnum;
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakelayer,0,0,gridwidth,gridheight);
    heady--;
    if(heady<0){GameOver();return;};
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakehead,0,0,gridwidth,gridheight);
    if(snake.find(headx*vnum+heady)>-1){GameOver();return;};
    if(!(itemx==headx&&itemy==heady))
    {
      tailx=snake[0]\vnum;
      taily=snake[0]%vnum;
      forelayer.copyRect(taily*gridwidth,tailx*gridheight,maplayer,0,0,gridwidth,gridheight);
      for(i=0;i<snake.count-1;i++)
      {
        snake[i]=snake[i+1];
      }
      snake[snake.count-1]=headx*vnum+heady;
    }else{
      snake[snake.count]=headx*vnum+heady;
      addScore();
      CreateItem();
    }
  }

  function MoveRight()
  {
    headx=snake[snake.count-1]\vnum;
    heady=snake[snake.count-1]%vnum;
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakelayer,0,0,gridwidth,gridheight);
    heady++;
    if(heady>=vnum){GameOver();return;};
    forelayer.copyRect(heady*gridwidth,headx*gridheight,snakehead,0,0,gridwidth,gridheight);
    if(snake.find(headx*vnum+heady)>-1){GameOver();return;};
    if(!(itemx==headx&&itemy==heady))
    {
      tailx=snake[0]\vnum;
      taily=snake[0]%vnum;
      forelayer.copyRect(taily*gridwidth,tailx*gridheight,maplayer,0,0,gridwidth,gridheight);
      for(i=0;i<snake.count-1;i++)
      {
        snake[i]=snake[i+1];
      }
      snake[snake.count-1]=headx*vnum+heady;
    }else{
      snake[snake.count]=headx*vnum+heady;
      addScore();
      CreateItem();
    }
  }

  function GameOver()
  {
    kag.keyDownHook.remove(snake_keydown);
    t.enabled=false;
    kag.trigger("snake_stop");
  }

  function addScore()
  {
    score++;
    kag.inputTemp=score;
    Scripts.eval(scorename+"=kag.inputTemp");
  }

  function uninit()
  {
    if(forelayer!==void)
    {
      invalidate forelayer;
      invalidate backlayer;
      invalidate snakelayer;
      invalidate maplayer;
      invalidate snakehead;
      invalidate item;
      invalidate t;
    }
    snake=[];
  }

  function onCopyLayer()
  {
    backlayer.copyRect(0,0,forelayer,0,0,kag.scWidth,kag.scHeight);
  }

  function onExchangeForeBack()
  {
    forelayer.parent=kag.fore.base;
    backlayer.parent=kag.back.base;
  }

  function pause()
  {
    kag.keyDownHook.remove(snake_keydown);
    t.enabled=false;
  }

  function resume()
  {
    kag.keyDownHook.add(snake_keydown);
    t.enabled=true;
  }
}

kag.addPlugin(global.snake_object = new SnakePlugin());
[endscript]
[endif]

[macro name=snake_init]
[eval exp="snake_object.init(mp)"]
[endmacro]

[macro name=snake_start]
[eval exp="snake_object.start()"]
[endmacro]

[macro name="snake_wait"]
[waittrig name="snake_stop"]
[endmacro]

[macro name="snake_stop"]
[eval exp="snake_object.GameOver()"]
[endmacro]

[macro name="snake_uninit"]
[eval exp="snake_object.uninit()"]
[endmacro]

[macro name="snake_pause"]
[eval exp="snake_object.pause()"]
[endmacro]

[macro name="snake_resume"]
[eval exp="snake_object.resume()"]
[endmacro]

[return]