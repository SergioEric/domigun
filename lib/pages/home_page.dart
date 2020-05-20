import 'package:cached_network_image/cached_network_image.dart';
import 'package:domicilios_sahagun/stying/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import '../api/story.blok.api.dart';
import 'detail_product_page.dart';

class HomePage extends StatelessWidget {
  final StoryApi api = new StoryApi();

  void openConnection() {
    api.getData("products");
  }

  String formatImageUrl(String url, String resolution) {
    // return "https:$url";
    // String url =
    //     "//a.storyblok.com/f/84282/1280x853/e989585237/campfire-1031141_1280.jpg";
    String formatedUrl;
    List<String> splited = url.split("/");
    splited.removeAt(2);
    splited.insert(2, "img2.storyblok.com");
    splited.insert(
      3,
      resolution,
    );
    formatedUrl = splited.join("/");
    return "https:$formatedUrl";
    // print(splited);
    // print(splited.join("/"));
    // print("object");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   width: double.infinity,
            // ),
            // FlatButton(
            //   onPressed: openConnection,
            //   child: Text("call api"),
            // ),
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
              // fit: StackFit.expand,
              // alignment: Alignment.centerRight,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: size.width,
                ),
                Container(
                  // alignment: Alignment.centerRight,
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
            Container(
              height: 110,
              // margin: EdgeInsets.all(12),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i) => categoryWidget(),
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
            // Expanded(
            //   child: FutureBuilder(
            //       future: api.getData("products"),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.none) {
            //           return Text("sin internet");
            //         }
            //         if (snapshot.hasData) {
            //           List<dynamic> posts = snapshot.data;
            //           // return Text("${snapshot.data}");
            //           return StaggeredGridView.countBuilder(
            //             itemBuilder: (context, index) => productsWidget(
            //                 posts[index]["content"]["name"],
            //                 posts[index]["content"]["price"],
            //                 posts[index]["content"]["image"]),
            //             itemCount: posts.length,
            //             crossAxisCount: 4,
            //             staggeredTileBuilder: (int index) =>
            //                 new StaggeredTile.count(2, index.isEven ? 2 : 3),
            //             mainAxisSpacing: 4.0,
            //             crossAxisSpacing: 4.0,
            //           );
            //         }
            //         return Container();
            //       }),
            // )
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

  Widget categoryWidget() {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: dark.withOpacity(0.09),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(12),
            child: Icon(
              FontAwesomeIcons.hamburger,
              color: color1,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            child: Text("Comida Rápidaaaa"),
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
                padding: EdgeInsets.all(2),
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
                    posts[index]["content"]["price"],
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
          return Container();
        });
  }
}
