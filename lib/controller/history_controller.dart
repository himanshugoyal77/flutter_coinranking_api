// import 'dart:convert';

// import 'package:stock_market/model/history.dart';
// import 'package:stock_market/model/price_modal.dart';
// import 'package:http/http.dart' as http;

// class Cryptohistory {
//   List<CoinHistory> coinHistoryList = [];
//   static String baseUrl = "https://coinranking1.p.rapidapi.com/coins";

//   static const Map<String, String> headers = {
//     "Content-Type": "application/json",
//     "X-RapidAPI-Key": "5f506045admsh19d29b93bba57d7p1a7e0djsne0bcbd6bbb86",
//   };

//   void loadData() async {
//     var response = await http.get(Uri.parse(baseUrl), headers: headers);
//     List<CoinHistory> temp = coinHistoryFromJson(response.body);

//     coinHistoryList = temp;
//   }
// }
