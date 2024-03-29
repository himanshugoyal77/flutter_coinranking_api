
import 'dart:convert';

List<CoinHistory> coinHistoryFromJson(String str) => List<CoinHistory>.from(json.decode(str).map((x) => CoinHistory.fromJson(x)));

String coinHistoryToJson(List<CoinHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinHistory {
    CoinHistory({
      required  this.price,
       required this.timestamp,
    });

    String price;
    int timestamp;

    factory CoinHistory.fromJson(Map<String, dynamic> json) => CoinHistory(
        price: json["price"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "timestamp": timestamp,
    };
}
