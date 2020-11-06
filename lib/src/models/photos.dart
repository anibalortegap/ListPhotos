import 'dart:convert';

String photosToJson(List<Photos> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

List<Photos> photosFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Photos>.from(jsonData.map((x) => Photos.fromJson(x)));
}

class Photos {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photos({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photos.fromJson(Map<String, dynamic> json) => new Photos(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl']);

  Map<String, dynamic> toJson() => {
        'albunId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbaiUrl': thumbnailUrl
      };
}
