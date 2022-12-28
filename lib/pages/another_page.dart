import 'dart:convert';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductAdded extends StatefulWidget {
  final Product plist;

  ProductAdded(
    List<Product> productList, {
    super.key,
    required this.plist,
  });

  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

class _ProductAddedState extends State<ProductAdded> {
  late var productNameController =
      TextEditingController(text: widget.plist.name.toString());

  late var productDescriptionController =
      TextEditingController(text: widget.plist.desc.toString());

  late var productPriceController =
      TextEditingController(text: widget.plist.price.toString());

  Future<Product>? _futureProduct;

  final _formKey = GlobalKey<FormState>();

  // Post method code.
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
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Image.network(widget.plist.image.toString()),
                        Text(widget.plist.name.toString()),
                        Text(widget.plist.desc.toString()),
                        Text("\$" + widget.plist.price.toString()),

                        //
                        TextFormField(
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter product name';
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
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter product description.';
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
                              return 'Enter product price.';
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
                            child: Text("Add"),
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
                                    productDescriptionController.text
                                        .toString(),
                                    int.parse(
                                        productPriceController.text.toString()),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
