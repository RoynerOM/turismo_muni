import 'dart:convert';

List<LodgeModel> lodgeModelFromJson(String str) =>
    List<LodgeModel>.from(json.decode(str).map((x) => LodgeModel.fromJson(x)));

class LodgeModel {
  String id;
  String title;
  String description;
  String logo;
  List<Gallery> gallery;
  List<String> services;
  List<String> information;
  ContactModel contact;

  LodgeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.gallery,
    required this.services,
    required this.information,
    required this.contact,
  });

  factory LodgeModel.fromJson(Map<String, dynamic> json) => LodgeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        logo: json["logo"],
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        services: List<String>.from(json["services"].map((x) => x)),
        information: List<String>.from(json["information"].map((x) => x)),
        contact: ContactModel.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "logo": logo,
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x)),
        "information": List<dynamic>.from(information.map((x) => x)),
        "contact": contact.toJson(),
      };
}

class ContactModel {
  String phone;
  String page;
  String email;
  String place;

  ContactModel({
    required this.phone,
    required this.page,
    required this.email,
    required this.place,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        phone: json["phone"],
        page: json["page"],
        email: json["email"],
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "page": page,
        "email": email,
        "place": place,
      };
}

class Gallery {
  String url;
  String footer;

  Gallery({
    required this.url,
    required this.footer,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        url: json["url"],
        footer: json["footer"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "footer": footer,
      };
}
