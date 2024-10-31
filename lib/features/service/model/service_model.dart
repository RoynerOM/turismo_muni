import 'dart:convert';

List<ServiceModel> serviceModelFromJson(String str) => List<ServiceModel>.from(
    json.decode(str).map((x) => ServiceModel.fromJson(x)));

class ServiceModel {
  String id;
  String title;
  String description;
  String logo;
  List<Gallery> gallery;
  List<String> services;
  List<String> information;
  Contact contact;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.gallery,
    required this.services,
    required this.information,
    required this.contact,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        logo: json["logo"],
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        services: List<String>.from(json["services"].map((x) => x)),
        information: List<String>.from(json["information"].map((x) => x)),
        contact: Contact.fromJson(json["contact"]),
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

class Contact {
  String phone;
  String page;
  String email;
  String place;

  Contact({
    required this.phone,
    required this.page,
    required this.email,
    required this.place,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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
