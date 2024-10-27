import 'dart:convert';

List<AttractionsModel> attractiveModelFromJson(String str) =>
    List<AttractionsModel>.from(
        json.decode(str).map((x) => AttractionsModel.fromJson(x)));

class AttractionsModel {
  String id;
  String lodgeId;
  String category;
  String title;
  String imageUrl;

  AttractionsModel({
    required this.id,
    required this.lodgeId,
    required this.category,
    required this.title,
    required this.imageUrl,
  });

  factory AttractionsModel.fromJson(Map<String, dynamic> json) =>
      AttractionsModel(
        id: json["id"] ?? '',
        lodgeId: json["lodge_id"] ?? '',
        category: json["category"] ?? '',
        title: json["title"] ?? '',
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "lodge_id": lodgeId,
        "category": category,
        "title": title,
        "image_url": imageUrl,
      };
}
