class Post {
  Post({
    required this.id,
    required this.tags,
    required this.previewURL,
  });
  late final int id;
  late final String tags;
  late final String previewURL;


  Post.fromJson(Map<String, dynamic> json){
    id = json['id'];
    tags = json['tags'];
    previewURL = json['previewURL'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['tags'] = tags;
    _data['previewURL'] = previewURL;
    return _data;
  }
}