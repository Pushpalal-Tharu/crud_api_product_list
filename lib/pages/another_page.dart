import 'dart:convert';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductAdded extends StatefulWidget {
  Product? plist;

  ProductAdded.first(
    List<Product> productList, {
    super.key,
    this.plist,
  });

  ProductAdded.second({super.key});

  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

class _ProductAddedState extends State<ProductAdded> {
  late var productIdController =
      TextEditingController(text: widget.plist?.id.toString());
  late var productNameController =
      TextEditingController(text: widget.plist?.name.toString());

  late var productDescriptionController =
      TextEditingController(text: widget.plist?.desc.toString());

  late var productPriceController =
      TextEditingController(text: widget.plist?.price.toString());

  Future<Product>? _futureProduct;

  final _formKey = GlobalKey<FormState>();
  //
  //
  //
  //
  //
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

  //
  //
  //
  //
  //
  // Put Method code.
  Future<Product> updateProduct(
      int? id, String name, String desc, int price) async {
    final response = await http.put(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list/$id"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "desc": desc,
        "price": price,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("Failed to update product.");
    }
  }

  //
  //
  //
  //
  //

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
                            child: Text(getButtonTitle()),
                            onPressed: () {
                              setState(() {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar.
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(SnackBar(content: Text("Sending")));
                                  // In the real world, you'd often call a server or save the information in a database.
                                  _futureProduct = addUpdate();
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

  String getButtonTitle() {
    if (widget.plist != null) {
      return "Update";
    } else {
      return "Add";
    }
  }

  Future<Product>? addUpdate() {
    if (widget.plist != null) {
      return updateProduct(
        widget.plist!.id,
        productNameController.text.toString(),
        productDescriptionController.text.toString(),
        int.parse(productPriceController.text.toString()),
      );
    } else {
      return addProduct(
        productNameController.text.toString(),
        productDescriptionController.text.toString(),
        int.parse(productPriceController.text.toString()),
      );
    }
  }
}
