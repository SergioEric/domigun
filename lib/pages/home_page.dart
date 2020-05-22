import 'package:cached_network_image/cached_network_image.dart';
import 'package:domicilios_sahagun/stying/colors.dart';
import 'package:domicilios_sahagun/utilities/format.strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import '../api/story.blok.api.dart';
import 'detail_product_page.dart';

import 'dart:math' as math;

import 'list.products.page.dart';

class HomePage extends StatelessWidget {
  final StoryApi api = new StoryApi();
  int previousValue = 6;

  void openConnection() {
    api.getData("products");
  }

  final List<Color> colors = [
    light1.withOpacity(0.3),
    light2.withOpacity(0.3),
    light3.withOpacity(0.3),
    purple.withOpacity(0.15),
    light3.withOpacity(0.3),
  ];

  Color pickRandomColor() {
    int random = math.Random().nextInt(5);
    // print("previousValue = $previousValue");
    //nos aseguramos que no se repitan un color
    if (previousValue == random) return pickRandomColor();
    previousValue = random;
    // print("random = $random");
    return colors[random];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 36,
              width: size.width,
            ),
            Image.asset(
              "assets/design/logo.png",
              width: size.width * 0.6,
            ),
            RichText(
              text: TextSpan(
                  text: "Domicilios ",
                  style: GoogleFonts.raleway(color: color2),
                  children: [
                    TextSpan(text: "Sahagún", style: TextStyle(color: color1))
                  ]),
            ),
            SizedBox(
              // width: size.width,
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: size.width,
                ),
                Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: color2),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          FontAwesomeIcons.search,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      "Categorias",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Container(
              height: 110,
              child: FutureBuilder(
                future: api.getData("categories"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> categories = snapshot.data;
                    return ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: categories
                            .map((cat) => GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ListProductsOfCategory(
                                                  uuid: cat["uuid"],
                                                  categoryName: cat["content"]
                                                      ["name"]))),
                                  child: categoryWidget(
                                      background: pickRandomColor(),
                                      name: cat["content"]["name"]),
                                ))
                            .toList());
                  }
                  return Image.asset("assets/design/Spinner-1s-224px.gif");
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      "Agregados recientemente",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Expanded(
              child: Container(
                child: Products(productsWidget),
              ),
            )
            // MaterialButton(onPressed: (){
            //    FlutterOpenWhatsapp.sendSingleMessage("+573046797488", "Hello from flutter");
            //  },
            //    child: Text('open on whatsapp'),
            //  ),
          ],
        ),
      ),
    );
  }

  Widget categoryWidget({Color background, String name}) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: background,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(12),
            child: Icon(
              FontAwesomeIcons.hamburger,
              color: dark.withOpacity(0.2),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            child: Text(name),
          )
        ],
      ),
    );
  }

  Widget productsWidget(String name, String price, String image) {
    // CachedNetworkImage(
    //   imageUrl: "https:$image",
    // );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
            // margin: EdgeInsets.only(bottom: 10),
            // padding: EdgeInsets.all(12),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: NetworkImage("https:$image"),
            //         fit: BoxFit.fitHeight)),
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: "https:$image",
              fit: BoxFit.fitHeight,
              placeholder: (context, string) {
                return Image.asset(
                  "assets/design/Ellipsis-1s-200px.gif",
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  // height: 50,
                  // alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.6),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: dark.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "\$ $price",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class Products extends StatelessWidget {
  final Function productsWidget;
  Products(this.productsWidget);
  final StoryApi api = new StoryApi();

  void openConnection() {
    api.getData("products");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.getData("products"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("sin internet");
          }
          if (snapshot.hasData) {
            List<dynamic> posts = snapshot.data;
            // return Text("${snapshot.data}");
            return StaggeredGridView.countBuilder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetailProductPage(product: posts[index]),
                )),
                child: productsWidget(
                    posts[index]["content"]["name"],
                    FormatString.formatPrice(posts[index]["content"]["price"]),
                    posts[index]["content"]["image"]),
              ),
              itemCount: posts.length,
              crossAxisCount: 4,
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 3),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(6),
            );
          }
          return Image.asset(
            "assets/design/Bean Eater-1s-317px.gif",
            width: 200,
          );
        });
  }
}
