import 'package:cached_network_image/cached_network_image.dart';
import 'package:domicilios_sahagun/stying/colors.dart';
import 'package:domicilios_sahagun/utilities/format.strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/story.blok.api.dart';
import 'detail_product_page.dart';

import 'dart:math' as math;

class ListProductsOfCategory extends StatelessWidget {
  final String uuid;
  final String categoryName;

  final StoryApi api = new StoryApi();

  ListProductsOfCategory({this.uuid, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text("${this.categoryName}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24, color: purple)),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder(
                future: api.getProductsOfCategory(uuid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> products = snapshot.data;
                    if (products.length == 0) return noProducts();
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children:
                          products.map((p) => rawProduct(p, context)).toList(),
                    );
                  }
                  return Image.asset("assets/design/Spinner-1s-224px.gif");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget noProducts() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 90),
      child: Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color2, shape: BoxShape.circle),
            child: Icon(
              FontAwesomeIcons.info,
              color: dark,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Sin Productos Agregados",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }

  final List<Color> colors = [
    light1.withRed(randomBetween255()),
    light2.withRed(randomBetween255()),
    light3.withRed(randomBetween255()),
    purple.withRed(randomBetween255()),
    light3.withRed(randomBetween255()),
  ];

  static int randomBetween255() {
    int random = math.Random().nextInt(255);
    return random;
  }

  Color pickRandomColor() {
    int random = math.Random().nextInt(5);
    return colors[random];
  }

  Widget rawProduct(dynamic product, BuildContext context) {
    return Container(
      width: 152,
      height: 147,
      margin: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: FormatString.formatImageUrl(
                  product["content"]["image"], "152x147"),
              fit: BoxFit.fitHeight,
              placeholder: (context, string) {
                return Image.asset(
                  "assets/design/Ellipsis-1s-200px.gif",
                );
              },
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product["content"]["name"],
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  "\$ ${FormatString.formatPrice(product["content"]["price"])}",
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.arrowRight,
                      color: pickRandomColor()),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailProductPage(product: product),
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
