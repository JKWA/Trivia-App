import 'package:flutter/material.dart';
import './trivia_page.dart';
import '../utilities/data_types.dart';

class LandingPage extends StatefulWidget {

  const LandingPage({Key key,}) : super(key: key);
    

  _LandingPageState createState() => new _LandingPageState();

}

class _LandingPageState extends State<LandingPage> {

  TriviaDifficulty difficulty;
  String type;
  double numberOfItems;

  @override
  void initState() {
    super.initState();
    difficulty = TriviaDifficulty.EASY;
    numberOfItems = 8.0;
    
  }

  @override
  Widget build(BuildContext context) {

     _getDropdownItems(){
       TriviaDifficulty.EASY;
       
      List <List> items = [['Easy',TriviaDifficulty.EASY], ['Medium', TriviaDifficulty.MEDUIM], ['Hard', TriviaDifficulty.HARD]];
      List <DropdownMenuItem> dropdownItems = [];
      for (List item in items){
        dropdownItems.add(new DropdownMenuItem(
            child: new Text(
                item[0],
                style: new TextStyle(color: Colors.white, fontSize: 25.0,),
                ),

            value: item[1]
          )
        );
      }
      return dropdownItems;
    }

    
    return  new Theme(
      data: new ThemeData( 
        primaryColor: Colors.redAccent, 
        canvasColor: Colors.redAccent,
        accentColor: Colors.white,
        accentIconTheme: new IconThemeData(color:Colors.white),
        buttonColor: Colors.redAccent,
        
       ),
      child: new Material(
     
      child: new InkWell(
        
       
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Text(
                  "Trivia", 
                  style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
              padding: new EdgeInsets.only(top:20.0, right: 10.0, bottom:20.0, left:10.0),

            ),

            new Container(
              child: new Text(
                  "# questions:\ "+ numberOfItems.toInt().toString(), 
                  style: new TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
              padding: new EdgeInsets.only(top:20.0, right: 10.0, bottom:20.0, left:10.0),

            ),
            // new Text("Tap to begin", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            new Container(
              width: 200.0,
              padding: new EdgeInsets.only(top:20.0, right: 10.0, bottom:20.0, left:10.0),

              child: new Slider(
                  value: numberOfItems, 
                  max:10.0, 
                  min:1.0,
                  onChanged: (value){
                      setState(() { 
                        numberOfItems = value.roundToDouble();
                      });
                    }
                )
            ),
            new DropdownButton(
                  style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold ,),
                  iconSize: 30.0,
                  items:_getDropdownItems(), 
                  value: difficulty, 
                  onChanged: (value){
                          setState(() { 
                            difficulty = value;
                          });
                  },
              ),
            new FlatButton(
              child: new Text(
                  'BEGIN',
                  style: new TextStyle(color: Colors.white, fontSize: 30.0 ,),
                ),
              padding: new EdgeInsets.only(top:40.0, right: 10.0, bottom:20.0, left:10.0),
              onPressed: () =>
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (BuildContext context) => new TriviaPage(numberOfItems: numberOfItems.toInt(), difficulty: difficulty,)
                  )
              ),
            )
          ],
        ),
      ),
      ),
    
    );
   
  }



}