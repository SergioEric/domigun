import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  final dynamic product;

  DetailProductPage({this.product});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      // fit: StackFit.expand,
      children: <Widget>[
        // Image.network("src"),
        // Image(
        //     image: CachedNetworkImageProvider(
        //         "https:${product["content"]["image"]}")),
        CachedNetworkImage(
          imageUrl: "https:${product["content"]["image"]}",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fitHeight,
          width: double.infinity,
          height: size.height * 0.7,
        ),
      ],
    ));
  }
}
