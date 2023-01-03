import 'dart:async';
import 'dart:convert';
import 'package:crud_api_product_list/pages/another_page.dart';
import 'package:crud_api_product_list/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:crud_api_product_list/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//FOURTH
/* Fetch the data */
  late Future<List<Product>> futureProduct;
  void initState() {
    super.initState();
    futureProduct = fetchProduct();
  }

// List of products coming from api.
  List<Product> productList = [];

// Future fuction used to fetch data from the server.
// It is also used to refresh the home page.
  Future<List<Product>> fetchProduct() async {
    // Encoded data from the api.
    final response = await http.get(
        Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list"));
    // Decoded data
    var data = jsonDecode(response.body);
    // clearing the list item.

    productList.clear();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // productList.clear();
      for (Map i in data) {
        setState(() {
          productList.add(Product.fromJson(i));
        });
      }
      return productList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("Failed to load Product.");
    }
  }

  // Delete Method code.
  Future<Product> deleteProduct(String id) async {
    final http.Response response = await http.delete(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/product_list/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to delete product.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome${LoginPageState.KEYNAME}"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductAdded.second()),
            );
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: fetchProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return Text(snapshot.data!.name);

                    return RefreshIndicator(
                      onRefresh: fetchProduct,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),

                        // Length of the list
                        itemCount: productList.length,

                        // To make listView scrollable
                        // even if there is only a single item.
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // return Text(index.toString());
                          // return Text(productList[index].name.toString());

                          // List Item
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAdded.first(
                                        productList,
                                        plist: productList[index])),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              margin: EdgeInsets.all(10),
                              color: Colors.white70,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Image.network(
                                        "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/refurb-iphone-12-pro-gold-2020?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1635202844000"

                                        // productList[index].image.toString(),
                                        // width: 50,
                                        // height: 50,
                                        // fit: BoxFit.cover,

                                        ),
                                    title: Text(
                                        productList[index].name.toString()),
                                    subtitle: Text(
                                        productList[index].desc.toString()),
                                    trailing: Container(
                                      width: 90,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              "\$" +
                                                  productList[index]
                                                      .price
                                                      .toString()),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  futureProduct = deleteProduct(
                                                          snapshot
                                                              .data![index].id
                                                              .toString())
                                                      as Future<List<Product>>;
                                                });
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
