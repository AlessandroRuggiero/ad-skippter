import 'package:ad_skipper/models/server.dart';
import 'package:ad_skipper/screens/components/secondSkipper.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class ControlPanel extends StatelessWidget {
  final Future<void> Function() check;
  final bool ready;
  final Server server;

  ControlPanel(
      {@required this.check, this.ready = false, @required this.server});

  Future<void> skipAd(BuildContext context) async {
    final bool skipped = await server.skipAd();
    if (!skipped) {
      connectionError(context);
    }
  }

  Future<void> closeAd(BuildContext context) async {
    final bool closed = await server.closeAd();
    if (!closed) {
      connectionError(context);
    }
  }

  Future<void> closeSmallAd(BuildContext context) async {
    final bool closed = await server.closeSmallAd();
    if (!closed) {
      connectionError(context);
    }
  }

  Future<void> skipSeconds(BuildContext context,int seconds) async {
    final bool skipped = await server.skipSeconds(seconds);
    if (!skipped)
      connectionError(context);
  }

  void connectionError(BuildContext context) {
    print("Il serevr non risponde");
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Il server non risponde")));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ActivateButton(
              active: ready,
              onPressed: skipAd,
              check: check,
              activeColor: Colors.blue,
              title: "Skip Ad",
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActivateButton(
              active: ready,
              onPressed: closeSmallAd,
              check: check,
              activeColor: Colors.green,
              title: "Chiudi Ad Piccolo",
            ),
            ActivateButton(
              active: ready,
              onPressed: closeAd,
              check: check,
              activeColor: Colors.red,
              title: "Chiudi Ad Medio",
            ),
          ],
        ),
        SecondSkipper(
          ready:ready,
          color: Colors.purpleAccent,
          onPressed: skipSeconds,
          check:check ,
          title : "Skip"
        )
      ],
    );
  }
}
