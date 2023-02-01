import 'package:flutter/material.dart';
import 'res.dart';

void main() {
  runApp(MaterialApp(home: FirstScreen(),));
}


class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstScreenState();
  }
}
class FirstScreenState extends State<FirstScreen> {
  List<String> value = ['', '', '', '', '', '', '', '', ''];
  List<String> gridVal=['', '', '', '', '', '', '', '', ''];
  int count_box_filled = 0;
  int filled_counter=0;
  int x=0;
  int undoIndex=100;
  bool isXTurn=true;
  TextEditingController nameController_1=TextEditingController();
  TextEditingController nameController_2=TextEditingController();

  String p1="Player-1";
  String p2="Player-2";

  Color bck_color=bck_light;
  Color text_color=text_dark;

  bool isDark=false;

  Future addPlayers(){
    //retrieveFromDevice();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: const Text('Enter names',),
        content: Container(
          height: MediaQuery.of(context).size.height*0.2,
          child: Column(
            children: [
              TextFormField(
                controller: nameController_1,
                keyboardType: TextInputType.name,
                minLines: 1,
                //maxLines: 5,
                decoration: InputDecoration(
                  //border: UnderlineInputBorder(),
                    hintText: 'Player-1',
                    //hintText: ,
                    focusedBorder: InputBorder.none,
                ),
              ),
              TextFormField(
                controller: nameController_2,
                keyboardType: TextInputType.name,
                minLines: 1,
                //maxLines: 5,
                decoration: InputDecoration(
                  //border: UnderlineInputBorder(),
                  hintText: 'Player-2',
                  //hintText: ,
                  focusedBorder: InputBorder.none,
                ),
              )

            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'.toUpperCase(),),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  setState(() {
                    p1=nameController_1.text;
                    p2=nameController_2.text;
                  });
                },
                child: Text('Start'.toUpperCase(),),
              )
            ],
          )
        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    double contextWidth=MediaQuery.of(context).size.width*0.7;
    return Scaffold(
        backgroundColor: bck_color,
        appBar: AppBar(
          title: Text("Tic-Tac-Toe".toUpperCase(),
            style: TextStyle(
                color: text_color, fontWeight: FontWeight.w300),),
          centerTitle: true,
          backgroundColor: bck_color,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed:(){
                  if(isDark==false){
                    setState(() {
                      bck_color=bck_dark;
                      text_color=text_light;
                      isDark=!isDark;
                    });
                  }
                  else{
                    setState(() {
                      bck_color=bck_light;
                      text_color=text_dark;
                      isDark=!isDark;
                    });
                  }
                },
                icon: Icon(Icons.wb_sunny,color: text_color,))
          ],
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: contextWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: ()=>addPlayers(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>
                        ((states) => bck_color),
                      //textColor: Colors.white,
                      elevation: MaterialStateProperty.resolveWith<double>((states) => 10.0),
                      shadowColor: MaterialStateProperty.resolveWith((states) => text_color)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("X",style: TextStyle(color: Colors.red)),
                          Text(": $p1",style: TextStyle(color: text_color)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("O",style: TextStyle(color: Colors.indigo),),
                          Text(": $p2",style: TextStyle(color: text_color)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(50.0),
                  width: contextWidth,
                  height: contextWidth,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: MediaQuery.of(context).size.width*0.01,
                    mainAxisSpacing: MediaQuery.of(context).size.width*0.01,
                    children: List.generate(9, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: ElevatedButton(
                            //elevation: 5.0,
                              onPressed: () {
                                action(index);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>
                                  ((states) => bck_color),
                                //textColor: Colors.white,
                                elevation: MaterialStateProperty.resolveWith<double>((states) => 10.0),
                                shadowColor: MaterialStateProperty.resolveWith((states) => text_color)
                              ),
                              child: Container(
                                //margin: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                      value[index],
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        color: x==1?Colors.red:Colors.indigo,
                                      )
                                  ),
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: contextWidth*0.45,
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              //gridVal[undoIndex]='';
                              if(value[undoIndex]!='') {
                              if (x == 1) {
                                x = 0;
                              } else {
                                x = 1;
                              }
                            }
                              value[undoIndex]='';
                              count_box_filled--;
                          });
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith((states) =>
                                Size(contextWidth*0.45,
                                    MediaQuery.of(context).size.width*0.1)),
                            backgroundColor: MaterialStateProperty.resolveWith((states) => bck_color),
                            elevation: MaterialStateProperty.resolveWith((states) => 5.0),
                              shadowColor: MaterialStateProperty.resolveWith((states) => text_color)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.undo,color: Colors.indigo,),
                              Text("Undo",style: TextStyle(color: Colors.indigo),)
                            ],
                          ),
                      ),
                    ),
                    Container(
                      width: contextWidth*0.45,
                      child: ElevatedButton(
                        onPressed: ()=>reset_action(),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.resolveWith((states) =>
                              Size(contextWidth*0.45,
                                  MediaQuery.of(context).size.width*0.1)),
                          backgroundColor: MaterialStateProperty.resolveWith((states) => bck_color),
                          elevation: MaterialStateProperty.resolveWith((states) => 5.0),
                            shadowColor: MaterialStateProperty.resolveWith((states) => text_color)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.restart_alt,color: Colors.red,),
                            Text("Reset",style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }


  void reset_action() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        value[i] = '';
      }
    });
    count_box_filled = 0;
  }

  void action(index) {
    setState(() {
      if (x==0 && value[index]=='') {
        value[index] = 'o';
        count_box_filled++;
        undoIndex=index;
        x=1;
      }
      else if (x==1 && value[index]=='') {
        value[index]='×';
        count_box_filled++;
        undoIndex=index;
        x=0;
      }
      /*if (x==1) {
        x=0;
      }
      else if (x==0) {
        x=1;
      }*/
      check();
    });
  }

  void check() {
    //ROWS
    String winner;
    if(value[0]==value[1] && value[0]==value[2] && value[0]!='') {
      if(value[0]=="o") winner=p2;
      else winner=p1;
      win(winner);
      reset_action();
    }
    if(value[3]==value[4] && value[3]==value[5] && value[3]!='') {
      if(value[3]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[3]);
      reset_action();
    }
    if(value[6]==value[7] && value[6]==value[8] && value[6]!='') {
      if(value[6]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[6]);
      reset_action();
    }
    //COLUMNS
    if(value[0]==value[3] && value[0]==value[6] && value[0]!='') {
      if(value[0]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[0]);
      reset_action();
    }
    if(value[1]==value[4] && value[1]==value[7] && value[1]!='') {
      if(value[1]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[1]);
      reset_action();
    }
    if(value[2]==value[5] && value[2]==value[8] && value[2]!='') {
      if(value[2]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[2]);
      reset_action();
    }
    //DIAGONALS
    if(value[0]==value[4] && value[0]==value[8] && value[0]!='') {
      if(value[0]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[0]);
      reset_action();
    }
    if(value[2]==value[4] && value[2]==value[6] && value[2]!='') {
      if(value[2]=="o") winner=p2;
      else winner=p1;
      win(winner);
      //win(value[2]);
      reset_action();
    }
    else if(count_box_filled==9) {
      draw();
      reset_action();
    }
  }

  void win(String w) {
    var alert = AlertDialog(
      title: Center(
        child: Text(
          "$w won!",
        ),
      ),
    );
    showDialog(context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  void draw() {
    var alert = AlertDialog(
        title: Center(
          child: Text(
            "Draw!",
          ),
        )    );
    showDialog(context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }
}