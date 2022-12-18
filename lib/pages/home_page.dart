import 'package:crud_api_product_list/pages/product_added_to_next_page.dart';
import 'package:flutter/material.dart';

import 'package:crud_api_product_list/main.dart';
import 'package:crud_api_product_list/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductAdded(),
              ));
        },
        tooltip: 'Move to another page',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return Text(snapshot.data!.name);

                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      // return Text(index.toString());
                      // return Text(productList[index].name.toString());
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.all(10),
                        color: Colors.white70,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.network(
                                productList[index].image.toString(),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(productList[index].name.toString()),
                              subtitle:
                                  Text(productList[index].desc.toString()),
                              trailing: Text(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  "\$" + productList[index].price.toString()),
                            ),
                            // Container(
                            //   alignment: Alignment.bottomRight,
                            //   child: ElevatedButton(
                            //     onPressed: () {},
                            //     child: Icon(Icons.add),
                            //   ),
                            // )

                            // Text("${index + 1}"),
                          ],
                        ),
                      );
                    },
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
    );
  }
}
