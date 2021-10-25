import 'package:flutter/material.dart';
import 'package:mvvmapi/network_service.dart';
import 'package:mvvmapi/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _postList = [];
  bool isLoading = false;

  void getPostList(String keyword) async {
    isLoading = true;
    notifyListeners();
    final data = await NetworkService().getData(keyword);
    _postList = [...data];

    isLoading = false;
    notifyListeners();
  }

  List<Post> get postList => _postList;
}
