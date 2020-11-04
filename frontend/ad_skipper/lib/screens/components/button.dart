import 'package:flutter/material.dart';

class ActivateButton extends StatelessWidget {
  final bool active;
  final Future<void> Function (BuildContext) onPressed;
  final Future<bool> Function () check;
  final String title;
  final Color activeColor;

  ActivateButton ({this.active = false,this.onPressed,this.title,this.check,this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: RaisedButton(onPressed: () async {
              final bool attivo = await check();
              print ("il bottene pensa che sia $active");
              if (!attivo){
                return;
              }
              await onPressed(context);
            },  child: Text (title),
            color: active? activeColor : Colors.grey,
            ),
      ),
    );
  }
}