import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String preUrl = 'https://rest.coinapi.io/v1/exchangerate';
  String apiKey = 'FA99103A-FC83-41E1-94B1-04D6AF582ABA';
  String selectedCurrency;
  String selectedCrypto;

  CoinData({this.selectedCurrency, this.selectedCrypto});

  Future<dynamic> getCoinData() async {
    http.Response response = await http.get(
        Uri.parse('$preUrl/$selectedCrypto/$selectedCurrency?apikey=$apiKey'));

    if (response.statusCode == 200) {
      var coinRate = jsonDecode(response.body);
      print(coinRate);
      return coinRate;
    } else {
      print(response.statusCode);
      return;
    }
  }
}
