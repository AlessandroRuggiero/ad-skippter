import 'package:ad_skipper/models/server.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Server _server;
  bool _subready = false;
  @override
  void initState() {
    super.initState();
    _server = Server();
  }
  Future<void> checkSub () async {
    print ("controllo");
    final valid = await _server.validateIp();
    print (valid);
    if (valid != _subready){
      print ("diverso");
      setState(() {
        _subready = valid;
      });
    }
   
  }
  Future <void> skipAd (BuildContext context)async{
    final alive = await _server.isAlive();
    if (alive) {
      final bool skipped = await _server.skipAd();
      print ("skipped: $skipped");
    }else {
      connectionError (context);
    }
  }


  void connectionError (BuildContext context){
    Scaffold.of (context).showSnackBar(SnackBar(content: 
    Text ("Errore di connessione")
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration( hintText: 'ip'),
          onChanged: (text){
            _server.ip = text;
          },
          onSubmitted: (text){
            checkSub();
          },
        ),
        SizedBox(height: 20,),
        FlatButton(onPressed: () async {
          await checkSub();
          if (!_subready){
            return;
          }
          await skipAd(context);
        },  child: Text ("Skip Ad"),
        color: _subready? Colors.blue : Colors.grey,
        
        )
      ],
    );
  }
}
