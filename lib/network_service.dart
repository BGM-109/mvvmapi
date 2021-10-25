import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mvvmapi/post.dart';

class NetworkService {
  static const apiKey = "7330360-e350122288fab0405c64b3e9f";

  Future<List<Post>> getData(String keyword) async {
    var url =
        "https://pixabay.com/api/?key=$apiKey&q=$keyword&image_type=photo&pretty=true";
    var uri = Uri.parse(url);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        List<dynamic> hits = jsonResponse["hits"];
        List<Post> result = hits.map((post) => Post.fromJson(post)).toList();
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}