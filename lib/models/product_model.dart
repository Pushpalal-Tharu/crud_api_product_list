// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.color,
    required this.image,
  });

  final int id;
  final String name;
  final String desc;
  final int price;
  final String color;
  final String image;

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        desc: json["desc"] == null ? null : json["desc"],
        price: json["price"] == null ? null : json["price"],
        color: json["color"] == null ? null : json["color"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "desc": desc == null ? null : desc,
        "price": price == null ? null : price,
        "color": color == null ? null : color,
        "image": image == null ? null : image,
      };
}


// [
//     {
//         "id": 1,
//         "name": "iphone 12 pro",
//         "desc": "Apple iphone 12th generation",
//         "price": 999,
//         "color": "#33505a",
//         "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/refurb-iphone-12-pro-gold-2020?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1635202844000"
//     },
//     {
//         "id": 2,
//         "name": "Pixel 5",
//         "desc": "Google Pixel phone 5th generation",
//         "price": 699,
//         "color": "#00ac51",
//         "image": "https://m.media-amazon.com/images/I/614J-390CfL.jpg"
//     },
//     {
//         "id": 3,
//         "name": "M1 Macbook Air",
//         "desc": "Apple Macbook air with apple silicon",
//         "price": 1099,
//         "color": "#we0bfae",
//         "image": "https://media.ldlc.com/r374/ld/products/00/05/81/99/LD0005819990_1_0005905278_0005925774.jpg"
//     },
//     {
//         "id": 4,
//         "name": "Playstation 5",
//         "desc": "Sony Playstation 5th generation",
//         "price": 500,
//         "color": "#544ee4",
//         "image": "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4cbf22d2-d414-47b2-8561-8b0741d51ce8/deev4xr-6fe476be-a600-4a47-84ab-5cedb742c7fa.jpg/v1/fill/w_1280,h_1280,q_75,strp/sony_playstation_5___ps5_4k_wallpaper_by_tkasabov2_deev4xr-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTI4MCIsInBhdGgiOiJcL2ZcLzRjYmYyMmQyLWQ0MTQtNDdiMi04NTYxLThiMDc0MWQ1MWNlOFwvZGVldjR4ci02ZmU0NzZiZS1hNjAwLTRhNDctODRhYi01Y2VkYjc0MmM3ZmEuanBnIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.7MmXGmDRSnuImxqmleuU0D7X8zFr7p-KkLnxesSQvwE"
//     },
//     {
//         "id": 5,
//         "name": "Airpods Pro",
//         "desc": "Apple Airpods Pro 1st generation",
//         "price": 200,
//         "color": "#e3e4e9",
//         "image": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1660803972361"
//     },
//     {
//         "id": 6,
//         "name": "iPad pro",
//         "desc": "Apple iPad Pro 2020 edition",
//         "price": 799,
//         "color": "#f73984",
//         "image": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-ipad-pro-12-wifi-spacegray-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626721066000"
//     },
//     {
//         "id": 7,
//         "name": "Galaxy S21 Ultra",
//         "desc": "Samsung Galaxy S21 Ultra 2021 edition",
//         "price": 1299,
//         "color": "#1c1c1c",
//         "image": "https://images.samsung.com/is/image/samsung/p6pim/ca/galaxy-s21/gallery/ca-galaxy-s21-ultra-5g-g988-sm-g998wzkaxac-368336281"
//     },
//     {
//         "id": 8,
//         "name": "Galaxy S21",
//         "desc": "Samsung Galaxy S21 2021 edition",
//         "price": 899,
//         "color": "#7c95eb",
//         "image": "https://images.samsung.com/is/image/samsung/p6pim/in/galaxy-s21/gallery/in-galaxy-s21-5g-g991-371114-371114-sm-g991bzadinu-368757494"
//     }
// ]

