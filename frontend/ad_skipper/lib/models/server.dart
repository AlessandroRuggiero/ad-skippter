import 'package:http/http.dart' as http;

class Server {
  String ip;
  Server({this.ip});
  bool get validIp {
    if (ip != null && ip != "") return true;
    return false;
  }

  Future<bool> validateIp () async {
    print("sto validando l ip");
    if (!validIp)
      return false;
    print ("versifico oltre...");
    final alive = await isAlive();
    print ("dal server mi dicono $alive");
    return alive;
  }

  Future<bool> isAlive() async {
    try {
      final http.Response response = await http.get(url + "/isAlive").timeout(Duration (seconds: 1));
      print (response.body);
      return true;
    } catch (e) {
      print ("errore");
      return false;
    }
  }

  String get url {
    return "http://192.168.1.${ip}:5000";
  }

  Future <bool> skipAd () async {
    try {
      http.post(url + "/skipAd");
      return true;
    }catch (e){
      return false;
    }
  }

}
