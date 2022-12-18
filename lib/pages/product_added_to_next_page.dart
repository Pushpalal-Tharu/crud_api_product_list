import 'package:crud_api_product_list/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductAdded extends StatefulWidget {
  const ProductAdded({super.key});

  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

class _ProductAddedState extends State<ProductAdded> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go Back"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product name must be entered.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter product name.",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product description must be entered.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter product description."),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Price must be entered.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter the price in number.",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Adding product to the list.")));
                  }
                },
                child: Text("Save"),
              )
            ],
          )),
    );
  }
}
