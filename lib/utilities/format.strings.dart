class FormatString {
  static String formatPrice(String price) {
    List<String> formated = price.split("");
    if (price.length > 5) {
      formated.insert(3, ".");
    } else if (price.length > 4) {
      formated.insert(2, ".");
    } else {
      formated.insert(1, ".");
    }
    return formated.join("");
  }

  static String formatImageUrl(String url, String resolution) {
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
  }
}
