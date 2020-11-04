import 'package:flutter/material.dart';

class SecondSkipper extends StatefulWidget {
  final String title;
  final bool ready;
  final Color color;
  final Future<void> Function (BuildContext,int) onPressed;
  final Future<bool> Function () check;
  SecondSkipper ({this.ready = false, this.color, this.onPressed,@required this.check, this.title});
  @override
  _SecondSkipperState createState() => _SecondSkipperState();
}

class _SecondSkipperState extends State<SecondSkipper> {
  double _seconds;
  @override
  void initState() {
    _seconds = 5;
    super.initState();
  }

  void onSkip () async {
  print ("conreollo");
    final bool attivo = await widget.check();
    print ("il bottene pensa che sia ${widget.ready}");
    if (!attivo){
      return;
    }
    widget.onPressed (context,_seconds.round());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          activeColor: widget.ready ?widget.color: Colors.grey,
          value: _seconds,
          min: 5,
          max: 60,
          divisions: 11,
          onChangeStart: (double value) {
            print ("valore: $value");
            widget.check();
          },
          label: _seconds.round().toString(),
          onChanged: (double value) {
            setState(() {
              _seconds = value;
            });
          },
        ),
      RaisedButton (
        color: widget.ready ?widget.color: Colors.grey,
        child:Text (widget.title),
        onPressed: onSkip,
      )
      ],
    );
  }
}
