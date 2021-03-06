import 'package:flutter/material.dart';
import 'package:flutter_tutorials_and_quizzes/_Comp_Courses/Cmp_Title.dart';
import 'package:marquee/marquee.dart';
import 'package:widget_with_codeview/source_code_view.dart';
import '../LoadFireBaseAdmob.dart';
import '../SettingPage.dart';
import '../main.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;


typedef void OnError(Exception exception);
TabController tabController;
TextEditingController CodeTxtField = new TextEditingController();



var Public_RunCodeRout,Public_CodeRoute,Public_ItemList,Public_ToDo,Pub_Exp;


class CmpCodePage extends StatefulWidget {

  final String Title,BackRoute,NextRoute,CodeRoute,ToDo,TxtExplanation;
  final List ItemList;
  final Icon TabIcon;
  var RunCodeRoute;

  CmpCodePage({
    @required this.Title,
    @required this.BackRoute,
    @required this.NextRoute,
    @required this.ItemList,
    @required this.CodeRoute,
    @required this.TabIcon,
    @required this.ToDo,
    @required this.TxtExplanation,
    @required this.RunCodeRoute,
  });

  @override
  _CmpCodePageState createState() => new _CmpCodePageState();
}

class _CmpCodePageState extends State<CmpCodePage> with SingleTickerProviderStateMixin {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;



  Future<String> readCounter() async {
    return await rootBundle.loadString(widget.CodeRoute);
  }



  @override
  Future initState()  {
    super.initState();
    Public_RunCodeRout=widget.RunCodeRoute;
    Public_CodeRoute=widget.CodeRoute;
    Public_ToDo=widget.ToDo;
    Pub_Exp=widget.TxtExplanation;
    Public_ItemList=widget.ItemList;

    initPlayer();
    tabController = new TabController(vsync: this, length: 3,);

    ShowMyAds();


  }


  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }

  void PlayTapSound() async{
    if(AppSoundRetrieve=="NotMuted") {
      audioCache.play('Music/Tap.mp3');
    }
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title:widget.Title,
      home:Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (){
              loadAds++;
              PlayTapSound();
              Navigator.of(context).pushReplacementNamed(widget.BackRoute);
            },
          ),
          title: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
              child:
              SizedBox(
                  width: MediaQuery.of(context).size.width-50,
                  height: MediaQuery.of(context).size.height,
                  child:
                  Marquee(
                    text:widget.Title,
                    style:TextStyle(
                        fontSize:20,
                        fontFamily: "PT Mono",
                        fontWeight:FontWeight.bold,
                        color:Colors.white
                    ),
                    scrollAxis:Axis.horizontal,
                    blankSpace:300,
                    crossAxisAlignment:CrossAxisAlignment.center,
                  )
              )
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.format_list_numbered),
              onPressed: (){
                loadAds++;
                PlayTapSound();
                Navigator.push(context,MaterialPageRoute(builder:(context)=>Main()));
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (){
                loadAds++;
                PlayTapSound();
                Navigator.of(context).pushReplacementNamed(widget.NextRoute);
              },
            ),
          ],
          bottom: new TabBar(
            controller: tabController,
            tabs: [
              Tab(icon: widget.TabIcon,text:"About"),
              Tab(icon: Icon(Icons.code,),text:"Code"),
              Tab(icon: Icon(Icons.receipt,),text:"Run"),
            ],
            onTap:(index){
              if(index==1){
                MyBanner.dispose();
              }
              else if(index==2){
                MyBanner.dispose();
              }
              else{
                ShowMyAds();
              }
            },
          ),
        ),

        body: TabBarView(
          controller: tabController,
          children: [
               About(),
               CodeView(),
               RunCode(),
          ],

        ),
      ),
    );
  }
}




class About extends StatefulWidget {
  @override
  AboutState createState() => new AboutState();
}


class AboutState extends State<About> with AutomaticKeepAliveClientMixin {

  Widget build(BuildContext context) {

    return Scaffold(
      body:
      ListView (
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(20.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                for(var item in Public_ItemList)
                  Container(child:item),



                Container (
                  padding: new EdgeInsets.only(bottom: 20.0),
                  child:
                  Card(
                    child:Container(
                      padding: new EdgeInsets.all(15.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CmpTitle(Title:"To Do Code:"),
                          Divider (color: Colors.grey,),
                          Text (
                            Public_ToDo,
                            style: TextStyle (
                              fontFamily: "PT Mono",
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox (height: 7,),
                          SizedBox (
                            width: double.infinity,
                            child:RaisedButton (
                              color: Colors.green,
                              shape: RoundedRectangleBorder (
                                borderRadius: BorderRadius.circular (30.0),
                              ),
                              child:Text(
                                "Get Me To The Code!",
                                style: TextStyle (
                                  fontFamily: "PT Mono",
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                tabController.animateTo (1);
                              },
                            ),
                          ),
                          SizedBox (height: 7,),
                        ],
                      ),
                    ),
                  ),
                ),


                Container (
                  padding: new EdgeInsets.only(bottom: 20.0),
                  child:
                  Card(
                    child:
                    Container(
                      padding: new EdgeInsets.all(15.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CmpTitle(Title:"Code Explanation",),
                          Divider (color: Colors.grey,),
                          Text (
                            Pub_Exp,
                            style: TextStyle (
                              fontFamily: "PT Mono",
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}









class CodeView extends StatefulWidget {
  @override
  CodeViewState createState() => new CodeViewState();
}
class CodeViewState extends State<CodeView> with AutomaticKeepAliveClientMixin {

  Widget build(BuildContext context) {

    return SourceCodeView(
      filePath:Public_CodeRoute,
    );
  }

  @override
  bool get wantKeepAlive => true;

}


class RunCode extends StatefulWidget {
  @override
  RunCodeState createState() => new RunCodeState();
}
class RunCodeState extends State<RunCode> with AutomaticKeepAliveClientMixin {

  Widget build(BuildContext context) {

    return Scaffold(
        body:Public_RunCodeRout
    );
  }

  @override
  bool get wantKeepAlive => true;

}











