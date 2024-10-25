class ImageModel {
  final int id;
  final String name;
  final String footer;
  final String url;

  ImageModel({
    required this.id,
    required this.name,
    required this.footer,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: int.parse(json['id']),
      name: json['name'],
      footer: json['footer'],
      url: json['url'],
    );
  }
}
