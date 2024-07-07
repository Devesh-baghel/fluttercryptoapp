import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List currencies = await getCurrencies();
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List currencies;

  MyApp(this.currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade500)),
      home: Homepage(currencies),
    );
  }
}

Future<List> getCurrencies() async {
  final String _apiKey = '2eacaa38-adbe-4888-8aca-536b1b5c2fe7';
  String cryptoUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";

  final response = await http.get(Uri.parse(cryptoUrl), headers: {
    'X-CMC_PRO_API_KEY': _apiKey,
    'Accept': 'application/json',
  });

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['data'];
  } else {
    throw Exception('Failed to load currencies');
  }
}
