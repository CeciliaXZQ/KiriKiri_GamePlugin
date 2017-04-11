
[if exp="typeof(global.whack_a_mole_object)=='undefined'"]
[iscript]
class TimerButton extends Layer
{
  var owner;
  var hamster=false;
  var t;

  function TimerButton(win,par,own)
  {
    super.Layer(win,par);
    hitType=htMask;
    hitThreshold=1;
    focusable=true;
    visible=true;
    owner=own;
    t=new Timer(Reset,"");
    t.interval=owner.lasttime;
    t.capacity=1;
    t.enabled=false;
    showNormal();
  }

  function finalize()
  {
    invalidate t;
    super.finalize();
  }

  function showNormal()
  {
    hamster=false;
    if(owner.baseImage!==void)
    {
      loadImages(owner.baseImage,clNone);
      setSizeToImageSize();
    }
    else
    {
      setSize(owner.baseWidth,owner.baseHeight);
      fillRect(0,0,owner.baseWidth,owner.baseHeight,owner.baseColor);
    }
  }

  function showHamster()
  {
    hamster=true;
    if(owner.hamsterImage!==void)
    {
      loadImages(owner.hamsterImage,clNone);
      setSizeToImageSize();
    }
    else
    {
      setSize(owner.hamsterWidth,owner.hamsterHeight);
      fillRect(0,0,owner.hamsterWidth,owner.hamsterHeight,owner.hamsterColor);
    }
    t.enabled=true;
  }

  function onMouseDown(x,y,button)
  {
    if(!hamster)return;
    showNormal();
    owner.GetScore();
  }

  function Reset()
  {
    t.enabled=false;
    showNormal();
  }
}

class HamsterPlugin extends KAGPlugin
{
  var base;
  var buttons=[];
  var baseImage;
  var baseColor=0xFF333333;
  var baseWidth=100;
  var baseHeight=100;
  var hamsterImage;
  var hamsterWidth=100;
  var hamsterHeight=100;
  var hamsterColor=0xFFFF3300;
  var hnum=3;
  var vnum=3;
  var i;
  var j;
  var time;
  var intervaltime;
  var score=0;
  var scorename;
  var lasttime=1000;
  var se="";

  function HamsterPlugin()
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
    base=new Layer(kag,kag.primaryLayer);
    base.setSize(kag.scWidth,kag.scHeight);
    base.fillRect(0,0,kag.scWidth,kag.scHeight,0);
    base.visible=false;
    base.absolute=3000000;
    time=new Timer(stop,"");
    time.enabled=false;
    time.interval=30000;
    time.capacity=1;
    intervaltime=new Timer(SetNew,"");
    intervaltime.enabled=false;
    intervaltime.interval=800;
    intervaltime.capacity=1;
    time.interval=+elm.time if elm.time!==void;
    intervaltime.interval=+elm.interval if elm.interval!==void;
    lasttime=+elm.lasttime if elm.lasttime!==void;
    se=elm.se if elm.se!==void;
    xnum=+elm.xnum if elm.xnum!==void;
    ynum=+elm.ynum if elm.ynum!==void;
    baseColor=+elm.basecolor if elm.basecolor!==void;
    baseWidth=+elm.basewidth if elm.basewidth!==void;
    baseHeight=+elm.baseheight if elm.baseheight!==void;
    hamsterColor=+elm.hamstercolor if elm.hamstercolor!==void;
    hamsterWidth=+elm.hamsterwidth if elm.hamsterwidth!==void;
    hamsterHeight=+elm.hamsterheight if elm.hamsterheight!==void;
    baseImage=elm.baseimage;
    hamsterImage=elm.hamsterimage;
    scorename=elm.score;
    for(i=0;i<hnum;i++)
    {
      buttons[i]=[];
      for(j=0;j<vnum;j++)
      {
        buttons[i][j]=new TimerButton(kag,base,this);
        buttons[i][j].left=150*j+50;
        buttons[i][j].top=150*i+50;
      }
    }
  }

  function show()
  {
    base.visible=true;
  }

  function start()
  {
    show();
    SetNew();
    time.enabled=true;
    intervaltime.enabled=true;
  }

  function SetNew()
  {
    i=intrandom(0,hnum-1);
    j=intrandom(0,vnum-1);
    buttons[i][j].showHamster();
  }

  function GetScore()
  {
    playsound();
    score++;
    kag.inputTemp = score;
    Scripts.eval(scorename+"=kag.inputTemp");
  }

  function playsound()
  {
    if(se===void || se=="")return;
    kag.se[0].play(%[storage:se.escape()]);
  }

  function stop()
  {
    time.enabled=false;
    intervaltime.enabled=false;
    for(i=0;i<hnum;i++)
    {
      for(j=0;j<vnum;j++)
      {
        buttons[i][j].showNormal();
      }
    }
    kag.trigger("stop");
  }

  function hide()
  {
    base.visible=false;
  }

  function uninit()
  {
  try{
    for(i=0;i<hnum;i++)
    {
      for(j=0;j<vnum;j++)
      {
        invalidate buttons[i][j];
      }
    }
    invalidate base;
    invalidate time;
    invalidate intervaltime;
  }catch(e){}
  }

  function onExchangeForeBack()
  {
    if(base.parent.comp===void)return;
    base.parent=base.parent.comp;
  }
}

kag.addPlugin(global.whack_a_mole_object = new HamsterPlugin());
[endscript]
[endif]

[macro name=hamsterinit]
[eval exp="whack_a_mole_object.init(mp)"]
[endmacro]

[macro name=hamstershow]
[eval exp="whack_a_mole_object.show()"]
[endmacro]

[macro name=hamsterstart]
[eval exp="whack_a_mole_object.start()"]
[endmacro]

[macro name=hamsterstop]
[eval exp="whack_a_mole_object.stop()"]
[endmacro]

[macro name=hamsteruninit]
[eval exp="whack_a_mole_object.uninit()"]
[endmacro]

[macro name=hamsterwait]
[waittrig canskip=false name="stop"]
[endmacro]

[return]
