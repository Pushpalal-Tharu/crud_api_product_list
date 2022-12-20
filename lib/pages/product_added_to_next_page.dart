import 'dart:convert';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductAdded extends StatefulWidget {
  const ProductAdded({super.key});
  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

Future<Product> addProduct(String name, String desc) async {
  final response = await http.post(
    Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list"),
    headers: <String, String>{
      'content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": name,
      "desc": desc,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.

    throw Exception("Failed to add product.");
  }
}

class _ProductAddedState extends State<ProductAdded> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<Product>? _futureProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go Back"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product name must be entered.";
                      }
                      return null;
                    },
                    controller: productNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter product name.",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product description must be entered.";
                      }
                      return null;
                    },
                    controller: productDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter product description."),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Price must be entered.";
                      }
                      return null;
                    },
                    controller: productPriceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the price in number.",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 40,
                    width: 20,
                    child: ElevatedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        setState(() {
                          _futureProduct = addProduct(
                              productNameController.text.toString(),
                              productDescriptionController.text.toString());
                        });
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
