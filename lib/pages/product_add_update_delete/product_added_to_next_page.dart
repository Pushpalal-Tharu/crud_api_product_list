import 'dart:convert';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductAdded extends StatefulWidget {
  const ProductAdded({super.key});
  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

class _ProductAddedState extends State<ProductAdded> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();

  Future<Product>? _futureProduct;

  final _formKey = GlobalKey<FormState>();

  Future<Product> addProduct(String name, String desc, int price) async {
    final response = await http.post(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "desc": desc,
        "price": price,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception("Failed to add product.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go Back"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
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
                    return 'Please enter some text';
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
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
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
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar.
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(content: Text("Sending")));
                        // In the real world, you'd often call a server or save the information in a database.
                        _futureProduct = addProduct(
                          productNameController.text.toString(),
                          productDescriptionController.text.toString(),
                          int.parse(productPriceController.text.toString()),
                        );
                        // defaul textfield value
                        productNameController.clear();
                        productDescriptionController.clear();
                        productPriceController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
