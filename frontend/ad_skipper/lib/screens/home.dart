import 'package:ad_skipper/models/server.dart';
import 'package:ad_skipper/screens/components/controlPaned.dart';
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
  Future<bool> checkSub () async {
    print ("controllo");
    final valid = await _server.validateIp();
    print (valid);
    if (valid != _subready){
      print ("diverso");
      setState(() {
        _subready = valid;
      });
    }
   return _subready;
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
        ControlPanel(
          check: checkSub,
          ready: _subready,
          server: _server,
        )
      ],
    );
  }
}
