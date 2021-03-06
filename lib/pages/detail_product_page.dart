import 'package:cached_network_image/cached_network_image.dart';
import 'package:domicilios_sahagun/stying/colors.dart';
import 'package:domicilios_sahagun/utilities/format.strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../api/story.blok.api.dart';

class DetailProductPage extends StatefulWidget {
  final dynamic product;

  DetailProductPage({this.product});

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final StoryApi api = new StoryApi();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
      // physics: BouncingScrollPhysics(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: "https:${widget.product["content"]["image"]}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fitHeight,
                width: double.infinity,
                height: size.height * 0.65,
              ),
              Container(
                // decoration: BoxDecoration(
                //     color: dark.withOpacity(0.4), shape: BoxShape.circle),
                margin: EdgeInsets.only(top: 35),
                child: RawMaterialButton(
                    padding: EdgeInsets.all(12),
                    shape: CircleBorder(),
                    fillColor: dark.withOpacity(0.4),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: light1)),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Descripción",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Text(
                      "${widget.product["content"]["description"]}",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 10),
            // alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: light1, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        widget.product["content"]["name"],
                        style: TextStyle(
                            color: color1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$ ${FormatString.formatPrice(widget.product["content"]["price"])}",
                        style: TextStyle(
                            color: dark.withOpacity(1),
                            fontSize: 25,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  // height: 100,
                  decoration: BoxDecoration(
                      color: light2.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "¡Lo vende!",
                        style: TextStyle(
                            color: dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                        future: api.getLocalOfProduct(
                            widget.product["content"]["local"]),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  height: 21,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "${snapshot.data["content"]["name"]}",
                                        style: TextStyle(
                                            color: dark, fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          // width: size.width * 0.5,
                                          child: Text(
                                            "Whatsapp",
                                            style: TextStyle(color: color1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            FlutterOpenWhatsapp.sendSingleMessage(
                                                "+57 ${snapshot.data["content"]["phoneNumber"]}",
                                                "Hello from flutter");
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.whatsapp,
                                            color: color1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          // width: size.width * 0.5,
                                          child: Text(
                                            "Ubicación del lugar",
                                            style: TextStyle(
                                                color: Color(0xffFF6C6C)),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              MapsLauncher.launchCoordinates(
                                                  num.parse(snapshot
                                                              .data["content"]
                                                          ["location"][0]
                                                      ["latitude"]),
                                                  num.parse(
                                                      snapshot.data["content"]
                                                              ["location"][0]
                                                          ["longitude"])),
                                          icon: Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Color(0xffFF6C6C),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                          return Container(
                              height: 21,
                              width: 21,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
