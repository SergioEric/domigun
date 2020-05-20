import 'dart:convert';
import 'package:http/http.dart' as http;

class StoryApi {
  final String key = "uRUarIQHz68x42fdpoqSXgtt";
  final String tokenDomigun = "bQDh3n2ptoqW164617yRtgtt";
  final String baseUrl = "https://api.storyblok.com/v1/cdn";

  Future<List<dynamic>> getData(String filterByComponent) async {
    print(filterByComponent);
    //, headers:(filterByComponent!=null) ? headers : null
    http.Response json = await http.get(
        "$baseUrl/stories?version=draft&token=$tokenDomigun&starts_with=$filterByComponent");

    if (json.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(json.body);
      // print(body["stories"][0]);
      print(body["stories"]);
      return body["stories"];
    }
    return null;
  }

  Future<dynamic> getLocalOfProduct(String locaId) async {
    print("···········getLocalOfProduct·············");
    print("··········· $locaId ·············");
    http.Response json = await http.get(
        "$baseUrl/stories/$locaId?version=draft&token=$tokenDomigun&find_by=uuid");
    if (json.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(json.body);
      print(body["story"]);
      return body["story"];
    }
    return null;
  }
}
