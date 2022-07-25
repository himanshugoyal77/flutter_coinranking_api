import 'dart:convert';

import 'package:stock_market/model/price_modal.dart';
import 'package:http/http.dart' as http;

class CryptoApi {
  static String baseUrl = "https://coinranking1.p.rapidapi.com";

  static const Map<String, String> headers = {
    "Content-Type": "application/json",
    "X-RapidAPI-Key": "5f506045admsh19d29b93bba57d7p1a7e0djsne0bcbd6bbb86",
  };

  static Future<List<Coin>> getCoins() async {
    List<Coin> coinList = [];
    var url = Uri.parse("$baseUrl/coins?limit=26");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var coins = jsonDecode(response.body)["data"]["coins"];
      for (var coin in coins) {
        coinList.add(Coin.fromJson(coin));
      }
    }
    return coinList;
  }
}
