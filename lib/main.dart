import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var tiles=List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          AspectRatio(aspectRatio: 1,child: GridView.count(crossAxisCount: 3,
            children: [
              for(var i=0; i<9; i++) InkWell(
                  onTap: () {

                    setState((){
                      tiles[i]=1;
                      runAi();
                    });
                  },
                  child: Center(child: Text(tiles[i]==0?'':tiles[i]==1?'x':'0')))

            ],
          ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(isWinning(1, tiles)?'You Won':isWinning(2,tiles)?'You lost!':'Your Move'),
              OutlinedButton(onPressed: () {
                setState((){
                  tiles=List.filled(9, 0);
                });
              }, child: Text('Reatart'))
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void runAi() async{
    await Future.delayed(Duration(milliseconds: 200));

    int? winning;
    int? bloking;
    int? normal;

    for(var i=0; i<9; i++){
      var val=tiles[i];

      if(val>0){
        continue;
      }
       var future=[...tiles]..[i]=2;

      if(isWinning(1,future)){
        winning=i;
      }
      future[i]=1;

      if(isWinning(2,future)){
        bloking=i;
      }
      normal=i;
    }
    var move=winning??bloking??normal;

    if(move!=null){
      setState((){
        tiles[move]=2;
      });
    }
  }
  bool isWinning(int who,List<int> tiles){
    return (tiles[0]=who || tiles[1]=who  || tiles[2] =who);
         /* (tiles[3]=who && tiles[4]=who  && tiles[5] =who)||
          (tiles[6]=who && tiles[1]=who  && tiles[2] =who)||
          (tiles[0]=who && tiles[1]=who  && tiles[2] =who)||
          (tiles[0]=who && tiles[1]=who  && tiles[2] =who)||
          (tiles[0]=who && tiles[1]=who  && tiles[2] =who)||
          (tiles[0]=who && tiles[1]=who  && tiles[2] =who);*/

  }
}
