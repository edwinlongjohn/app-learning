import 'package:bitcoin_ticker/services/networking.dart';

class CurrencyRate {
  Future<dynamic> getExchange(coin, currency) async {
    Uri uri = Uri.https('rest.coinapi.io', '/v1/exchangerate/$currency/$coin');

    Network network = Network(url: uri);
    var data = await network.fetchData();
    return data;
  }
}
