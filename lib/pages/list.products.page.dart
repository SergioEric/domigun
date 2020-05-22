import 'package:cached_network_image/cached_network_image.dart';
import 'package:domicilios_sahagun/stying/colors.dart';
import 'package:domicilios_sahagun/utilities/format.strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/story.blok.api.dart';
import 'detail_product_page.dart';

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
                      children: products
                          .map((p) => ListTile(
                                title: Text("${p["content"]["name"]}"),
                                subtitle: Text(
                                    "\$ ${FormatString.formatPrice(p["content"]["price"])}"),
                                leading: CachedNetworkImage(
                                  imageUrl: FormatString.formatImageUrl(
                                      p["content"]["image"], "140x120"),
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context, string) {
                                    return Image.asset(
                                      "assets/design/Ellipsis-1s-200px.gif",
                                    );
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(FontAwesomeIcons.arrowRight),
                                  onPressed: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (_) =>
                                        DetailProductPage(product: p),
                                  )),
                                ),
                              ))
                          .toList(),
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

  Widget rawProduct(){
    
  }
}
