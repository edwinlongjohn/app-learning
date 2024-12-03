import 'dart:convert';
import 'package:http/http.dart' as http;

const String key = 'AD9FB29C-480C-4440-8384-1C675D057348';

class Network {
  dynamic url;
  final header = {
    'Accept': 'text/plain',
    'X-CoinAPI-Key': key,
  };
  Network({required this.url});

  Future<dynamic> fetchData() async {
    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        return 'not found';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
