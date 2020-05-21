import 'package:cached_network_image/cached_network_image.dart';
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
            Text("${this.categoryName}"),
            Expanded(
              child: FutureBuilder(
                future: api.getProductsOfCategory(uuid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> products = snapshot.data;
                    if (products.length == 0) return Text("sin productos");
                    return ListView(
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
}
