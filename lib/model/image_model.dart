import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) => List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  int? id;
  String? name;
  double? size;
  String? url;

  ImageModel({
    this.id,
    this.name,
    this.size,
    this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    name: json["name"],
    size: json["size"]?.toDouble(),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "size": size,
    "url": url,
  };
}
