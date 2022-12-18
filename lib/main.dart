import 'dart:convert';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:crud_api_product_list/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//THIRD
/* Convert the response into a custom dart object */
// Step:1
/* Create an Product class */
// ==> (product_model.dart)
// Step:2
/* Convert the htt.Response to a Product */
List<Product> productList = [];
Future<List<Product>> fetchProduct() async {
  final response = await http.get(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list"));

  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    productList.clear();
    for (Map i in data) {
      productList.add(Product.fromJson(i));
    }
    return productList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception("Failed to load Product.");
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Product List From The Server',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Fetch Product List From The Server'),
    );
  }
}
