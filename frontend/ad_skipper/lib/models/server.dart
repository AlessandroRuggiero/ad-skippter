import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Server {
  String ip;
  Server({this.ip});
  bool get validIp {
    if (ip == null || ip == "" || !isNumeric(ip)) return false;
    if (ip.length > 4 || ip.length == 0) return false;
    return true;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  Future<bool> validateIp() async {
    print("sto validando l ip");
    if (!validIp) return false;
    print("versifico oltre...");
    final alive = await isAlive();
    print("dal server mi dicono $alive");
    return alive;
  }

  Future<bool> isAlive() async {
    try {
      final http.Response response =
          await http.get(url + "/isAlive").timeout(Duration(seconds: 1));
      print(response.body);
      return true;
    } catch (e) {
      print("errore");
      return false;
    }
  }

  String get url {
    return "http://192.168.1.${ip}:5000";
  }

  Future<bool> simpleRequest(String section) async {
    try {
      await http.post(url + section).timeout(Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> skipAd() async {
    return await simpleRequest("/skipAd");
  }

  Future<bool> closeAd() async {
    return await simpleRequest("/closeAd");
  }

  Future<bool> closeSmallAd() async {
    return await simpleRequest("/closeSmallAd");
  }

  Future<bool> skipSeconds(int seconds) async {
    print ("skippo i secondi");
    for (int i = 0; i< seconds/5; i++){
      final succ = await simpleRequest("/skipSeconds");
      if (!succ) 
        return false;
    }
    return true;
  }
}
